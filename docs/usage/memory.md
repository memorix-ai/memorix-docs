# Memory Management

Learn about advanced memory management strategies and best practices for building effective AI memory systems.

## Memory Strategies

### 1. Conversation Memory

Store and retrieve conversation history for context-aware responses.

```python
from memorix import MemoryAPI
from datetime import datetime

class ConversationMemory:
    def __init__(self, user_id):
        self.memory = MemoryAPI(
            vector_store="chroma",
            embedder="sentence-transformers",
            collection_name=f"conversation_{user_id}"
        )
    
    def add_message(self, message, role="user", session_id=None):
        """Add a message to the conversation memory."""
        self.memory.store(
            text=message,
            metadata={
                "role": role,
                "session_id": session_id,
                "timestamp": datetime.now().isoformat(),
                "type": "conversation"
            }
        )
    
    def get_context(self, query, top_k=5, session_id=None):
        """Retrieve relevant conversation context."""
        filter_dict = {"type": "conversation"}
        if session_id:
            filter_dict["session_id"] = session_id
        
        return self.memory.retrieve(
            query=query,
            top_k=top_k,
            filter=filter_dict
        )
    
    def get_recent_context(self, hours=24, top_k=10):
        """Get recent conversation context."""
        from datetime import datetime, timedelta
        
        cutoff_time = (datetime.now() - timedelta(hours=hours)).isoformat()
        
        return self.memory.retrieve(
            query="recent conversation",
            top_k=top_k,
            filter={
                "type": "conversation",
                "timestamp": {"$gte": cutoff_time}
            }
        )
```

### 2. Knowledge Base Memory

Build and maintain a knowledge base for domain-specific information.

```python
class KnowledgeBase:
    def __init__(self, domain):
        self.memory = MemoryAPI(
            vector_store="chroma",
            embedder="sentence-transformers",
            collection_name=f"knowledge_{domain}"
        )
    
    def add_knowledge(self, content, category, source=None, tags=None):
        """Add knowledge to the base."""
        metadata = {
            "type": "knowledge",
            "category": category,
            "source": source,
            "tags": tags or [],
            "timestamp": datetime.now().isoformat()
        }
        
        return self.memory.store(text=content, metadata=metadata)
    
    def search_knowledge(self, query, category=None, tags=None, top_k=5):
        """Search knowledge base."""
        filter_dict = {"type": "knowledge"}
        
        if category:
            filter_dict["category"] = category
        
        if tags:
            filter_dict["tags"] = {"$in": tags}
        
        return self.memory.retrieve(
            query=query,
            top_k=top_k,
            filter=filter_dict
        )
    
    def update_knowledge(self, id, content, category=None, tags=None):
        """Update existing knowledge."""
        metadata = {}
        if category:
            metadata["category"] = category
        if tags:
            metadata["tags"] = tags
        
        return self.memory.update(id=id, text=content, metadata=metadata)
```

### 3. Episodic Memory

Store and retrieve specific events or experiences.

```python
class EpisodicMemory:
    def __init__(self):
        self.memory = MemoryAPI(
            vector_store="chroma",
            embedder="sentence-transformers",
            collection_name="episodic_memory"
        )
    
    def store_episode(self, event, location=None, participants=None, emotions=None):
        """Store an episodic memory."""
        metadata = {
            "type": "episode",
            "location": location,
            "participants": participants or [],
            "emotions": emotions or [],
            "timestamp": datetime.now().isoformat()
        }
        
        return self.memory.store(text=event, metadata=metadata)
    
    def recall_episodes(self, query, location=None, participants=None, top_k=5):
        """Recall relevant episodes."""
        filter_dict = {"type": "episode"}
        
        if location:
            filter_dict["location"] = location
        
        if participants:
            filter_dict["participants"] = {"$in": participants}
        
        return self.memory.retrieve(
            query=query,
            top_k=top_k,
            filter=filter_dict
        )
```

## Memory Lifecycle Management

### 1. Memory Retention Policies

Implement policies for managing memory retention and cleanup.

```python
class MemoryManager:
    def __init__(self, collection_name):
        self.memory = MemoryAPI(
            vector_store="chroma",
            embedder="sentence-transformers",
            collection_name=collection_name
        )
    
    def cleanup_old_memories(self, days_old=30):
        """Remove memories older than specified days."""
        from datetime import datetime, timedelta
        
        cutoff_date = (datetime.now() - timedelta(days=days_old)).isoformat()
        
        deleted_count = self.memory.delete_by_filter(
            filter={"timestamp": {"$lt": cutoff_date}}
        )
        
        print(f"Cleaned up {deleted_count} old memories")
        return deleted_count
    
    def archive_memories(self, filter_dict, archive_collection):
        """Archive memories to a separate collection."""
        # Retrieve memories to archive
        memories = self.memory.retrieve(
            query="",  # Empty query to get all matching
            top_k=1000,  # Large number to get all
            filter=filter_dict
        )
        
        # Store in archive collection
        archive_memory = MemoryAPI(
            vector_store="chroma",
            embedder="sentence-transformers",
            collection_name=archive_collection
        )
        
        for memory in memories:
            archive_memory.store(
                text=memory.text,
                metadata={**memory.metadata, "archived": True}
            )
        
        # Delete from original collection
        self.memory.delete_by_filter(filter=filter_dict)
        
        return len(memories)
    
    def get_memory_stats(self):
        """Get statistics about the memory collection."""
        total_count = self.memory.count()
        
        # Count by type
        conversation_count = self.memory.count(filter={"type": "conversation"})
        knowledge_count = self.memory.count(filter={"type": "knowledge"})
        episode_count = self.memory.count(filter={"type": "episode"})
        
        return {
            "total": total_count,
            "conversations": conversation_count,
            "knowledge": knowledge_count,
            "episodes": episode_count
        }
```

### 2. Memory Compression

Compress and summarize memories to save space while preserving important information.

```python
class MemoryCompressor:
    def __init__(self, memory_api):
        self.memory = memory_api
    
    def compress_conversation(self, session_id, max_memories=50):
        """Compress conversation memories by summarizing."""
        # Get all memories for the session
        memories = self.memory.retrieve(
            query="",
            top_k=max_memories,
            filter={"session_id": session_id, "type": "conversation"}
        )
        
        if len(memories) <= max_memories:
            return  # No compression needed
        
        # Group memories by time windows
        from datetime import datetime, timedelta
        
        # Create summary for each time window
        summaries = []
        window_size = timedelta(hours=1)
        
        # Implementation would group memories by time windows
        # and create summaries for each window
        
        # Store summaries and delete original memories
        for summary in summaries:
            self.memory.store(
                text=summary["text"],
                metadata={
                    **summary["metadata"],
                    "compressed": True,
                    "original_count": summary["original_count"]
                }
            )
        
        # Delete original memories
        self.memory.delete_by_filter(
            filter={"session_id": session_id, "type": "conversation", "compressed": {"$ne": True}}
        )
```

## Memory Optimization

### 1. Batch Operations

Use batch operations for better performance with large datasets.

```python
def batch_store_memories(memory_api, memories_data, batch_size=100):
    """Store memories in batches for better performance."""
    from tqdm import tqdm
    
    total_memories = len(memories_data)
    
    for i in tqdm(range(0, total_memories, batch_size), desc="Storing memories"):
        batch = memories_data[i:i + batch_size]
        
        texts = [item["text"] for item in batch]
        metadatas = [item["metadata"] for item in batch]
        
        memory_api.store_batch(texts, metadatas)
```

### 2. Memory Indexing

Create efficient indexes for frequently queried metadata.

```python
def create_memory_indexes(memory_api):
    """Create indexes for common query patterns."""
    # This would depend on the specific vector store implementation
    # For Chroma, indexes are created automatically
    # For other stores, you might need to create explicit indexes
    
    # Example for metadata fields that are frequently filtered
    common_filters = ["type", "category", "user_id", "session_id"]
    
    print("Memory indexes created for:", common_filters)
```

### 3. Memory Caching

Implement caching for frequently accessed memories.

```python
from functools import lru_cache
import hashlib

class CachedMemoryAPI:
    def __init__(self, memory_api, cache_size=1000):
        self.memory = memory_api
        self.cache_size = cache_size
    
    @lru_cache(maxsize=1000)
    def cached_retrieve(self, query_hash, top_k, filter_hash):
        """Cached version of retrieve method."""
        # Convert hashes back to original values
        # This is a simplified example
        return self.memory.retrieve(query_hash, top_k, filter_hash)
    
    def retrieve(self, query, top_k=5, filter=None):
        """Retrieve with caching."""
        # Create hash for caching
        query_hash = hashlib.md5(query.encode()).hexdigest()
        filter_hash = hashlib.md5(str(filter).encode()).hexdigest()
        
        return self.cached_retrieve(query_hash, top_k, filter_hash)
```

## Best Practices

### 1. Memory Organization

- Use consistent metadata schemas
- Implement hierarchical organization
- Use tags for flexible categorization
- Maintain clear naming conventions

### 2. Performance Optimization

- Use appropriate batch sizes
- Implement caching strategies
- Optimize query patterns
- Monitor memory usage

### 3. Data Quality

- Validate input data
- Implement deduplication
- Regular cleanup and maintenance
- Backup important memories

### 4. Privacy and Security

- Implement access controls
- Encrypt sensitive data
- Regular security audits
- Compliance with data regulations

## Monitoring and Analytics

```python
class MemoryAnalytics:
    def __init__(self, memory_api):
        self.memory = memory_api
    
    def get_usage_stats(self, days=30):
        """Get memory usage statistics."""
        from datetime import datetime, timedelta
        
        cutoff_date = (datetime.now() - timedelta(days=days)).isoformat()
        
        recent_memories = self.memory.retrieve(
            query="",
            top_k=10000,
            filter={"timestamp": {"$gte": cutoff_date}}
        )
        
        # Analyze usage patterns
        stats = {
            "total_memories": len(recent_memories),
            "by_type": {},
            "by_category": {},
            "storage_growth": 0
        }
        
        for memory in recent_memories:
            memory_type = memory.metadata.get("type", "unknown")
            stats["by_type"][memory_type] = stats["by_type"].get(memory_type, 0) + 1
            
            category = memory.metadata.get("category", "unknown")
            stats["by_category"][category] = stats["by_category"].get(category, 0) + 1
        
        return stats
```

## Next Steps

- **[Vector Stores](vectorstores.md)**: Learn about different storage backends
- **[Embedding Models](embeddings.md)**: Understand embedding options
- **[Examples](examples/basic.md)**: See real-world implementations
- **[API Reference](api/memory_api.md)**: Complete API documentation 
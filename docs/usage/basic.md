# Basic Usage

Learn the core concepts and common patterns for using Memorix AI effectively.

![Memorix AI Architecture](../img/image.png)

## Core Concepts

### MemoryAPI

The `MemoryAPI` class is the main interface for interacting with Memorix AI. It provides a unified way to work with different vector stores and embedding models.

```python
from memorix import MemoryAPI

memory = MemoryAPI(
    vector_store="chroma",      # Vector store backend
    embedder="sentence-transformers",  # Embedding model
    collection_name="my_collection"    # Collection name
)
```

### Key Components

1. **Vector Store**: Stores and retrieves vector embeddings
2. **Embedder**: Converts text to vector embeddings
3. **Collection**: A logical grouping of related memories
4. **Metadata**: Additional information stored with each memory

## Basic Operations

### Storing Memories

```python
# Simple storage
memory.store(
    text="Your text content here",
    metadata={"key": "value"}
)

# Batch storage
texts = ["Text 1", "Text 2", "Text 3"]
metadatas = [
    {"source": "doc1"},
    {"source": "doc2"},
    {"source": "doc3"}
]

memory.store_batch(texts, metadatas)
```

### Retrieving Memories

```python
# Basic retrieval
results = memory.retrieve(
    query="search query",
    top_k=5
)

# Retrieval with filters
results = memory.retrieve(
    query="search query",
    top_k=5,
    filter={"category": "programming"}
)

# Retrieval with score threshold
results = memory.retrieve(
    query="search query",
    top_k=5,
    score_threshold=0.7
)
```

### Updating Memories

```python
# Update by ID
memory.update(
    id="memory_id",
    text="Updated text",
    metadata={"updated": True}
)

# Update by filter
memory.update_by_filter(
    filter={"category": "old_category"},
    text="Updated text",
    metadata={"category": "new_category"}
)
```

### Deleting Memories

```python
# Delete by ID
memory.delete(id="memory_id")

# Delete by filter
memory.delete_by_filter(filter={"category": "obsolete"})

# Clear all memories
memory.clear()
```

## Advanced Features

### Metadata Filtering

```python
# Filter by exact match
results = memory.retrieve(
    query="python",
    filter={"language": "python"}
)

# Filter by multiple conditions
results = memory.retrieve(
    query="programming",
    filter={
        "language": "python",
        "difficulty": {"$in": ["beginner", "intermediate"]}
    }
)

# Filter by date range
results = memory.retrieve(
    query="recent topics",
    filter={
        "timestamp": {
            "$gte": "2024-01-01",
            "$lte": "2024-12-31"
        }
    }
)
```

### Batch Operations

```python
# Batch store with progress tracking
from tqdm import tqdm

texts = ["Text 1", "Text 2", "Text 3", ...]
metadatas = [{"id": i} for i in range(len(texts))]

for i in tqdm(range(0, len(texts), 100)):
    batch_texts = texts[i:i+100]
    batch_metadatas = metadatas[i:i+100]
    memory.store_batch(batch_texts, batch_metadatas)
```

### Custom Embeddings

```python
# Use pre-computed embeddings
import numpy as np

embeddings = np.random.rand(3, 384)  # 3 vectors of dimension 384
texts = ["Text 1", "Text 2", "Text 3"]
metadatas = [{"custom": True} for _ in texts]

memory.store_with_embeddings(texts, embeddings, metadatas)
```

## Configuration Options

### Vector Store Configuration

```python
# Chroma configuration
memory = MemoryAPI(
    vector_store="chroma",
    embedder="sentence-transformers",
    collection_name="my_collection",
    vector_store_config={
        "persist_directory": "./chroma_db",
        "anonymized_telemetry": False
    }
)

# Pinecone configuration
memory = MemoryAPI(
    vector_store="pinecone",
    embedder="openai",
    collection_name="my_collection",
    vector_store_config={
        "api_key": "your_api_key",
        "environment": "us-west1-gcp",
        "dimension": 1536
    }
)
```

### Embedder Configuration

```python
# Sentence Transformers configuration
memory = MemoryAPI(
    vector_store="chroma",
    embedder="sentence-transformers",
    collection_name="my_collection",
    embedder_config={
        "model_name": "all-MiniLM-L6-v2",
        "device": "cuda"  # or "cpu"
    }
)

# OpenAI configuration
memory = MemoryAPI(
    vector_store="chroma",
    embedder="openai",
    collection_name="my_collection",
    embedder_config={
        "api_key": "your_openai_api_key",
        "model": "text-embedding-ada-002"
    }
)
```

## Best Practices

### 1. Collection Naming

```python
# Use descriptive collection names
memory = MemoryAPI(
    vector_store="chroma",
    embedder="sentence-transformers",
    collection_name="customer_support_2024"
)
```

### 2. Metadata Design

```python
# Use consistent metadata structure
metadata = {
    "source": "document_name",
    "timestamp": "2024-01-01T12:00:00Z",
    "category": "topic_category",
    "user_id": "user_identifier",
    "version": "1.0"
}
```

### 3. Error Handling

```python
try:
    results = memory.retrieve(query="search", top_k=5)
except Exception as e:
    print(f"Retrieval failed: {e}")
    # Fallback to default behavior
    results = []
```

### 4. Performance Optimization

```python
# Use batch operations for large datasets
# Set appropriate batch sizes
BATCH_SIZE = 100

# Use filters to reduce search space
results = memory.retrieve(
    query="search",
    top_k=5,
    filter={"recent": True}  # Only search recent items
)
```

## Common Patterns

### Conversation Memory

```python
class ConversationMemory:
    def __init__(self, user_id):
        self.memory = MemoryAPI(
            vector_store="chroma",
            embedder="sentence-transformers",
            collection_name=f"conversation_{user_id}"
        )
    
    def add_message(self, message, role="user"):
        self.memory.store(
            text=message,
            metadata={
                "role": role,
                "timestamp": datetime.now().isoformat()
            }
        )
    
    def get_context(self, query, top_k=5):
        return self.memory.retrieve(query, top_k=top_k)
```

### Document Search

```python
class DocumentSearch:
    def __init__(self):
        self.memory = MemoryAPI(
            vector_store="chroma",
            embedder="sentence-transformers",
            collection_name="documents"
        )
    
    def index_document(self, doc_id, content, metadata=None):
        self.memory.store(
            text=content,
            metadata={
                "doc_id": doc_id,
                **(metadata or {})
            }
        )
    
    def search_documents(self, query, top_k=10):
        return self.memory.retrieve(query, top_k=top_k)
```

## Next Steps

- **[Memory Management](memory.md)**: Learn about advanced memory strategies
- **[Vector Stores](vectorstores.md)**: Compare different storage backends
- **[Embedding Models](embeddings.md)**: Understand embedding options
- **[API Reference](api/memory_api.md)**: Complete API documentation 
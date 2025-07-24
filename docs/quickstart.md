# Quick Start

Get up and running with Memorix AI in under 5 minutes!

<div class="center-logo">

![Memorix AI Quick Start](../img/MEMORIX-AI.png)

</div>

## Prerequisites

- Python 3.8+
- Memorix AI installed (`pip install memorix`)
- Basic Python knowledge

## Your First Memory System

### 1. Basic Setup

```python
from memorix import MemoryAPI

# Create a simple memory system
memory = MemoryAPI(
    vector_store="chroma",  # Use Chroma as vector store
    embedder="sentence-transformers",  # Use sentence transformers
    collection_name="my_first_memory"
)
```

### 2. Store Your First Memory

```python
# Store some text with metadata
memory.store(
    text="Python is a high-level programming language known for its simplicity and readability.",
    metadata={
        "topic": "programming",
        "language": "python",
        "difficulty": "beginner"
    }
)

# Store more memories
memory.store(
    text="Machine learning is a subset of artificial intelligence that enables computers to learn without being explicitly programmed.",
    metadata={
        "topic": "AI/ML",
        "language": "python",
        "difficulty": "intermediate"
    }
)

memory.store(
    text="Vector databases store and retrieve high-dimensional vectors efficiently for similarity search.",
    metadata={
        "topic": "databases",
        "language": "python",
        "difficulty": "advanced"
    }
)
```

### 3. Retrieve Relevant Memories

```python
# Search for programming-related content
results = memory.retrieve(
    query="programming languages",
    top_k=3
)

print("Search Results:")
for i, result in enumerate(results, 1):
    print(f"{i}. {result.text}")
    print(f"   Metadata: {result.metadata}")
    print(f"   Score: {result.score:.3f}\n")
```

### 4. Update and Delete Memories

```python
# Update a memory (if you have the ID)
# memory.update(id="memory_id", text="Updated text", metadata={"updated": True})

# Delete a memory
# memory.delete(id="memory_id")

# Clear all memories
# memory.clear()
```

## Advanced Quick Start

### Using Different Vector Stores

```python
# With Pinecone
memory_pinecone = MemoryAPI(
    vector_store="pinecone",
    embedder="openai",
    collection_name="pinecone_memories",
    vector_store_config={
        "api_key": "your_pinecone_api_key",
        "environment": "your_environment"
    }
)

# With Weaviate
memory_weaviate = MemoryAPI(
    vector_store="weaviate",
    embedder="sentence-transformers",
    collection_name="weaviate_memories",
    vector_store_config={
        "url": "http://localhost:8080"
    }
)
```

### Using Different Embedding Models

```python
# OpenAI embeddings
memory_openai = MemoryAPI(
    vector_store="chroma",
    embedder="openai",
    collection_name="openai_memories",
    embedder_config={
        "api_key": "your_openai_api_key"
    }
)

# Custom Hugging Face model
memory_hf = MemoryAPI(
    vector_store="chroma",
    embedder="sentence-transformers",
    collection_name="hf_memories",
    embedder_config={
        "model_name": "all-MiniLM-L6-v2"
    }
)
```

## Complete Example

Here's a complete example that demonstrates a simple chatbot with memory:

```python
from memorix import MemoryAPI

class ChatbotWithMemory:
    def __init__(self):
        self.memory = MemoryAPI(
            vector_store="chroma",
            embedder="sentence-transformers",
            collection_name="chatbot_memory"
        )
    
    def chat(self, user_input):
        # Store user input
        self.memory.store(
            text=user_input,
            metadata={
                "type": "user_input",
                "timestamp": "2024-01-01T12:00:00Z"
            }
        )
        
        # Retrieve relevant context
        context = self.memory.retrieve(
            query=user_input,
            top_k=3
        )
        
        # Generate response (simplified)
        response = f"Based on our conversation history, here's what I found relevant: {[r.text for r in context]}"
        
        # Store response
        self.memory.store(
            text=response,
            metadata={
                "type": "bot_response",
                "timestamp": "2024-01-01T12:00:01Z"
            }
        )
        
        return response

# Usage
chatbot = ChatbotWithMemory()
response = chatbot.chat("Tell me about Python programming")
print(response)
```

## What's Next?

Now that you have the basics, explore:

- **[Basic Usage](usage/basic.md)**: Learn about advanced features
- **[Memory Management](usage/memory.md)**: Understand memory strategies
- **[Vector Stores](usage/vectorstores.md)**: Compare different storage options
- **[Examples](examples/basic.md)**: See more complex use cases

## Need Help?

- Check the [API Reference](api/memory_api.md) for detailed documentation
- Join our [Discussions](https://github.com/memorix-ai/memorix-sdk/discussions)
- Report issues on [GitHub](https://github.com/memorix-ai/memorix-sdk/issues) 
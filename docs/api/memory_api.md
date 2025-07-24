# Memory API Reference

Complete reference for the `MemoryAPI` class and its methods.

## MemoryAPI

The main interface for interacting with Memorix AI memory systems.

### Constructor

```python
MemoryAPI(
    vector_store: str,
    embedder: str,
    collection_name: str,
    vector_store_config: Optional[Dict] = None,
    embedder_config: Optional[Dict] = None
)
```

**Parameters:**

- `vector_store` (str): Vector store backend ("chroma", "pinecone", "weaviate", etc.)
- `embedder` (str): Embedding model ("sentence-transformers", "openai", etc.)
- `collection_name` (str): Name of the collection to use
- `vector_store_config` (Dict, optional): Configuration for the vector store
- `embedder_config` (Dict, optional): Configuration for the embedder

**Example:**

```python
from memorix import MemoryAPI

memory = MemoryAPI(
    vector_store="chroma",
    embedder="sentence-transformers",
    collection_name="my_collection",
    vector_store_config={
        "persist_directory": "./data"
    },
    embedder_config={
        "model_name": "all-MiniLM-L6-v2"
    }
)
```

## Methods

### store()

Store a single text with metadata.

```python
store(
    text: str,
    metadata: Optional[Dict] = None,
    id: Optional[str] = None
) -> str
```

**Parameters:**

- `text` (str): The text content to store
- `metadata` (Dict, optional): Additional metadata
- `id` (str, optional): Custom ID for the memory

**Returns:**

- `str`: The ID of the stored memory

**Example:**

```python
memory_id = memory.store(
    text="Python is a programming language",
    metadata={
        "topic": "programming",
        "language": "python"
    }
)
print(f"Stored memory with ID: {memory_id}")
```

### store_batch()

Store multiple texts with metadata in batch.

```python
store_batch(
    texts: List[str],
    metadatas: Optional[List[Dict]] = None,
    ids: Optional[List[str]] = None
) -> List[str]
```

**Parameters:**

- `texts` (List[str]): List of text contents to store
- `metadatas` (List[Dict], optional): List of metadata dictionaries
- `ids` (List[str], optional): List of custom IDs

**Returns:**

- `List[str]`: List of IDs for the stored memories

**Example:**

```python
texts = ["Text 1", "Text 2", "Text 3"]
metadatas = [
    {"source": "doc1"},
    {"source": "doc2"},
    {"source": "doc3"}
]

memory_ids = memory.store_batch(texts, metadatas)
print(f"Stored {len(memory_ids)} memories")
```

### retrieve()

Retrieve memories based on a query.

```python
retrieve(
    query: str,
    top_k: int = 5,
    filter: Optional[Dict] = None,
    score_threshold: Optional[float] = None
) -> List[MemoryResult]
```

**Parameters:**

- `query` (str): The search query
- `top_k` (int): Number of results to return
- `filter` (Dict, optional): Metadata filter
- `score_threshold` (float, optional): Minimum similarity score

**Returns:**

- `List[MemoryResult]`: List of memory results

**Example:**

```python
results = memory.retrieve(
    query="programming languages",
    top_k=5,
    filter={"category": "programming"},
    score_threshold=0.7
)

for result in results:
    print(f"Text: {result.text}")
    print(f"Score: {result.score}")
    print(f"Metadata: {result.metadata}")
    print(f"ID: {result.id}")
```

### update()

Update an existing memory by ID.

```python
update(
    id: str,
    text: Optional[str] = None,
    metadata: Optional[Dict] = None
) -> bool
```

**Parameters:**

- `id` (str): The ID of the memory to update
- `text` (str, optional): New text content
- `metadata` (Dict, optional): New metadata

**Returns:**

- `bool`: True if update was successful

**Example:**

```python
success = memory.update(
    id="memory_123",
    text="Updated text content",
    metadata={"updated": True, "timestamp": "2024-01-01"}
)
```

### update_by_filter()

Update memories that match a filter.

```python
update_by_filter(
    filter: Dict,
    text: Optional[str] = None,
    metadata: Optional[Dict] = None
) -> int
```

**Parameters:**

- `filter` (Dict): Metadata filter to match memories
- `text` (str, optional): New text content
- `metadata` (Dict, optional): New metadata

**Returns:**

- `int`: Number of memories updated

**Example:**

```python
updated_count = memory.update_by_filter(
    filter={"category": "old_category"},
    metadata={"category": "new_category"}
)
print(f"Updated {updated_count} memories")
```

### delete()

Delete a memory by ID.

```python
delete(id: str) -> bool
```

**Parameters:**

- `id` (str): The ID of the memory to delete

**Returns:**

- `bool`: True if deletion was successful

**Example:**

```python
success = memory.delete(id="memory_123")
```

### delete_by_filter()

Delete memories that match a filter.

```python
delete_by_filter(filter: Dict) -> int
```

**Parameters:**

- `filter` (Dict): Metadata filter to match memories

**Returns:**

- `int`: Number of memories deleted

**Example:**

```python
deleted_count = memory.delete_by_filter(
    filter={"category": "obsolete"}
)
print(f"Deleted {deleted_count} memories")
```

### clear()

Clear all memories in the collection.

```python
clear() -> bool
```

**Returns:**

- `bool`: True if clear was successful

**Example:**

```python
success = memory.clear()
```

### count()

Get the number of memories in the collection.

```python
count(filter: Optional[Dict] = None) -> int
```

**Parameters:**

- `filter` (Dict, optional): Metadata filter

**Returns:**

- `int`: Number of memories

**Example:**

```python
total_count = memory.count()
filtered_count = memory.count(filter={"category": "programming"})
```

### get_by_id()

Get a specific memory by ID.

```python
get_by_id(id: str) -> Optional[MemoryResult]
```

**Parameters:**

- `id` (str): The ID of the memory

**Returns:**

- `Optional[MemoryResult]`: Memory result or None if not found

**Example:**

```python
memory_result = memory.get_by_id("memory_123")
if memory_result:
    print(f"Found: {memory_result.text}")
```

### list_collections()

List all available collections.

```python
list_collections() -> List[str]
```

**Returns:**

- `List[str]`: List of collection names

**Example:**

```python
collections = memory.list_collections()
print(f"Available collections: {collections}")
```

## MemoryResult

The result object returned by retrieval operations.

### Attributes

- `id` (str): Memory ID
- `text` (str): Text content
- `metadata` (Dict): Metadata dictionary
- `score` (float): Similarity score
- `embedding` (Optional[np.ndarray]): Vector embedding

### Example

```python
results = memory.retrieve("python programming", top_k=1)
if results:
    result = results[0]
    print(f"ID: {result.id}")
    print(f"Text: {result.text}")
    print(f"Score: {result.score}")
    print(f"Metadata: {result.metadata}")
```

## Error Handling

### Common Exceptions

```python
from memorix import MemoryAPI, MemoryError

try:
    memory = MemoryAPI(
        vector_store="invalid_store",
        embedder="sentence-transformers",
        collection_name="test"
    )
except MemoryError as e:
    print(f"Memory error: {e}")
except Exception as e:
    print(f"Unexpected error: {e}")
```

### Connection Errors

```python
try:
    results = memory.retrieve("query")
except ConnectionError:
    print("Vector store connection failed")
    # Implement fallback logic
```

## Configuration Examples

### Chroma Configuration

```python
memory = MemoryAPI(
    vector_store="chroma",
    embedder="sentence-transformers",
    collection_name="my_collection",
    vector_store_config={
        "persist_directory": "./chroma_db",
        "anonymized_telemetry": False,
        "allow_reset": True
    }
)
```

### Pinecone Configuration

```python
memory = MemoryAPI(
    vector_store="pinecone",
    embedder="openai",
    collection_name="my_collection",
    vector_store_config={
        "api_key": "your_pinecone_api_key",
        "environment": "us-west1-gcp",
        "dimension": 1536,
        "metric": "cosine"
    }
)
```

### OpenAI Embedder Configuration

```python
memory = MemoryAPI(
    vector_store="chroma",
    embedder="openai",
    collection_name="my_collection",
    embedder_config={
        "api_key": "your_openai_api_key",
        "model": "text-embedding-ada-002",
        "chunk_size": 1000
    }
)
```

## Performance Tips

### Batch Operations

```python
# Use batch operations for large datasets
BATCH_SIZE = 100
texts = ["Text 1", "Text 2", ...]  # Large list

for i in range(0, len(texts), BATCH_SIZE):
    batch = texts[i:i + BATCH_SIZE]
    memory.store_batch(batch)
```

### Filtering

```python
# Use filters to improve performance
results = memory.retrieve(
    query="search",
    filter={"recent": True}  # Only search recent items
)
```

### Score Thresholds

```python
# Use score thresholds to get only relevant results
results = memory.retrieve(
    query="search",
    score_threshold=0.8  # Only results with 80%+ similarity
)
``` 
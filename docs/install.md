# Installation

This guide will help you install Memorix AI and get it running on your system.

## System Requirements

- **Python**: 3.8 or higher
- **Operating System**: Windows, macOS, or Linux
- **Memory**: At least 4GB RAM (8GB recommended for large datasets)
- **Storage**: 1GB free space for the package and dependencies

## Installation Methods

### Method 1: Install from PyPI (Recommended)

```bash
pip install memorix
```

### Method 2: Install with Optional Dependencies

```bash
# Install with all vector store backends
pip install memorix[all]

# Install with specific backends
pip install memorix[chroma,pinecone,weaviate]
```

### Method 3: Install from Source

```bash
# Clone the repository
git clone https://github.com/memorix-ai/memorix-sdk.git
cd memorix-sdk

# Install in development mode
pip install -e .
```

## Vector Store Dependencies

Memorix AI supports multiple vector stores. Install the ones you need:

### Chroma (Default)
```bash
pip install chromadb
```

### Pinecone
```bash
pip install pinecone-client
```

### Weaviate
```bash
pip install weaviate-client
```

### Qdrant
```bash
pip install qdrant-client
```

### Milvus
```bash
pip install pymilvus
```

## Embedding Model Dependencies

### OpenAI Embeddings
```bash
pip install openai
```

### Hugging Face Transformers
```bash
pip install transformers torch
```

### Sentence Transformers
```bash
pip install sentence-transformers
```

## Environment Setup

### 1. Set Environment Variables

Create a `.env` file in your project directory:

```bash
# OpenAI API Key (for OpenAI embeddings)
OPENAI_API_KEY=your_openai_api_key_here

# Pinecone API Key (if using Pinecone)
PINECONE_API_KEY=your_pinecone_api_key_here
PINECONE_ENVIRONMENT=your_pinecone_environment

# Weaviate API Key (if using Weaviate)
WEAVIATE_API_KEY=your_weaviate_api_key_here
```

### 2. Load Environment Variables

```python
import os
from dotenv import load_dotenv

load_dotenv()
```

## Verification

Test your installation:

```python
from memorix import MemoryAPI

# Test basic functionality
try:
    memory = MemoryAPI(
        vector_store="chroma",
        embedder="sentence-transformers",
        collection_name="test"
    )
    print("✅ Memorix AI installed successfully!")
except Exception as e:
    print(f"❌ Installation issue: {e}")
```

## Troubleshooting

### Common Issues

#### 1. Import Errors
```bash
# Reinstall with force
pip install --force-reinstall memorix
```

#### 2. Vector Store Connection Issues
- Check if the vector store service is running
- Verify API keys and environment variables
- Ensure network connectivity

#### 3. Memory Issues
- Reduce batch size for large datasets
- Use smaller embedding models
- Consider using external vector stores

#### 4. CUDA/GPU Issues
```bash
# Install CPU-only version
pip install torch --index-url https://download.pytorch.org/whl/cpu
```

### Getting Help

If you encounter issues:

1. Check the [GitHub Issues](https://github.com/memorix-ai/memorix-sdk/issues)
2. Search existing discussions
3. Create a new issue with:
   - Python version
   - Operating system
   - Error message
   - Steps to reproduce

## Next Steps

After installation, check out:

- **[Quick Start Guide](quickstart.md)**: Get up and running in minutes
- **[Basic Usage](usage/basic.md)**: Learn the core concepts
- **[Examples](examples/basic.md)**: See real-world usage patterns 
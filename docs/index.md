# Welcome to Memorix AI

<div class="hero-section">

<div class="center-logo">

![Memorix AI Logo](../img/MEMORIX-AI.png)

</div>

**AI Memory Management Framework**

[![PyPI version](https://badge.fury.io/py/memorix.svg)](https://badge.fury.io/py/memorix)
[![License: Apache 2.0](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![Python 3.8+](https://img.shields.io/badge/python-3.8+-blue.svg)](https://www.python.org/downloads/)

</div>

## What is Memorix AI?

Memorix AI is a powerful Python framework designed to manage and enhance AI memory systems. It provides a unified interface for working with various vector stores, embedding models, and memory management strategies.

### Key Features

<div class="feature-grid">

<div class="feature-card">

#### 🧠 Intelligent Memory Management
Store, retrieve, and manage AI conversation history and knowledge with advanced semantic search capabilities.

</div>

<div class="feature-card">

#### 🔍 Multi-Vector Store Support
Work with Chroma, Pinecone, Weaviate, and more vector databases seamlessly through a unified API.

</div>

<div class="feature-card">

#### 🎯 Flexible Embedding Models
Support for OpenAI, Hugging Face, and custom embedding models to match your specific needs.

</div>

<div class="feature-card">

#### ⚡ High Performance
Optimized for speed and efficiency with batch operations and intelligent caching.

</div>

<div class="feature-card">

#### 🔧 Easy Integration
Simple API that works with any AI framework - from chatbots to knowledge bases.

</div>

<div class="feature-card">

#### 📊 Rich Metadata
Store and query contextual information alongside embeddings for powerful filtering and organization.

</div>

</div>

![Memorix AI Architecture](../img/image.png)

### Quick Start

```python
from memorix import MemoryAPI

# Initialize memory system
memory = MemoryAPI(
    vector_store="chroma",
    embedder="openai",
    collection_name="my_chatbot"
)

# Store a conversation
memory.store(
    text="User asked about Python programming",
    metadata={"user_id": "123", "timestamp": "2024-01-01"}
)

# Retrieve relevant memories
results = memory.retrieve(
    query="Python programming help",
    top_k=5
)
```

### Installation

```bash
pip install memorix
```

### Documentation Sections

<div class="feature-grid">

<div class="feature-card">

#### 📚 Installation
Get started with Memorix AI in minutes with our comprehensive installation guide.

<a href="install.md" class="md-button">Get Started</a>

</div>

<div class="feature-card">

#### 🚀 Quick Start
Build your first memory system with step-by-step tutorials and examples.

<a href="quickstart.md" class="md-button">Start Building</a>

</div>

<div class="feature-card">

#### 📖 User Guide
Learn the core concepts and advanced features of Memorix AI.

<a href="usage/basic.md" class="md-button">Learn More</a>

</div>

<div class="feature-card">

#### 🔧 API Reference
Complete API documentation with examples and best practices.

<a href="api/memory_api.md" class="md-button">View API</a>

</div>

<div class="feature-card">

#### 💡 Examples
Real-world usage examples and implementation patterns.

<a href="examples/basic.md" class="md-button">See Examples</a>

</div>

<div class="feature-card">

#### 🤝 Contributing
Join our community and help improve Memorix AI.

<a href="contributing.md" class="md-button">Contribute</a>

</div>

</div>

### Community

<div class="footer-section">

- 📖 [Documentation](https://memorix-ai.github.io/memorix-docs/)
- 🐛 [Report Issues](https://github.com/memorix-ai/memorix-sdk/issues)
- 💬 [Discussions](https://github.com/memorix-ai/memorix-sdk/discussions)
- 🤝 [Contributing](contributing.md)

### License

Memorix AI is licensed under the Apache 2.0 License. See the [LICENSE](../LICENSE) file for details.

**Built with ❤️ by the Memorix AI Team**

</div> 
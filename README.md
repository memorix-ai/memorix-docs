# Memorix AI Documentation

[![Deploy Documentation](https://github.com/memorix-ai/memorix-docs/workflows/Deploy%20Documentation/badge.svg)](https://github.com/memorix-ai/memorix-docs/actions)
[![Test Documentation](https://github.com/memorix-ai/memorix-docs/workflows/Test%20Documentation/badge.svg)](https://github.com/memorix-ai/memorix-docs/actions)
[![GitHub Pages](https://img.shields.io/badge/GitHub%20Pages-Live-blue)](https://memorix-ai.github.io/memorix-docs/)

This repository contains the documentation for Memorix AI, hosted using MkDocs with the Material theme.

## 🚀 Quick Start

### Local Development

1. **Install dependencies:**
   ```bash
   pip install -r requirements.txt
   ```

2. **Serve locally:**
   ```bash
   mkdocs serve
   ```

3. **View documentation:**
   Open http://127.0.0.1:8000 in your browser

### Building for Production

```bash
# Build static site
mkdocs build

# Deploy to GitHub Pages
mkdocs gh-deploy

# Or use the deployment script
./deploy.sh
```

## 📁 Project Structure

```
memorix-docs/
├── docs/                    # Documentation source files
│   ├── index.md            # Homepage
│   ├── install.md          # Installation guide
│   ├── quickstart.md       # Quick start guide
│   ├── usage/              # Usage guides
│   │   ├── basic.md
│   │   ├── memory.md
│   │   ├── vectorstores.md
│   │   └── embeddings.md
│   ├── api/                # API reference
│   │   ├── memory_api.md
│   │   ├── vector_store.md
│   │   ├── embedder.md
│   │   └── config.md
│   ├── examples/           # Code examples
│   │   ├── basic.md
│   │   ├── chatbot.md
│   │   └── knowledge_base.md
│   ├── stylesheets/        # Custom CSS styles
│   │   └── extra.css
│   └── contributing.md     # Contributing guide
├── img/                    # Images and assets
│   ├── MEMORIX-AI.png     # Main logo
│   └── image.png          # Architecture diagram
├── mkdocs.yml             # MkDocs configuration
├── requirements.txt       # Python dependencies
├── deploy.sh              # Deployment script
└── README.md             # This file
```

## 🛠️ Configuration

The documentation is configured in `mkdocs.yml` with the following features:

- **Material Theme**: Modern, responsive design
- **Navigation**: Hierarchical navigation structure
- **Search**: Full-text search functionality
- **Code Highlighting**: Syntax highlighting for code blocks
- **Admonitions**: Callouts for notes, warnings, etc.
- **Tabs**: Tabbed content for multiple code examples
- **Git Integration**: Last updated dates from git
- **Custom Styling**: Enhanced visual design with custom CSS
- **Branded Images**: Memorix AI logo and architecture diagrams

## 🖼️ Images and Assets

The documentation includes branded images:

- **`img/MEMORIX-AI.png`**: Main Memorix AI logo used throughout the documentation
- **`img/image.png`**: Architecture diagram showing the Memorix AI system components

These images are automatically styled and responsive across different screen sizes.

## 📝 Writing Documentation

### Adding New Pages

1. Create a new `.md` file in the appropriate directory
2. Add the page to the navigation in `mkdocs.yml`
3. Use the standard Markdown syntax

### Code Examples

```markdown
```python
from memorix import MemoryAPI

memory = MemoryAPI(
    vector_store="chroma",
    embedder="sentence-transformers",
    collection_name="example"
)
```
```

### Admonitions

```markdown
!!! note "Note"
    This is a note.

!!! warning "Warning"
    This is a warning.

!!! tip "Tip"
    This is a tip.
```

### Tabs

```markdown
=== "Python"
    ```python
    print("Hello, World!")
    ```

=== "JavaScript"
    ```javascript
    console.log("Hello, World!");
    ```
```

## 🌐 Deployment

### Automated CI/CD

The documentation uses GitHub Actions for automated testing and deployment:

- **Automatic Testing**: Every push and PR is tested for build issues
- **Preview Deployments**: PRs get preview URLs for review
- **Automatic Deployment**: Main branch changes are deployed to GitHub Pages
- **Dependency Updates**: Dependabot automatically updates dependencies

### GitHub Pages

The documentation is automatically deployed to GitHub Pages when you push to the `main` branch.

**Manual deployment:**
```bash
mkdocs gh-deploy
```

**Site URL:** https://memorix-ai.github.io/memorix-docs/

### CI/CD Workflows

- **Test Documentation** (`.github/workflows/test.yml`): Validates builds and checks for issues
- **Deploy Documentation** (`.github/workflows/deploy.yml`): Builds and deploys to GitHub Pages
- **Preview Documentation** (`.github/workflows/preview.yml`): Creates preview deployments for PRs
- **Dependabot Auto-merge** (`.github/workflows/dependabot.yml`): Handles dependency updates

For detailed information, see [CI/CD and Deployment](docs/contributing/ci-cd.md).

### Custom Domain

To use a custom domain:

1. Add a `CNAME` file to the `docs/` directory
2. Configure your domain provider
3. Update `mkdocs.yml` with the custom domain

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test locally with `mkdocs serve`
5. Submit a pull request

### Documentation Guidelines

- Use clear, concise language
- Include code examples
- Add screenshots for UI elements
- Keep content up to date
- Follow the existing style guide

## 📚 Resources

- [MkDocs Documentation](https://www.mkdocs.org/)
- [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)
- [Markdown Guide](https://www.markdownguide.org/)

## 📄 License

This documentation is licensed under the Apache 2.0 License. See the [LICENSE](LICENSE) file for details.

---

**Built with ❤️ by the Memorix AI Team** 
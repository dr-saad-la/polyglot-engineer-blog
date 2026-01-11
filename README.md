# The Polyglot Engineer Blog

Professional technical blog covering Production ML Systems, Multi-language Development, and Modern DevOps.

## Quick Start

### Prerequisites

- UV package manager
- Git
- Python 3.12+

### Local Development

```bash
# Clone repository
git clone https://github.com/dr-saad-la/polyglot-engineer-blog.git
cd polyglot-engineer-blog

# Install dependencies (creates virtual environment automatically)
uv sync

# Serve locally
uv run mkdocs serve
```

Visit: http://127.0.0.1:8000

### Deployment
```bash
# Deploy to GitHub Pages
uv run mkdocs gh-deploy
```

Or push to `main` branch - GitHub Actions will deploy automatically.

## 📁 Project Structure

- `docs/` - Content (Markdown files)
- `notes/` - Private notes (ignored by git)
- `mkdocs.yml` - Configuration
- `pyproject.toml` - Python dependencies
- `.github/workflows/` - CI/CD automation

## 📝 Writing Content

Create new post:
```bash
# Blog post
touch docs/blog/2024-01-15-new-post.md

# Tutorial
touch docs/tutorials/new-tutorial.md
```

Preview changes:
```bash
uv run mkdocs serve
```

## 🛠️ Technology Stack

- **Generator:** MkDocs Material
- **Language:** Python 3.12
- **Package Manager:** UV
- **Deployment:** GitHub Pages
- **CI/CD:** GitHub Actions

## 📄 License

Copyright © 2026 Dr. Saad Laouadi. All rights reserved.

## 📧 Contact

- **Email:** dr.saad.laouadi@gmail.com
- **LinkedIn:** [saad-laouadi](https://linkedin.com/in/dr-saad-laouadi)
- **GitHub:** [dr-saad-la](https://github.com/dr-saad-la)

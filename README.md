# The Polyglot Engineer

> Production ML Systems, Multi-language Development, and Modern DevOps

Professional technical blog sharing insights from building scalable AI applications across Python, Rust, Java, JavaScript, TypeScript, Julia, and R.

[![Live Site](https://img.shields.io/badge/Live-Site-blue)](https://dr-saad-la.github.io/polyglot-engineer-blog/)
[![GitHub](https://img.shields.io/badge/GitHub-Repository-181717?logo=github)](https://github.com/dr-saad-la/polyglot-engineer-blog)
[![License](https://img.shields.io/badge/License-All%20Rights%20Reserved-red)]()

---

## 🚀 Quick Start

### Prerequisites

- [UV](https://github.com/astral-sh/uv) - Fast Python package manager
- [just](https://just.systems/) - Command runner
- Git
- Python 3.12+

### Installation

```bash
# Clone repository
git clone https://github.com/dr-saad-la/polyglot-engineer-blog.git
cd polyglot-engineer-blog

# Install dependencies
just install

# Serve locally
just serve
```

Visit: **http://127.0.0.1:8000/polyglot-engineer-blog/**

---

## 📁 Project Structure

```
polyglot-engineer-blog/
├── docs/                          # Published content
│   ├── blog/
│   │   ├── posts/                 # Blog posts
│   │   ├── .authors.yml           # Author profiles
│   │   └── index.md               # Blog index
│   ├── tutorials/                 # Step-by-step tutorials
│   ├── guides/                    # Comprehensive guides
│   ├── projects/                  # Project showcases
│   ├── resources/                 # Curated resources
│   └── index.md                   # Homepage
│
├── notes/
│   └── drafts/                    # Work in progress (git-ignored)
│       ├── blog/
│       ├── tutorials/
│       └── guides/
│
├── mkdocs.yml                     # Site configuration
├── pyproject.toml                 # Python dependencies
├── justfile                       # Command runner tasks
└── .github/workflows/             # CI/CD automation
```

---

## ✍️ Content Workflow

### Writing a Blog Post

```bash
# 1. Create draft
just create-post-draft "Your Post Title"

# 2. Write content
code notes/drafts/blog/posts/2026-01-29-your-post-title.md

# 3. Preview (optional)
just serve

# 4. Publish when ready
just publish-draft blog/posts/2026-01-29-your-post-title

# 5. Commit and deploy
git add docs/blog/posts/2026-01-29-your-post-title.md
git commit -m "Add: Your Post Title"
git push origin main
just deploy
```

### Writing a Tutorial

```bash
# 1. Create draft
just create-tutorial-draft "Your Tutorial Title"

# 2. Write content
code notes/drafts/tutorials/your-tutorial-title.md

# 3. Publish
just publish-draft tutorials/your-tutorial-title

# 4. Commit and deploy
git add docs/tutorials/your-tutorial-title.md
git commit -m "Add: Your Tutorial Title"
git push origin main
just deploy
```

### Writing a Guide

```bash
# 1. Create draft
just create-guide-draft "Your Guide Title"

# 2. Write content
code notes/drafts/guides/your-guide-title.md

# 3. Publish
just publish-draft guides/your-guide-title

# 4. Commit and deploy
git add docs/guides/your-guide-title.md
git commit -m "Add: Your Guide Title"
git push origin main
just deploy
```

---

## 🛠️ Available Commands

### Development

```bash
just install          # Install dependencies
just serve            # Start development server
just build            # Build static site
just clean            # Clean build artifacts
```

### Content Creation

```bash
just create-post-draft "Title"      # New blog post draft
just create-tutorial-draft "Title"  # New tutorial draft
just create-guide-draft "Title"     # New guide draft
just publish-draft path/to/file     # Publish draft to docs/
```

### Deployment

```bash
just deploy           # Deploy to GitHub Pages
just check            # Run quality checks
```

### Utilities

```bash
just stats            # Show content statistics
just recent-posts     # List recent blog posts
just recent-tutorials # List recent tutorials
```

---

## 📝 Content Guidelines

### Blog Posts

**Location:** `docs/blog/posts/YYYY-MM-DD-title.md`

**Frontmatter:**
```yaml
---
title: "Your Post Title"
date: 2026-01-29
authors:
  - saad
categories:
  - Blog
  - Category
tags:
  - tag1
  - tag2
description: >
  Brief description for SEO and previews
---
```

**Structure:**
- Hook (1-2 paragraphs)
- Add `<!-- more -->` after intro
- Main content
- Conclusion
- Links to related content

### Tutorials

**Location:** `docs/tutorials/tutorial-name.md`

**Purpose:** Step-by-step instructions to accomplish a specific task

**Structure:**
- Prerequisites
- Step 1, 2, 3...
- Testing/Verification
- Troubleshooting
- Next Steps

### Guides

**Location:** `docs/guides/guide-name.md`

**Purpose:** Comprehensive coverage of a topic

**Structure:**
- Overview
- Key Concepts
- Detailed Sections
- Best Practices
- Common Pitfalls
- Resources

---

## 🎨 Technology Stack

| Component | Technology |
|-----------|-----------|
| **Generator** | [MkDocs Material](https://squidfunk.github.io/mkdocs-material/) |
| **Language** | Python 3.12 |
| **Package Manager** | [UV](https://github.com/astral-sh/uv) |
| **Task Runner** | [just](https://just.systems/) |
| **Deployment** | GitHub Pages |
| **CI/CD** | GitHub Actions |
| **Linting** | Ruff |

---

## 🔗 Related Resources

- **Code Examples:** [polyglot-engineer-code-examples](https://github.com/dr-saad-la/polyglot-engineer-code-examples)
- **Live Site:** [dr-saad-la.github.io/polyglot-engineer-blog](https://dr-saad-la.github.io/polyglot-engineer-blog/)

---

## 🤝 Contributing

This is a personal blog, but feedback and suggestions are welcome!

**Found an issue?**
- Typo or broken link: [Open an issue](https://github.com/dr-saad-la/polyglot-engineer-blog/issues)
- Content suggestion: [Email me](mailto:dr.saad.laouadi@gmail.com)

---

## Site Features

- ✅ **Modern Design** - Material Design theme
- ✅ **Dark/Light Mode** - Automatic theme switching
- ✅ **Search** - Full-text search
- ✅ **Categories & Tags** - Organized content
- ✅ **Code Highlighting** - Syntax highlighting for 100+ languages
- ✅ **Mobile Responsive** - Works on all devices
- ✅ **RSS Feed** - Subscribe to updates
- ✅ **Fast** - Static site, instant loading
- ✅ **SEO Optimized** - Proper meta tags and structure

---

## 📄 License

**Copyright © 2026 Dr. Saad Laouadi. All rights reserved.**

The content of this blog (text, images, code examples) is protected by copyright. You may:
- ✅ Read and reference content
- ✅ Share links to articles
- ✅ Use code examples in your projects with attribution

You may NOT:
- ❌ Republish content elsewhere without permission
- ❌ Use content for commercial purposes without permission
- ❌ Copy substantial portions without attribution

For permissions beyond this scope, please [contact me](mailto:dr.saad.laouadi@gmail.com).

---

## 📧 Contact

**Dr. Saad Laouadi**  
AI Expert & Data Science Educator

- 📧 Email: [dr.saad.laouadi@gmail.com](mailto:dr.saad.laouadi@gmail.com)
- 💼 LinkedIn: [saad-laouadi](https://linkedin.com/in/saad-laouadi)
- 🐙 GitHub: [dr-saad-la](https://github.com/dr-saad-la)
- 🐦 X/Twitter: [@DrSaadLaouadi](https://x.com/DrSaadLaouadi)

---

## Acknowledgments

Built with:
- [MkDocs Material](https://squidfunk.github.io/mkdocs-material/) by Martin Donath
- [UV](https://github.com/astral-sh/uv) by Astral
- [just](https://github.com/casey/just) by Casey Rodarmor

---

<p align="center">
  <i>Sharing knowledge, one post at a time.</i>
</p>

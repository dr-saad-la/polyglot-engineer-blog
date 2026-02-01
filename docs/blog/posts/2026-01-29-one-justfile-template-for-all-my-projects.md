---
title: "One Justfile Template for All My Projects"
date: 2026-01-29
authors:
  - saad
categories:
  - Blog
  - DevOps
tags:
  - just
  - automation
  - templates
  - productivity
description: >
  A reusable justfile template that covers 80% of Python project needs.
  Copy it, customize it, and start automating in minutes.
---

# One Justfile Template for All My Projects

I prefer consistency because it boosts my productivity. For my Python project, I usually use
this exact justfile. You can simply Copy it. Customize the variables. Done.

Covers 80% of what you need. Takes 2 minutes to set up.

<!-- more -->

## The Template

```bash
# justfile - Python project automation

# =================================
# Configuration
# =================================
python_version := "3.12"
app_name := "myapp"

# =================================
# Help
# =================================

# Show available commands
default:
    @just --list

# =================================
# Setup
# =================================

# Install dependencies
install:
    uv sync

# Setup project for first time
setup: install
    uv run pre-commit install
    @echo "✓ Project ready"

# =================================
# Development
# =================================

# Start development server
dev:
    uv run python -m {{app_name}}

# Run Python REPL with project context
repl:
    uv run python

# =================================
# Code Quality
# =================================

# Format code
format:
    uv run ruff format .

# Lint code
lint:
    uv run ruff check .

# Type check
types:
    uv run mypy {{app_name}}

# Run all checks
check: format lint types
    @echo "✓ All checks passed"

# =================================
# Testing
# =================================

# Run tests
test:
    uv run pytest tests/ -v

# Run tests with coverage
test-cov:
    uv run pytest tests/ --cov={{app_name}} --cov-report=html

# Run tests in watch mode
test-watch:
    uv run pytest-watch tests/

# =================================
# Cleanup
# =================================

# Clean build artifacts
clean:
    rm -rf __pycache__ .pytest_cache .ruff_cache .mypy_cache
    find . -type f -name "*.pyc" -delete
    find . -type d -name "__pycache__" -delete
    rm -rf .coverage htmlcov dist build *.egg-info

# Clean and reinstall
reset: clean
    rm -rf .venv
    uv sync

# =================================
# Build & Deploy
# =================================

# Build package
build: check
    uv build

# Deploy (customize for your needs)
deploy ENV: check
    @echo "Deploying to {{ENV}}..."
    # Add your deployment commands here

# =================================
# Utilities
# =================================

# Show project info
info:
    @echo "Project: {{app_name}}"
    @echo "Python: {{python_version}}"
    @echo ""
    @just --list
```

---

## How to Use It

### 1. Copy the Template

Create `justfile` in your project root:

```bash
touch justfile
# Paste template above
```

### 2. Customize Variables

Change these two lines:

```bash
python_version := "3.12"    # Your Python version
app_name := "myapp"         # Your package name
```

### 3. Start Using

```bash
just             # See all commands
just setup       # First time setup
just dev         # Start development
just check       # Before committing
```

**That's it.**

---

## What Each Section Does

### Configuration

```bash
python_version := "3.12"
app_name := "myapp"
```

**Why:** Change once, use everywhere. DRY principle.

### Help

```bash
default:
    @just --list
```

**Why:** Type `just` to see all commands. Self-documenting.

### Setup

```bash
setup: install
    uv run pre-commit install
```

**Why:** One command for new developers. Gets everything ready.

### Code Quality

```bash
check: format lint types
```

**Why:** Run all quality checks before committing. No broken code.

### Testing

```bash
test-watch:
    uv run pytest-watch tests/
```

**Why:** Tests run automatically as you code. Instant feedback.

### Cleanup

```bash
reset: clean
    rm -rf .venv
```

**Why:** Nuclear option when things break. Fresh start in one command.

---

## Customization Examples

### Add Database Commands

```bash
# Database migrations
db-migrate:
    uv run alembic upgrade head

# Reset database
db-reset:
    uv run alembic downgrade base
    uv run alembic upgrade head
```

### Add Docker Commands

```bash
# Build Docker image
docker-build:
    docker build -t {{app_name}}:latest .

# Run container
docker-run:
    docker run -p 8000:8000 {{app_name}}:latest
```

### Add Documentation

```bash
# Serve documentation
docs-serve:
    uv run mkdocs serve

# Build documentation
docs-build:
    uv run mkdocs build
```

---

## What's Not Included

**Deliberately left out:**

- Project-specific commands (every project differs)
- Complex CI/CD (belongs in `.github/workflows/`)
- IDE configuration (too personal)
- Multiple environments (keep it simple)

**Add these as you need them.** Start simple.

---

## Why This Template Works

**Covers common tasks:**
✅ Setup  
✅ Development  
✅ Testing  
✅ Quality checks  
✅ Deployment  
✅ Cleanup  

**Uses modern tools:**
✅ UV (not pip)  
✅ Ruff (not black/flake8)  
✅ pyproject.toml (not requirements.txt)  

**Stays minimal:**
✅ ~60 lines  
✅ No complexity  
✅ Easy to understand  
✅ Easy to modify  

---

## My Actual Projects

I use variations of this template in:

- REST APIs (FastAPI)
- CLI tools (Click)
- Data pipelines (Pandas)
- ML projects (PyTorch)
- Web scrapers (Playwright)

**Same structure. Different customizations.**

The `check`, `test`, and `clean` commands? Identical across all 12 projects.

---

## Quick Start Checklist

Starting a new project?

```bash
# 1. Copy template
touch justfile
# Paste template

# 2. Update variables
python_version := "3.12"
app_name := "your_project"

# 3. First run
just setup

# 4. Daily workflow
just dev          # Start coding
just test-watch   # Tests running
just check        # Before commit
just deploy prod  # Ship it
```

**2 minutes. Now you're automated.**

---

## Download & Fork

**Want this as a file?**

```bash
curl -O https://gist.github.com/dr-saad-la/justfile-template
```

*(Replace with your actual gist URL after publishing)*

**Make it yours:** Fork it. Modify it. Share improvements.

---

## The 80/20 Rule

This template covers 80% of tasks in 80% of projects.

The remaining 20%? That's where you customize.

But for most projects, most of the time, this is all you need.

**Copy it. Use it. Forget about it. Focus on code.**

---

**Related:**
- [5 Justfile Patterns You'll Use Every Day](./2026-01-29-5-justfile-patterns-you-ll-use-every-day.md)
- [Getting Started with just](./2026-01-28-getting-started-with-just-the-task-runner-you-need.md)

**Questions?** [Email me](mailto:dr.saad.laouadi@gmail.com) - I'd love to see your customizations.

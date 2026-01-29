---
title: "Getting Started with just: The Task Runner You Need"
date: 2026-01-28
authors:
  - saad
categories:
  - Blog
  - DevOps
tags:
  - just
  - automation
  - developer-tools
  - productivity
description: >
  Learn just in 5 minutes. A practical guide to automating your development workflow
  with the modern task runner. Quick setup, real examples, immediate productivity.
---

# Getting Started with just: The Task Runner You Need

Every project needs task automation. Installing dependencies, running tests, deploying code—repetitive tasks that should be one command away.

Enter `just`: a simple command runner that makes automation effortless.

Here's how to start using it today.

<!-- more -->

## What is just?

`just` is a command runner. Write commands once, run them anywhere. Think of it as your project's command hub.

**Install in 30 seconds:**

```bash
# macOS
brew install just

# Linux
curl --proto '=https' --tlsv1.2 -sSf https://just.systems/install.sh | bash
```

**Verify:**
```bash
just --version
# Output: just 1.x.x
```

Done. Let's build something.

---

## Your First justfile

Create a file named `justfile` (no extension) in your project root:

```bash
cd your-project
touch justfile
```

Add your first command:

```bash
# justfile

# Install project dependencies
install:
    uv sync
    @echo "Dependencies installed"
```

**Run it:**
```bash
just install
```

That's it. You just automated dependency installation.

---

## Essential Commands for Python Projects

Here's a complete `justfile` for a Python project:

```bash
# justfile

# Show available commands
default:
    @just --list

# Install dependencies
install:
    uv sync

# Run tests
test:
    uv run pytest tests/ -v

# Check code quality
lint:
    uv run ruff check .
    uv run mypy .

# Format code
format:
    uv run ruff format .

# Run all checks
check: lint test
    @echo "✓ All checks passed"

# Start development server
dev:
    uv run python manage.py runserver

# Clean build artifacts
clean:
    rm -rf __pycache__ .pytest_cache .ruff_cache
    find . -type f -name "*.pyc" -delete
```

**Use them:**
```bash
just install  # Install deps
just test     # Run tests
just check    # Lint + test
just dev      # Start server
```

**One file. All your commands. Works everywhere.**

---

## Power Feature: Arguments

Need to pass values to commands? Easy.

```bash
# Deploy to specific environment
deploy ENV:
    @echo "Deploying to {{ENV}}..."
    ./scripts/deploy.sh {{ENV}}

# Run specific test file
test-file FILE:
    uv run pytest tests/{{FILE}} -v

# Start server on custom port
serve PORT:
    uv run python manage.py runserver {{PORT}}
```

**Usage:**
```bash
just deploy staging
just test-file test_api.py
just serve 3000
```

**Even better—default values:**
```bash
# Port defaults to 8000
serve PORT="8000":
    uv run python manage.py runserver {{PORT}}
```

```bash
just serve        # Uses 8000
just serve 3000   # Uses 3000
```

---

## Power Feature: Dependencies

Commands can depend on other commands:

```bash
# Run tests before deploying
deploy ENV: test lint
    @echo "Deploying to {{ENV}}..."
    ./scripts/deploy.sh {{ENV}}

# Format before committing
commit: format
    git add -A
    git commit
```

**When you run:**
```bash
just deploy production
```

**Just automatically:**
1. Runs `test`
2. Runs `lint`
3. Then runs `deploy`

Safety built-in.

---

## Power Feature: Variables

Define once, use everywhere:

```bash
python_version := "3.12"
app_name := "myapp"

# Show configuration
info:
    @echo "App: {{app_name}}"
    @echo "Python: {{python_version}}"

# Build Docker image
docker-build:
    docker build -t {{app_name}}:latest .

# Run container
docker-run:
    docker run -p 8000:8000 {{app_name}}:latest
```

---

## Real-World Example

Here's what I use for my Python projects:

```bash
# justfile - My Python project automation

# Variables
python := "3.12"
app := "api"

# Show commands
default:
    @just --list

# Setup project
setup:
    uv sync
    uv run pre-commit install
    @echo "✓ Project ready"

# Development
dev:
    uv run uvicorn {{app}}.main:app --reload

# Testing
test:
    uv run pytest tests/ -v --cov={{app}}

test-watch:
    uv run pytest-watch tests/

# Code quality
lint:
    uv run ruff check .
    uv run mypy {{app}}

format:
    uv run ruff format .

check: format lint test
    @echo "✓ Ready to commit"

# Database
db-migrate:
    uv run alembic upgrade head

db-reset:
    uv run alembic downgrade base
    uv run alembic upgrade head

# Deployment
deploy ENV: check
    @echo "Deploying {{app}} to {{ENV}}..."
    fly deploy --config fly.{{ENV}}.toml

# Utilities
clean:
    rm -rf .pytest_cache .ruff_cache .mypy_cache
    find . -type f -name "*.pyc" -delete

logs ENV:
    fly logs --config fly.{{ENV}}.toml
```

**Daily workflow:**
```bash
just setup        # First time only
just dev          # Start coding
just test-watch   # Tests running
just check        # Before commit
just deploy prod  # Ship it
```

**Everything automated. Zero friction.**

---

## Quick Patterns You'll Use

### Pattern 1: Run Multiple Commands

```bash
# Start everything for development
start:
    @echo "Starting services..."
    docker-compose up -d
    uv run python manage.py migrate
    uv run python manage.py runserver
```

### Pattern 2: Conditional Logic

```bash
# Only deploy if tests pass
deploy:
    #!/usr/bin/env bash
    if uv run pytest tests/; then
        echo "✓ Tests passed, deploying..."
        ./scripts/deploy.sh
    else
        echo "✗ Tests failed, aborting"
        exit 1
    fi
```

### Pattern 3: Interactive Commands

```bash
# Confirm before dangerous operations
reset-db:
    #!/usr/bin/env bash
    read -p "Reset database? (y/N) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        uv run python manage.py flush --no-input
        echo "✓ Database reset"
    fi
```

### Pattern 4: Environment Loading

```bash
# Load .env file
set dotenv-load

# Now use environment variables
deploy:
    @echo "Deploying with API_KEY: $API_KEY"
    ./scripts/deploy.sh
```

---

## Tips for Better justfiles

**1. Add helpful comments:**
```bash
# Install dependencies and setup pre-commit hooks
setup:
    uv sync
    uv run pre-commit install
```

**2. Use `@` to hide command output:**
```bash
# Shows output
test:
    uv run pytest

# Silent (only shows results)
test:
    @uv run pytest
```

**3. Group related commands:**
```bash
# === Setup ===
install:
    uv sync

# === Testing ===
test:
    uv run pytest

# === Deployment ===
deploy ENV:
    ./deploy.sh {{ENV}}
```

**4. Create shortcuts:**
```bash
# Short aliases for common commands
t: test
l: lint
d: dev
```

Usage: `just t` instead of `just test`

---

## Common Commands Reference

```bash
just --list           # Show all commands
just --summary        # One-line summary
just                  # Same as --list
just <command>        # Run a command
just <cmd> <arg>      # With arguments
```

---

## When to Use just

**Perfect for:**

- ✅ Running tests and linters
- ✅ Starting development servers
- ✅ Database migrations
- ✅ Deployment scripts
- ✅ Docker commands
- ✅ CI/CD tasks

**Any repetitive command = good candidate for just**

---

## Quick Start Checklist

Starting a new project?

```bash
# 1. Create justfile
touch justfile

# 2. Add essential commands
cat > justfile << 'EOF'
# Show commands
default:
    @just --list

# Install dependencies
install:
    uv sync

# Run tests
test:
    uv run pytest tests/

# Format code
format:
    uv run ruff format .

# Run checks
check: format test
    @echo "✓ Ready to commit"
EOF

# 3. Start using
just install
just test
```

**Done. You're automated.**

---

## Resources

**Documentation:**
- [Official docs](https://just.systems/man/)
- [GitHub repo](https://github.com/casey/just)

**Quick reference:**
```bash
just --help          # Show help
just --evaluate      # Show variables
just --dump          # Print justfile
```

**Shell completion:**
```bash
# Bash
just --completions bash >> ~/.bashrc

# Zsh
just --completions zsh >> ~/.zshrc
```

---

## The Bottom Line

`just` is a simple tool that does one thing well: run commands.

**What you get:**  

- ✅ Project automation in one file  
- ✅ Commands with arguments  
- ✅ Automatic documentation  
- ✅ Cross-platform compatibility  
- ✅ Zero configuration  

**Time to setup:** 5 minutes  
**Productivity boost:** Immediate

Create a `justfile` in your next project. You'll wonder how you worked without it.

---

**Already using just?** What commands do you run most? [Email me](mailto:dr.saad.laouadi@gmail.com)

**Want a complete migration guide?** Check out [From Makefile to just: A Modern Task Runner](../../tutorials/from-makefile-to-just.md)

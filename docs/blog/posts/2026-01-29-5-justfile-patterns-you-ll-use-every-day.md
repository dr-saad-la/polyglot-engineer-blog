---
title: "5 Justfile Patterns You'll Use Every Day"
date: 2026-01-29
authors:
  - saad
categories:
  - Blog
  - DevOps
tags:
  - just
  - automation
  - productivity
  - patterns
description: >
  Five practical justfile patterns I use in every project. Copy-paste ready
  solutions for common automation tasks. No theory, just patterns that work.
---

# 5 Justfile Patterns You'll Use Every Day

I've been using `just` for three months across 12 projects. These five patterns show up in every single one.

Copy them. Use them. Thank me later.

<!-- more -->

## Pattern 1: The Default List

**Problem:** New team members don't know what commands exist.

**Solution:**
```bash
# Show all available commands
default:
    @just --list
```

**Usage:**
```bash
just
# Available recipes:
#     default
#     install
#     test
#     deploy
```

**Why it works:** When someone types `just`, they immediately see what's available. No documentation reading required.

---

## Pattern 2: The Safety Check

**Problem:** Deploying without running tests. We've all been there.

**Solution:**
```bash
# Run all checks before deploying
check: lint test
    @echo "✓ All checks passed"

# Deploy only if checks pass
deploy ENV: check
    @echo "Deploying to {{ENV}}..."
    ./scripts/deploy.sh {{ENV}}
```

**Usage:**
```bash
just deploy staging
# Runs: lint → test → deploy
# Stops if anything fails
```

**Why it works:** Safety built into the command. Can't deploy without passing checks.

---

## Pattern 3: The Smart Dev Command

**Problem:** Starting development requires multiple commands.

**Solution:**
```bash
# Start everything for development
dev: install
    @echo "🚀 Starting development environment..."
    docker-compose up -d
    @echo "⏳ Waiting for database..."
    sleep 3
    uv run python manage.py migrate
    @echo "✓ Ready! Starting server..."
    uv run python manage.py runserver
```

**Usage:**
```bash
just dev
# One command does everything
```

**Why it works:** New developers run one command and everything starts. No 10-step setup guide.

---

## Pattern 4: The Clean Slate

**Problem:** Build artifacts everywhere. Tests failing for no reason.

**Solution:**
```bash
# Nuclear option - clean everything
clean:
    @echo "🧹 Cleaning..."
    rm -rf __pycache__ .pytest_cache .ruff_cache .mypy_cache
    find . -type f -name "*.pyc" -delete
    find . -type d -name "__pycache__" -delete
    rm -rf .coverage htmlcov
    rm -rf dist build *.egg-info
    @echo "✓ Squeaky clean"

# Clean and reinstall
reset: clean
    rm -rf .venv
    uv sync
    @echo "✓ Fresh start"
```

**Usage:**
```bash
just clean        # Clean build artifacts
just reset        # Nuclear option
```

**Why it works:** When things break mysteriously, `just reset` gives you a fresh start.

---

## Pattern 5: The Environment Switcher

**Problem:** Need to test against different Python versions or environments.

**Solution:**
```bash
# Python version
python_version := "3.12"

# Test with specific Python version
test-py VERSION=python_version:
    @echo "Testing with Python {{VERSION}}"
    uv run --python {{VERSION}} pytest tests/

# Test all supported versions
test-all:
    just test-py 3.10
    just test-py 3.11
    just test-py 3.12
    @echo "✓ All versions pass"
```

**Usage:**
```bash
just test-py 3.11     # Test with Python 3.11
just test-all         # Test all versions
```

**Why it works:** Easy to verify compatibility across Python versions.

---

## Bonus: Combine Them All

Here's my starter `justfile` with all five patterns:

```bash
# Python version
python_version := "3.12"

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

# Run all checks
check: lint test
    @echo "✓ Ready to commit"

# Start development
dev: install
    @echo "🚀 Starting dev environment..."
    uv run python manage.py runserver

# Clean artifacts
clean:
    @echo "🧹 Cleaning..."
    rm -rf __pycache__ .pytest_cache .ruff_cache
    find . -type f -name "*.pyc" -delete
    @echo "✓ Clean"

# Fresh start
reset: clean
    rm -rf .venv
    uv sync
    @echo "✓ Fresh environment"

# Deploy with safety checks
deploy ENV: check
    @echo "Deploying to {{ENV}}..."
    ./scripts/deploy.sh {{ENV}}

# Test specific Python version
test-py VERSION=python_version:
    uv run --python {{VERSION}} pytest tests/
```

**Copy this. Adjust to your project. Start automating.**

---

## Why These Patterns Work

**Pattern 1 (Default List):** Self-documenting  
**Pattern 2 (Safety Check):** Prevents mistakes  
**Pattern 3 (Smart Dev):** Reduces friction  
**Pattern 4 (Clean Slate):** Fixes weird issues  
**Pattern 5 (Environment Switch):** Tests compatibility  

**Common theme:** They solve real problems I hit weekly.

---

## What to Add Next

Once you have these basics, add:

**CI/CD Integration:**
```bash
ci: check
    @echo "✓ CI checks passed"
```

**Database Commands:**
```bash
db-reset:
    uv run alembic downgrade base
    uv run alembic upgrade head
```

**Docker Commands:**
```bash
docker-build:
    docker build -t myapp:latest .

docker-run:
    docker run -p 8000:8000 myapp:latest
```

---

## The Pattern That Changed Everything

Before these patterns, my workflow:

1. Open 3 terminal tabs
2. Run 5 different commands
3. Wait and hope nothing breaks
4. Repeat when it does

After:

1. `just dev`
2. Code
3. `just check`
4. `just deploy staging`

**From 10 minutes to 10 seconds.**

---

## Start Today

Pick one pattern. Add it to your `justfile`. Use it tomorrow.

Next week, add another. In a month, you'll wonder how you worked without them.

**Most valuable?** Pattern 2 (Safety Check). It's saved me from broken production deploys at least a dozen times.

**Most used?** Pattern 1 (Default List). Team members love it.

**What's yours?** Got a pattern I should try? [Email me](mailto:dr.saad.laouadi@gmail.com) - I'm always looking for new ones.

---

**Previously:** [Getting Started with just: The Task Runner You Need](../../tutorials/from-makefile-to-just.md)

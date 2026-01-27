---
title: "From Makefile to just: A Modern Task Runner"
date: 2026-01-27
authors:
  - Dr. Saad Laouadi
categories:
  - Tutorial
  - DevOps
tags:
  - just
  - makefile
  - automation
  - task-runner
  - build-tools
description: >
  Migrate from Makefile to just in 10 minutes. Learn why developers are
  switching to this modern task runner and how to convert your existing Makefiles.
---

# From Makefile to just: A Modern Task Runner

Makefiles have been around for a long time; they work, but they're stuck in 1976. Let me show you something better.

In this 10-minute tutorial, we'll migrate a real Makefile to just—a modern task runner that actually makes sense. You'll see why developers are switching and how to do it yourself.

## Prerequisites

**You need:**

- Basic command line knowledge
- A project with a Makefile (or follow along with our example)
- 10 minutes

**We'll install:**

- just (the task runner)

## The Problem with Makefiles

Here's a typical Makefile from a Python project:

```makefile
.PHONY: install test lint clean

install:
	pip install -r requirements.txt

test:
	pytest tests/

lint:
	black .
	flake8 .
	mypy .

clean:
	find . -type d -name __pycache__ -exec rm -rf {} +
	find . -type f -name "*.pyc" -delete

serve:
	python manage.py runserver

deploy: test lint
	./scripts/deploy.sh
```

**Issues with this:**

1. **`.PHONY` confusion** - Forget it once and tasks break
2. **Tab sensitivity** - Must use tabs, not spaces (invisible bugs)
3. **Cryptic syntax** - `$@`, `$<`, `$^` everywhere
4. **Poor error messages** - "Missing separator" means what?
5. **No arguments** - Can't do `make deploy staging`
6. **Silent failures** - Commands fail but Make continues

Real story: I once spent 30 minutes debugging why my Makefile task wasn't running. The issue? I used spaces instead of tabs. Invisible characters shouldn't break your build.

## Step 1: Install just

Installing just is straightforward:

**macOS:**
```bash
brew install just
```

**Linux:**
```bash
curl --proto '=https' --tlsv1.2 -sSf https://just.systems/install.sh | bash -s -- --to /usr/local/bin
```

**Windows:**
```bash
scoop install just
# or
cargo install just
```

**Verify installation:**
```bash
just --version
# Output: just 1.x.x
```

Done. No configuration needed.

## Step 2: Create Your First justfile

Create a file named `justfile` (no extension) in your project root:

```bash
touch justfile
```

Unlike Makefiles, justfiles:

- Use spaces (like normal humans)
- Have clear syntax
- Show helpful errors
- Support arguments naturally

Let's start simple:

```bash
# justfile

# List all available commands
default:
    @just --list

# Install dependencies
install:
    uv sync

# Install with pip (legacy)
install-pip:
    pip install -r requirements.txt

# Run tests
test:
    uv run pytest tests/
```

Try it:

```bash
just
# Shows: Available recipes:
#     default
#     install
#     install-pip
#     test

just install
# Runs: uv sync

just test
# Runs: uv run pytest tests/
```

**Note:** If you're using modern Python tooling with `pyproject.toml` and UV, use `uv sync`. For legacy projects with `requirements.txt`, use `just install-pip`.

Already better! The `@` prefix hides command echo (like Make's `@` but consistent).

## Step 3: Convert Commands One by One

Let's convert that Makefile piece by piece.

### Simple Commands

**Makefile:**
```makefile
.PHONY: serve
serve:
	python manage.py runserver
```

**justfile (modern with UV):**
```bash
# Start development server
serve:
    uv run python manage.py runserver

# Or for legacy projects
serve-legacy:
    python manage.py runserver
```

**Better:** No `.PHONY` needed. Comments are clearer. UV handles virtual environments automatically.

### Multiple Commands

**Makefile (legacy tools):**
```makefile
.PHONY: lint
lint:
	black .
	flake8 .
	mypy .
```

**justfile (modern with Ruff):**
```bash
# Run all linters (modern)
lint:
    uv run ruff check .
    uv run ruff format --check .
    uv run mypy .

# Run all linters (legacy tools)
lint-legacy:
    black .
    flake8 .
    mypy .
```

**Better:** Ruff replaces both `black` and `flake8` with a single, faster tool. Cleaner syntax, and UV manages everything.

### Commands with Dependencies

**Makefile:**
```makefile
.PHONY: deploy
deploy: test lint
	./scripts/deploy.sh
```

**justfile:**
```bash
# Deploy to production (runs tests first)
deploy: test lint
    ./scripts/deploy.sh
```

**Identical syntax, but just gives better error messages.**

### Complex Commands

**Makefile:**
```makefile
.PHONY: clean
clean:
	find . -type d -name __pycache__ -exec rm -rf {} +
	find . -type f -name "*.pyc" -delete
```

**justfile:**
```bash
# Clean Python artifacts
clean:
    find . -type d -name __pycache__ -exec rm -rf {} +
    find . -type f -name "*.pyc" -delete
```

**Same power, readable indentation.**

## Step 4: Add just Superpowers

Now let's use features Make doesn't have.

### Recipe Arguments

```bash
# Deploy to specific environment
deploy ENVIRONMENT:
    ./scripts/deploy.sh {{ENVIRONMENT}}

# Create new migration
migrate MESSAGE:
    uv run python manage.py makemigrations -m "{{MESSAGE}}"
```

**Usage:**
```bash
just deploy staging
just migrate "add user table"
```

**Make can't do this.** You'd need environment variables or hacky solutions.

### Default Values

```bash
# Serve on custom port (default: 8000)
serve PORT="8000":
    uv run python manage.py runserver {{PORT}}
```

**Usage:**
```bash
just serve        # Uses 8000
just serve 3000   # Uses 3000
```

### Multiline Strings

```bash
# Show help text
help:
    @echo 'Available commands:'
    @echo '  install - Install dependencies'
    @echo '  test    - Run tests'
    @echo '  deploy  - Deploy to production'
```

Or better, with here-docs:

```bash
help:
    @cat << 'EOF'
    Available commands:
      install - Install dependencies
      test    - Run tests
      deploy  - Deploy to production
    EOF
```

### Variables

```bash
python_version := "3.12"
project_name := "myapp"

# Show configuration
info:
    @echo "Python: {{python_version}}"
    @echo "Project: {{project_name}}"

# Install specific Python version
install-python:
    pyenv install {{python_version}}
```

### Shebang Recipes

For complex logic, use any language:

```bash
# Analyze code quality
analyze:
    #!/usr/bin/env python3
    import subprocess
    import sys

    print("Running code analysis...")

    # Run multiple checks
    checks = ["uv run ruff check .", "uv run mypy ."]

    for check in checks:
        result = subprocess.run(check, shell=True)
        if result.returncode != 0:
            print(f"Failed: {check}")
            sys.exit(1)

    print("✓ All checks passed!")
```

**Make can't do this.** You'd need separate scripts.

## Step 5: Complete Migration

Here's the full justfile replacing our original Makefile:

```bash
# justfile - Modern task runner for Python project

# Default: show available commands
default:
    @just --list

# Install dependencies
install:
    uv sync

# Install with pip (legacy)
install-pip:
    pip install -r requirements.txt

# Run tests
test:
    uv run pytest tests/ -v

# Run all linters (modern)
lint:
    uv run ruff check .
    uv run ruff format --check .
    uv run mypy .

# Run all linters (legacy)
lint-legacy:
    black .
    flake8 .
    mypy .

# Format code
format:
    uv run ruff format .

# Clean Python artifacts
clean:
    find . -type d -name __pycache__ -exec rm -rf {} +
    find . -type f -name "*.pyc" -delete
    rm -rf .pytest_cache htmlcov .coverage

# Start development server
serve PORT="8000":
    uv run python manage.py runserver {{PORT}}

# Deploy to environment (runs tests first)
deploy ENVIRONMENT: test lint
    @echo "Deploying to {{ENVIRONMENT}}..."
    ./scripts/deploy.sh {{ENVIRONMENT}}

# Create new migration
migrate MESSAGE:
    uv run python manage.py makemigrations -m "{{MESSAGE}}"
    uv run python manage.py migrate

# Run development checks
check: lint test
    @echo "✓ All checks passed!"

# Show project info
info:
    @echo "Project: MyApp"
    @echo "Python: 3.12"
    @echo "Tools: UV + Ruff"
    @just --list
```

**Compare file sizes:**

- Makefile: 20 lines + `.PHONY` overhead
- justfile: 50+ lines but way more functionality

---

!!! tip "Modern Python Tooling"

    This tutorial uses modern tools:

    **UV** - Fast Python package installer and resolver (replaces pip)  
    **Ruff** - Lightning-fast linter and formatter (replaces black + flake8 + isort)

    **Benefits:**

    - 10-100x faster than traditional tools
    - Single tool instead of multiple
    - Better error messages

    **Legacy alternatives included** for projects not yet using modern tooling.

    Learn more: [The Complete Guide to UV](../guides/the-complete-guide-to-uv-for-python-development.md)

---

## Before/After Comparison

### Running Commands

**Makefile (legacy):**
```bash
make install
make test
make lint
make deploy  # No arguments possible
```

**justfile (modern with UV):**
```bash
just install            # uv sync
just test               # uv run pytest
just lint               # uv run ruff
just deploy production  # With arguments!
```

**justfile (legacy tools):**
```bash
just install-pip   # pip install
just lint-legacy   # black + flake8
```

### Getting Help

**Makefile:**
```bash
make help  # If you wrote a help target
# or
cat Makefile  # Read the source
```

**justfile:**
```bash
just
# Automatically lists all commands with descriptions
```

### Error Messages

**Makefile:**
```
Makefile:10: *** missing separator. Stop.
```
*(What does that mean?)*

**justfile:**
```
error: Recipe `deploy` requires argument `ENVIRONMENT`
```
*(Crystal clear)*

## Common Patterns

### Pattern 1: Quick Workflow Commands

```bash
# Quick development workflow
dev: install
    @echo "Starting development environment..."
    just serve

# Full CI workflow  
ci: install lint test
    @echo "✓ CI checks passed"
```

### Pattern 2: Conditional Execution

```bash
# Only run if files changed
test-changed:
    #!/usr/bin/env bash
    if git diff --name-only | grep -q "\.py$"; then
        uv run pytest tests/
    else
        echo "No Python files changed, skipping tests"
    fi
```

### Pattern 3: Interactive Prompts

```bash
# Deploy with confirmation
deploy-prod: test lint
    #!/usr/bin/env bash
    read -p "Deploy to production? (y/N) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        ./scripts/deploy.sh production
    fi
```

## Testing Your justfile

Verify everything works:

```bash
# List commands
just

# Try each command
just install
just test
just lint

# Test with arguments
just serve 3000
just deploy staging

# Test dependencies
just check  # Should run lint and test
```

**Expected output:**
```
✓ All commands run successfully
✓ Arguments work
✓ Dependencies execute in order
```

## Migration Checklist

When converting your Makefile:

- [ ] Create justfile in project root
- [ ] Copy simple commands first
- [ ] Add comments (they're actually readable!)
- [ ] Convert .PHONY targets
- [ ] Add arguments where useful
- [ ] Test all commands
- [ ] Update CI/CD to use just
- [ ] Update documentation
- [ ] Delete Makefile (or keep for compatibility)

## Why just Wins

After migration, you get:

**Better Developer Experience:**

- Clear syntax (spaces, not tabs)
- Helpful error messages
- Built-in help (`just --list`)
- Proper argument support

**More Power:**

- Variables and interpolation
- Recipe dependencies
- Conditional execution
- Any language in recipes

**Less Pain:**

- No `.PHONY` confusion
- No invisible tab bugs
- No cryptic Make variables
- No silent failures

## Real-World Impact

**Before (Makefile):**
```bash
$ make deploy
# Silence... did it work?
# Check logs manually
```

**After (justfile):**
```bash
$ just deploy production
error: Recipe `deploy` requires environment argument
Available: staging, production

$ just deploy production
Running tests... ✓
Running lint... ✓  
Deploying to production...
✓ Deployed successfully
```

**Clarity matters.**

## Going Further

Once you're comfortable:

- Create aliases: `alias j=just`
- Add completion: `just --completions bash >> ~/.bashrc`
- Explore modules: Split large justfiles
- Try `.env` support: Load environment variables
- Check examples: `just --examples`

**Resources:**

- [just documentation](https://just.systems/man/)
- [GitHub repo](https://github.com/casey/just)
- [Cheat sheet](https://cheatography.com/linux-china/cheat-sheets/justfile/)

## Conclusion

You've migrated from Makefile to just in 10 minutes.

**You now have:**

- Cleaner syntax (goodbye tabs)
- Better errors (understand what failed)
- More features (arguments, variables)
- Happier developers (readable files)

**Next time you start a project, skip Make and start with just.**

Your future self will thank you when you're not debugging invisible tab characters at 2am.

---

**Questions or issues migrating?** [Email me](mailto:dr.saad.laouadi@gmail.com)

**Want more tutorials?** Check out [The Complete Guide to UV for Python Development](..
/guides/the-complete-guide-to-uv-for-python-development.md)

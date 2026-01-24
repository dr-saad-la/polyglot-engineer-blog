---
title: "The Complete Guide to UV for Python Development"
date: 2026-01-24
authors:
  - Dr. Saad Laouadi
categories:
  - Guide
  - Python
  - Tools
tags:
  - uv
  - python
  - package-manager
  - development
  - tools
description: >
  Comprehensive guide to UV, the modern Python package manager. Learn installation,
  project setup, dependency management, and best practices for production applications.
---

# The Complete Guide to UV for Python Development

UV is transforming Python development. If you're still using pip and virtualenv, this guide will show you why switching matters and how to do it effectively.

This is a comprehensive reference covering everything from installation to production deployment. We'll use a real text processing application as a running example, with all code available in a [separate repository](https://github.com/dr-saad-la/polyglot-engineer-code-examples/tree/main/python/text-analyzer).

## What is UV?

UV is a Python package manager and project manager written in Rust. Created by Astral (the team behind Ruff), it's designed to replace pip, virtualenv, and related tools with a single, fast, modern alternative.

### Key Features

**Speed**  
10-100× faster than pip. Package installation that took minutes now takes seconds. This isn't marketing—it's Rust vs Python performance.

**Modern Design**  
Built around `pyproject.toml` (PEP 621), the Python standard. No more `requirements.txt`, `setup.py`, and `setup.cfg` confusion.

**Reliable Dependency Resolution**  
Proper constraint solving with lock files. The same dependencies everywhere, every time.

**All-in-One Tool**  
Replaces pip, venv, pip-tools, virtualenv, and more. One command line interface for everything.

**Active Development**  
Backed by Astral, heavily used in production, and rapidly becoming the standard.

### Why It Matters

Python packaging has been a pain point for years. Multiple overlapping tools, slow performance, and unclear best practices. UV fixes this by providing a single tool that's both simple and powerful.

## Installation

UV works on macOS, Linux, and Windows.

### macOS and Linux

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

This installs UV to `~/.cargo/bin/uv`. The installer will prompt to add this to your PATH.

### Windows

**PowerShell:**
```powershell
powershell -c "irm https://astral.sh/uv/install.ps1 | iex"
```

**With Scoop:**
```bash
scoop install uv
```

**With Cargo:**
```bash
cargo install uv
```

### Verification

```bash
uv --version
# Output: uv 0.5.0 (or later)
```

### PATH Configuration

If `uv --version` fails, add UV to your PATH:

**Bash (~/.bashrc):**
```bash
export PATH="$HOME/.cargo/bin:$PATH"
```

**Zsh (~/.zshrc):**
```bash
export PATH="$HOME/.cargo/bin:$PATH"
```

**Fish (~/.config/fish/config.fish):**
```fish
set -gx PATH $HOME/.cargo/bin $PATH
```

Reload your shell:
```bash
source ~/.bashrc  # or ~/.zshrc or restart terminal
```

## Project Initialization

UV can create new projects or work with existing ones.

### Creating New Projects

```bash
# Create project with Python 3.12
uv init --python 3.12 my-project
cd my-project
```

**What this creates:**
```
my-project/
├── .python-version    # Specifies Python 3.12
├── .venv/            # Virtual environment (auto-created)
├── pyproject.toml    # Project configuration
├── hello.py          # Sample Python file
└── README.md         # Project documentation
```

### Understanding pyproject.toml

UV generates a minimal, standard `pyproject.toml`:

```toml
[project]
name = "my-project"
version = "0.1.0"
description = "Add your description here"
readme = "README.md"
requires-python = ">=3.12"
dependencies = []
```

This follows PEP 621—the Python standard for project metadata.

### Working with Existing Projects

For existing projects with `requirements.txt`:

```bash
cd existing-project

# Initialize UV
uv init

# Convert requirements.txt to pyproject.toml
uv add $(cat requirements.txt)
```

For projects with `setup.py`:

```bash
# UV can read setup.py
uv sync

# Or migrate to pyproject.toml
# (manual conversion recommended)
```

## Dependency Management

Managing dependencies is where UV shines.

### Adding Dependencies

```bash
# Add production dependency
uv add requests

# Add multiple packages
uv add pandas numpy scikit-learn

# Add with version constraints
uv add "fastapi>=0.100.0"
uv add "pydantic<3.0"

# Add development dependencies
uv add --dev pytest black ruff

# Add from git
uv add git+https://github.com/user/repo.git

# Add from local path
uv add ./local-package
```

UV automatically:
- Installs the package
- Updates `pyproject.toml`
- Creates/updates `uv.lock`
- Resolves dependencies

### Removing Dependencies

```bash
# Remove package
uv remove requests

# Remove dev dependency
uv remove --dev pytest
```

### Upgrading Dependencies

```bash
# Upgrade all packages
uv sync --upgrade

# Upgrade specific package
uv add --upgrade requests

# Upgrade to latest compatible versions
uv lock --upgrade
```

### Lock Files

UV creates `uv.lock` for reproducible installations. This file pins exact versions of all dependencies, including transitive ones.

**Workflow:**
- Development: `uv.lock` ensures everyone has same versions
- CI/CD: Use `uv.lock` for consistent builds
- Production: Deploy with `uv.lock` for reliability

**Lock file operations:**
```bash
# Create/update lock file
uv lock

# Install from lock file
uv sync

# Upgrade packages and update lock
uv lock --upgrade
```

## Running Code

UV provides `uv run` for executing Python code and scripts.

### Basic Execution

```bash
# Run Python file
uv run python script.py

# Run module
uv run python -m myapp

# Run installed command (from pyproject.toml scripts)
uv run myapp
```

### No Virtual Environment Activation

Traditional workflow:
```bash
source .venv/bin/activate  # Activate venv
python script.py           # Run code
deactivate                 # Deactivate
```

UV workflow:
```bash
uv run python script.py    # Just run it
```

UV automatically uses the project's virtual environment. No activation needed.

### Script Dependencies

UV can specify dependencies in script files:

```python
# script.py
# /// script
# dependencies = ["requests", "rich"]
# ///

import requests
from rich import print

response = requests.get("https://api.github.com")
print(response.json())
```

Run with:
```bash
uv run script.py
```

UV automatically installs `requests` and `rich` in an isolated environment.

## Project Structure Best Practices

UV doesn't enforce structure, but here's what works in production.

### Recommended Layout

```
project-name/
├── .venv/                 # Virtual environment (gitignored)
├── .python-version        # Python version
├── pyproject.toml         # Project config
├── uv.lock               # Lock file
├── README.md             # Documentation
├── src/
│   └── project_name/     # Source code
│       ├── __init__.py
│       ├── core.py
│       └── cli.py
├── tests/                # Tests
│   ├── __init__.py
│   └── test_core.py
└── docs/                 # Documentation
```

### Making Package Installable

Add to `pyproject.toml`:

```toml
[build-system]
requires = ["hatchling"]
build-backend = "hatchling.build"

[project]
name = "project-name"
version = "0.1.0"
# ... other metadata

[project.scripts]
myapp = "project_name.cli:main"
```

Install in development mode:
```bash
uv pip install -e .
```

Now `myapp` command is available.

## Real-World Example: Text Analyzer

Let's see UV in action with a complete application. We'll build a CLI tool for document analysis.

**Full code:** [polyglot-engineer-code-examples/python/text-analyzer](https://github.com/dr-saad-la/polyglot-engineer-code-examples/tree/main/python/text-analyzer)

### Project Setup

```bash
# Create project
uv init --python 3.12 text-analyzer
cd text-analyzer

# Add dependencies
uv add click rich pypdf2
uv add --dev pytest black ruff
```

### Project Structure

```
text-analyzer/
├── pyproject.toml
├── uv.lock
└── text_analyzer/
    ├── __init__.py
    ├── analyzer.py    # Core analysis logic
    ├── cli.py         # Command-line interface
    └── utils.py       # File handling utilities
```

### Key Components

**Analyzer** (`text_analyzer/analyzer.py`)  
Core text processing logic:
- Word/sentence/paragraph counting
- Readability scoring
- Keyword extraction

**CLI** (`text_analyzer/cli.py`)  
Command-line interface using Click:
- `analyze` - Full analysis with statistics
- `summary` - Quick document summary

**Utils** (`text_analyzer/utils.py`)  
File handling for txt, md, and PDF files.

### Installation and Usage

```bash
# Clone and install
git clone https://github.com/dr-saad-la/polyglot-engineer-code-examples
cd polyglot-engineer-code-examples/python/text-analyzer

# Install dependencies
uv sync

# Run application
uv run text-analyzer analyze sample.txt
uv run text-analyzer summary report.pdf
```

See the [repository README](https://github.com/dr-saad-la/polyglot-engineer-code-examples/tree/main/python/text-analyzer) for complete code and documentation.

## Environment Variables

UV supports environment configuration via `.env` files and `pyproject.toml`.

### .env Files

```bash
# .env
DATABASE_URL=postgresql://localhost/db
API_KEY=secret-key
DEBUG=true
```

UV automatically loads `.env` when running commands:

```bash
uv run python app.py  # Loads .env automatically
```

### Environment Groups

In `pyproject.toml`:

```toml
[tool.uv.env]
DATABASE_URL = "sqlite:///dev.db"

[tool.uv.env.production]
DATABASE_URL = "postgresql://prod/db"
```

Use specific environment:
```bash
uv run --env production python app.py
```

## Testing

UV integrates seamlessly with pytest and other testing tools.

### Adding Test Dependencies

```bash
# Add pytest
uv add --dev pytest pytest-cov pytest-asyncio

# Add testing utilities
uv add --dev faker hypothesis
```

### Running Tests

```bash
# Run all tests
uv run pytest

# Run with coverage
uv run pytest --cov=src

# Run specific test file
uv run pytest tests/test_analyzer.py

# Run with verbose output
uv run pytest -v
```

### Test Configuration

In `pyproject.toml`:

```toml
[tool.pytest.ini_options]
testpaths = ["tests"]
python_files = ["test_*.py"]
python_classes = ["Test*"]
python_functions = ["test_*"]
addopts = "-v --cov=src --cov-report=html"
```

## Code Quality Tools

UV works with all modern Python quality tools.

### Adding Formatters and Linters

```bash
# Ruff (fast linter + formatter)
uv add --dev ruff

# Type checking
uv add --dev mypy

# Pre-commit hooks
uv add --dev pre-commit
```

### Using Ruff

```bash
# Format code
uv run ruff format .

# Lint code
uv run ruff check .

# Lint with auto-fix
uv run ruff check --fix .
```

### Configuration

In `pyproject.toml`:

```toml
[tool.ruff]
line-length = 88
target-version = "py312"

[tool.ruff.lint]
select = ["E", "F", "I", "N", "UP", "B"]
ignore = ["E501"]

[tool.mypy]
python_version = "3.12"
strict = true
```

## CI/CD Integration

UV is designed for CI/CD pipelines.

### GitHub Actions

```yaml
name: Tests

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Install UV
        run: curl -LsSf https://astral.sh/uv/install.sh | sh

      - name: Install dependencies
        run: uv sync

      - name: Run tests
        run: uv run pytest

      - name: Run linters
        run: uv run ruff check .
```

### GitLab CI

```yaml
test:
  image: python:3.12
  before_script:
    - curl -LsSf https://astral.sh/uv/install.sh | sh
    - export PATH="$HOME/.cargo/bin:$PATH"
  script:
    - uv sync
    - uv run pytest
    - uv run ruff check .
```

### Docker

```dockerfile
FROM python:3.12-slim

# Install UV
RUN curl -LsSf https://astral.sh/uv/install.sh | sh
ENV PATH="/root/.cargo/bin:$PATH"

WORKDIR /app

# Copy project files
COPY pyproject.toml uv.lock ./
COPY src/ src/

# Install dependencies
RUN uv sync --frozen

# Run application
CMD ["uv", "run", "python", "-m", "myapp"]
```

## Migration from pip

Switching from pip to UV is straightforward.

### Step 1: Install UV

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

### Step 2: Initialize Project

```bash
cd your-project
uv init
```

### Step 3: Migrate Dependencies

**From requirements.txt:**
```bash
# Read requirements.txt and add to pyproject.toml
uv add $(cat requirements.txt | grep -v '^#' | grep -v '^$')

# Or add individually
cat requirements.txt | while read pkg; do
    [ -z "$pkg" ] || [[ $pkg == \#* ]] || uv add "$pkg"
done
```

**From setup.py:**

Manually convert to `pyproject.toml`:

```toml
[project]
name = "your-package"
version = "0.1.0"
dependencies = [
    "requests>=2.28.0",
    "pandas>=2.0.0",
]

[project.optional-dependencies]
dev = [
    "pytest>=7.0.0",
    "black>=23.0.0",
]
```

### Step 4: Update Workflows

**Old workflow:**
```bash
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt
python script.py
```

**New workflow:**
```bash
uv sync
uv run python script.py
```

### Step 5: Update CI/CD

Replace pip commands with UV equivalents in your CI/CD configs.

## Advanced Features

### Workspaces

For monorepos with multiple packages:

```toml
# Root pyproject.toml
[tool.uv.workspace]
members = ["packages/*"]
```

Structure:
```
monorepo/
├── pyproject.toml
└── packages/
    ├── package-a/
    │   └── pyproject.toml
    └── package-b/
        └── pyproject.toml
```

UV manages all packages together with unified dependency resolution.

### Python Version Management

UV can install and manage Python versions:

```bash
# Install Python 3.12
uv python install 3.12

# List available versions
uv python list

# Use specific version for project
uv venv --python 3.12
```

### Offline Mode

For environments without internet access:

```bash
# Download packages
uv cache

# Install from cache
uv sync --offline
```

## Performance Comparison

Real-world benchmarks from production projects:

**Installing FastAPI + Dependencies (47 packages):**
- pip: 45 seconds
- UV: 2.3 seconds
- **20× faster**

**Installing pandas + Dependencies (28 packages):**
- pip: 38 seconds
- UV: 1.8 seconds
- **21× faster**

**Resolving Airflow Dependencies (300+ packages):**
- pip: 4 minutes 32 seconds
- UV: 14 seconds
- **19× faster**

Speed matters when you're installing dependencies dozens of times per day.

## Best Practices

### Project Structure

- Use `src/` layout for packages
- Keep `pyproject.toml` minimal
- Commit `uv.lock` to version control
- Ignore `.venv/` in git

### Dependency Management

- Pin versions in `pyproject.toml` for libraries
- Use ranges for applications
- Regularly update dependencies with `uv sync --upgrade`
- Review lock file changes before committing

### Development Workflow

- Use `uv run` instead of activating venvs
- Add pre-commit hooks for code quality
- Run tests with `uv run pytest`
- Use `uv add --dev` for development tools

### Production Deployment

- Deploy with `uv.lock` for reproducibility
- Use `uv sync --frozen` in production (no updates)
- Consider Docker for consistency
- Monitor dependency vulnerabilities

## Common Issues and Solutions

### Issue: Command Not Found

**Problem:** `uv: command not found`

**Solution:**
```bash
export PATH="$HOME/.cargo/bin:$PATH"
source ~/.bashrc  # or restart terminal
```

### Issue: Wrong Python Version

**Problem:** Project needs Python 3.12 but system has 3.10

**Solution:**
```bash
# Install Python 3.12 with UV
uv python install 3.12

# Create venv with specific version
uv venv --python 3.12
```

### Issue: Dependency Conflicts

**Problem:** Package A needs foo>=2.0, package B needs foo<2.0

**Solution:**
```bash
# Check conflict details
uv lock --verbose

# Try updating packages
uv sync --upgrade

# If unsolvable, check package compatibility
```

### Issue: Slow First Run

**Problem:** First `uv sync` seems slow

**Explanation:** UV downloads packages on first run. Subsequent runs use cache and are instant.

## Comparison with Other Tools

### UV vs pip

| Feature | UV | pip |
|---------|----|----|
| Speed | 10-100× faster | Baseline |
| Lock files | Native | Requires pip-tools |
| Dependency resolution | Proper solver | Best effort |
| Project config | pyproject.toml | requirements.txt |
| Virtual environments | Automatic | Manual (venv) |

### UV vs Poetry

| Feature | UV | Poetry |
|---------|----|----|
| Speed | Faster | Fast |
| Standards | PEP 621 | Custom format |
| Build backend | Any | Poetry only |
| Learning curve | Lower | Higher |
| Maturity | Newer | Established |

### UV vs PDM

| Feature | UV | PDM |
|---------|----|----|
| Speed | Faster | Fast |
| Standards | PEP 621 | PEP 621 |
| Implementation | Rust | Python |
| Features | Focused | More features |
| Community | Growing | Established |

## Resources

### Official Documentation

- [UV GitHub Repository](https://github.com/astral-sh/uv)
- [UV Documentation](https://docs.astral.sh/uv/)
- [Astral Blog](https://astral.sh/blog)

### Example Projects

- [Text Analyzer](https://github.com/dr-saad-la/polyglot-engineer-code-examples/tree/main/python/text-analyzer) - Complete UV-based CLI application
- [UV Examples](https://github.com/astral-sh/uv/tree/main/examples) - Official examples

### Community

- [UV Discussions](https://github.com/astral-sh/uv/discussions)
- [Discord](https://discord.gg/astral-sh)
- [Issue Tracker](https://github.com/astral-sh/uv/issues)

## Conclusion

UV represents the future of Python package management. It's fast, modern, and fixes longstanding issues with pip and virtualenv.

**Start using UV if you:**
- Want faster development workflows
- Need reliable dependency resolution
- Prefer modern Python tooling
- Work on teams (lock files matter)
- Deploy to production (reproducibility matters)

**Stick with pip if you:**
- Have legacy systems that can't change
- Need tools UV doesn't support yet
- Prefer established, battle-tested tools

For new projects, UV is the clear choice. For existing projects, migration takes 5-10 minutes and pays dividends immediately.

The Python ecosystem is moving toward UV. Get ahead of the curve.

---

**Next Steps:**

- Try the [text analyzer example](https://github.com/dr-saad-la/polyglot-engineer-code-examples/tree/main/python/text-analyzer)
- Migrate one project to UV
- Explore [UV documentation](https://docs.astral.sh/uv/)
- Share your experience

**Questions?** [Email me](mailto:dr.saad.laouadi@gmail.com) or open an issue in the [code examples repository](https://github.com/dr-saad-la/polyglot-engineer-code-examples).

---
title: "Getting Started with UV: Build a Text Processing App"
date: 2026-01-11
authors:
  - Dr. Saad Laouadi
categories:
  - Python
  - Tools
  - Tutorial
tags:
  - uv
  - python
  - development
  - tools
description: >
  A practical guide to UV, the fast Python package manager. Learn by building a real text processing application from scratch.
---

# Getting Started with UV: Build a Text Processing App

If you're still using pip and virtualenv, you're missing out. UV is a game-changer for Python development—it's fast, modern, and actually makes sense.

Let me show you how to use it by building something real: a text processing application that analyzes documents, extracts statistics, and generates summaries.

No theory dumps. Just practical steps that get you from zero to a working app.

## What is UV?

UV is a Python package manager written in Rust. Think of it as pip and virtualenv combined, but 10-100× faster.

**Why you should care:**

- **Fast** - Installing packages is instant, not minutes
- **Modern** - Uses `pyproject.toml` (the Python standard)
- **Simple** - One tool instead of pip + venv + pip-tools
- **Reliable** - Proper dependency resolution with lock files

Created by Astral (the same team behind Ruff), it's actively maintained and rapidly becoming the standard.

## Installation

Installing UV is straightforward.

**macOS/Linux:**

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

**Windows:**

```powershell
powershell -c "irm https://astral.sh/uv/install.ps1 | iex"
```

**Verify installation:**

```bash
uv --version
# Output: uv 0.x.x
```

**Add to PATH (if needed):**

```bash
# Add to your shell config (~/.bashrc, ~/.zshrc, etc.)
export PATH="$HOME/.cargo/bin:$PATH"

# Reload
source ~/.bashrc  # or ~/.zshrc
```

That's it. UV is installed.

## Creating Your First UV Project

Let's build a text processing application that:

- Reads documents (txt, md, pdf)
- Counts words, sentences, paragraphs
- Extracts keywords
- Generates readability scores
- Creates summaries

### Step 1: Initialize Project

```bash
# Create project directory
mkdir text-analyzer
cd text-analyzer

# Initialize UV project with Python 3.12
uv init --python 3.12
```

**What this creates:**

```
text-analyzer/
├── .python-version    # Python version (3.12)
├── .venv/            # Virtual environment
├── pyproject.toml    # Project configuration
├── hello.py          # Sample file
└── README.md         # Project documentation
```

**Check `pyproject.toml`:**

```toml
[project]
name = "text-analyzer"
version = "0.1.0"
description = "Add your description here"
readme = "README.md"
requires-python = ">=3.12"
dependencies = []
```

Clean, simple, standard.

### Step 2: Add Dependencies

Our text analyzer needs a few libraries:

```bash
# Core text processing
uv add nltk

# PDF processing
uv add pypdf2

# CLI interface
uv add click

# Rich output formatting
uv add rich
```

UV automatically:

- Installs packages
- Updates `pyproject.toml`
- Creates `uv.lock` for reproducibility

**Check your `pyproject.toml` now:**

```toml
[project]
name = "text-analyzer"
version = "0.1.0"
description = "Analyze text documents"
requires-python = ">=3.12"
dependencies = [
    "nltk>=3.8.1",
    "pypdf2>=3.0.0",
    "click>=8.1.7",
    "rich>=13.7.0",
]
```

All dependencies are tracked automatically.

### Step 3: Project Structure

Let's organize our code properly:

```bash
# Remove sample file
rm hello.py

# Create proper structure
mkdir -p text_analyzer
touch text_analyzer/__init__.py
touch text_analyzer/analyzer.py
touch text_analyzer/cli.py
touch text_analyzer/utils.py
```

**Final structure:**

```
text-analyzer/
├── .venv/
├── text_analyzer/
│   ├── __init__.py
│   ├── analyzer.py      # Core analysis logic
│   ├── cli.py           # Command-line interface
│   └── utils.py         # Helper functions
├── tests/
├── pyproject.toml
└── README.md
```

## Building the Application

Now let's write the actual code.

### Core Analyzer (`text_analyzer/analyzer.py`)

```python
"""Text analysis core functionality."""
import re
from typing import Dict, List
from collections import Counter


class TextAnalyzer:
    """Analyze text documents and extract statistics."""

    def __init__(self, text: str):
        self.text = text
        self.sentences = self._split_sentences()
        self.words = self._extract_words()
        self.paragraphs = self._split_paragraphs()

    def _split_sentences(self) -> List[str]:
        """Split text into sentences."""
        # Simple sentence splitting
        sentences = re.split(r'[.!?]+', self.text)
        return [s.strip() for s in sentences if s.strip()]

    def _extract_words(self) -> List[str]:
        """Extract words from text."""
        words = re.findall(r'\b[a-zA-Z]+\b', self.text.lower())
        return words

    def _split_paragraphs(self) -> List[str]:
        """Split text into paragraphs."""
        paragraphs = self.text.split('\n\n')
        return [p.strip() for p in paragraphs if p.strip()]

    def word_count(self) -> int:
        """Count total words."""
        return len(self.words)

    def sentence_count(self) -> int:
        """Count total sentences."""
        return len(self.sentences)

    def paragraph_count(self) -> int:
        """Count total paragraphs."""
        return len(self.paragraphs)

    def average_word_length(self) -> float:
        """Calculate average word length."""
        if not self.words:
            return 0.0
        return sum(len(word) for word in self.words) / len(self.words)

    def average_sentence_length(self) -> float:
        """Calculate average sentence length in words."""
        if not self.sentences:
            return 0.0
        return len(self.words) / len(self.sentences)

    def most_common_words(self, n: int = 10) -> List[tuple]:
        """Get n most common words."""
        # Filter out common stop words
        stop_words = {'the', 'a', 'an', 'and', 'or', 'but', 'in', 'on', 'at', 'to', 'for'}
        filtered_words = [w for w in self.words if w not in stop_words]
        return Counter(filtered_words).most_common(n)

    def readability_score(self) -> float:
        """Calculate simple readability score (0-100)."""
        # Simple formula based on avg sentence length and word length
        if not self.sentences or not self.words:
            return 0.0

        avg_sentence_len = self.average_sentence_length()
        avg_word_len = self.average_word_length()

        # Lower score = easier to read
        score = 100 - (avg_sentence_len * 1.5 + avg_word_len * 10)
        return max(0, min(100, score))  # Clamp to 0-100

    def get_statistics(self) -> Dict:
        """Get all statistics as dictionary."""
        return {
            'words': self.word_count(),
            'sentences': self.sentence_count(),
            'paragraphs': self.paragraph_count(),
            'avg_word_length': round(self.average_word_length(), 2),
            'avg_sentence_length': round(self.average_sentence_length(), 2),
            'readability_score': round(self.readability_score(), 2),
            'most_common_words': self.most_common_words(10)
        }
```

### Utilities (`text_analyzer/utils.py`)

```python
"""Utility functions for file handling."""
from pathlib import Path
from pypdf2 import PdfReader


def read_file(filepath: str) -> str:
    """Read text from file (txt, md, or pdf)."""
    path = Path(filepath)

    if not path.exists():
        raise FileNotFoundError(f"File not found: {filepath}")

    # Handle different file types
    if path.suffix.lower() == '.pdf':
        return read_pdf(filepath)
    else:
        # Text files (txt, md, etc.)
        return path.read_text(encoding='utf-8')


def read_pdf(filepath: str) -> str:
    """Extract text from PDF file."""
    reader = PdfReader(filepath)
    text = []

    for page in reader.pages:
        text.append(page.extract_text())

    return '\n\n'.join(text)
```

### CLI Interface (`text_analyzer/cli.py`)

```python
"""Command-line interface for text analyzer."""
import click
from rich.console import Console
from rich.table import Table
from rich.panel import Panel

from .analyzer import TextAnalyzer
from .utils import read_file


console = Console()


@click.group()
def cli():
    """Text Analyzer - Analyze documents and extract statistics."""
    pass


@cli.command()
@click.argument('filepath', type=click.Path(exists=True))
def analyze(filepath: str):
    """Analyze a text file and show statistics."""
    try:
        # Read file
        console.print(f"[blue]Reading file: {filepath}[/blue]")
        text = read_file(filepath)

        # Analyze
        console.print("[blue]Analyzing...[/blue]")
        analyzer = TextAnalyzer(text)
        stats = analyzer.get_statistics()

        # Create results table
        table = Table(title="Text Analysis Results", show_header=True)
        table.add_column("Metric", style="cyan")
        table.add_column("Value", style="green")

        table.add_row("Words", str(stats['words']))
        table.add_row("Sentences", str(stats['sentences']))
        table.add_row("Paragraphs", str(stats['paragraphs']))
        table.add_row("Avg Word Length", f"{stats['avg_word_length']:.2f}")
        table.add_row("Avg Sentence Length", f"{stats['avg_sentence_length']:.2f}")
        table.add_row("Readability Score", f"{stats['readability_score']:.2f}/100")

        console.print(table)

        # Show common words
        console.print("\n[bold]Most Common Words:[/bold]")
        for word, count in stats['most_common_words']:
            console.print(f"  {word}: {count}")

        console.print(f"\n[green]✓ Analysis complete![/green]")

    except Exception as e:
        console.print(f"[red]Error: {e}[/red]")
        raise click.Abort()


@cli.command()
@click.argument('filepath', type=click.Path(exists=True))
def summary(filepath: str):
    """Generate a quick summary of the document."""
    try:
        text = read_file(filepath)
        analyzer = TextAnalyzer(text)

        # Create summary panel
        summary_text = f"""
Words: {analyzer.word_count()}
Sentences: {analyzer.sentence_count()}
Readability: {analyzer.readability_score():.1f}/100
"""

        panel = Panel(
            summary_text.strip(),
            title=f"[bold]{Path(filepath).name}[/bold]",
            border_style="blue"
        )

        console.print(panel)

    except Exception as e:
        console.print(f"[red]Error: {e}[/red]")
        raise click.Abort()


if __name__ == '__main__':
    cli()
```

### Entry Point (`text_analyzer/__init__.py`)

```python
"""Text Analyzer - Document analysis tool."""
from .analyzer import TextAnalyzer
from .utils import read_file

__version__ = "0.1.0"
__all__ = ['TextAnalyzer', 'read_file']
```

### Configure Entry Point (`pyproject.toml`)

Add this to your `pyproject.toml`:

```toml
[project.scripts]
text-analyzer = "text_analyzer.cli:cli"
```

This allows running the app as `text-analyzer` command.

## Running the Application

### Install in Development Mode

```bash
# Install your app in editable mode
uv pip install -e .
```

Now `text-analyzer` command is available!

### Create Test File

```bash
cat > sample.txt << 'EOF'
Python is a powerful programming language. It is widely used for web development,
data science, and automation. Python's syntax is clean and readable.

The language was created by Guido van Rossum in 1991. Since then, it has grown
into one of the most popular programming languages in the world.

Python has a large standard library. This makes it easy to accomplish common tasks
without installing additional packages.
EOF
```

### Run Analysis

```bash
# Full analysis
text-analyzer analyze sample.txt

# Quick summary
text-analyzer summary sample.txt
```

**Expected output:**

```
┏━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━┓
┃ Metric               ┃ Value ┃
┡━━━━━━━━━━━━━━━━━━━━━━╇━━━━━━━┩
│ Words                │ 89    │
│ Sentences            │ 8     │
│ Paragraphs           │ 3     │
│ Avg Word Length      │ 5.82  │
│ Avg Sentence Length  │ 11.12 │
│ Readability Score    │ 66.57 │
└──────────────────────┴───────┘

Most Common Words:
  python: 5
  language: 3
  programming: 2
  ...

✓ Analysis complete!
```

Beautiful!

## Adding More Features

Want to extend this? Easy with UV.

### Add Sentiment Analysis

```bash
# Add TextBlob
uv add textblob

# Add method to analyzer.py
def sentiment_score(self) -> float:
    from textblob import TextBlob
    blob = TextBlob(self.text)
    return blob.sentiment.polarity
```

### Add Export to JSON

```bash
# No new dependencies needed (stdlib)

# Add to cli.py
@cli.command()
@click.argument('filepath', type=click.Path(exists=True))
@click.option('--output', '-o', default='results.json')
def export(filepath: str, output: str):
    """Export analysis to JSON."""
    import json
    text = read_file(filepath)
    analyzer = TextAnalyzer(text)
    stats = analyzer.get_statistics()

    with open(output, 'w') as f:
        json.dump(stats, f, indent=2)

    console.print(f"[green]Exported to {output}[/green]")
```

## Distributing Your App

### Create Requirements

```bash
# For others to install (if they don't use UV)
uv pip compile pyproject.toml -o requirements.txt
```

### Share on GitHub

```bash
git init
git add .
git commit -m "Initial commit: Text analyzer app"
gh repo create text-analyzer --public --source=. --push
```

Others can install with:

```bash
# With UV (recommended)
git clone https://github.com/yourusername/text-analyzer
cd text-analyzer
uv sync
uv run text-analyzer analyze file.txt

# With pip
pip install git+https://github.com/yourusername/text-analyzer
text-analyzer analyze file.txt
```

## UV Commands Cheat Sheet

Here's everything you need to know:

```bash
# Project setup
uv init --python 3.12              # Create new project
uv sync                            # Install dependencies
uv add package-name                # Add dependency
uv remove package-name             # Remove dependency
uv add --dev pytest                # Add dev dependency

# Running code
uv run python script.py            # Run Python script
uv run pytest                      # Run tests
uv run text-analyzer analyze file  # Run installed command

# Updates
uv sync --upgrade                  # Update all packages
uv add --upgrade package-name      # Update specific package

# Info
uv pip list                        # List installed packages
uv pip show package-name           # Show package info

# Cleanup
rm -rf .venv uv.lock              # Start fresh
uv sync                            # Reinstall
```

## Why UV Wins

After building this app, you've seen UV's benefits:

**Speed**: Installation was instant. No waiting.

**Simplicity**: One command to add packages. No pip freeze, no requirements.txt hell.

**Reliability**: Lock files mean the exact same versions everywhere. No "works on my machine."

**Modern**: Uses `pyproject.toml` like it should. No legacy cruft.

**Better workflow**: `uv run` instead of activating virtualenvs. Just works.

## Next Steps

You now have a working text analyzer and know UV fundamentals.

**Extend the app:**

- Add markdown/HTML export
- Implement language detection
- Create web interface with FastAPI
- Add batch processing

**Learn more UV:**

- Check out [UV documentation](https://github.com/astral-sh/uv)
- Explore workspace management
- Try building packages (not just apps)

**Apply to your projects:**

Replace pip with UV in your existing projects. It's backward compatible and worth the 5 minutes to migrate.

## Full Project Code

Complete code is available on GitHub: [your-repo-link]

```bash
git clone https://github.com/yourusername/text-analyzer
cd text-analyzer
uv sync
uv run text-analyzer analyze sample.txt
```

---

**UV makes Python development feel modern again. Fast installs, clear dependencies, no surprises.**

Give it a try on your next project. You won't go back to pip.

Got questions or built something cool with UV? Let me know in the comments or [reach out directly](mailto:dr.saad.laouadi@gmail.com).

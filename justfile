# Justfile for The Polyglot Engineer Blog
# Run: just <command>

# Default recipe (shows available commands)
default:
    @just --list

# Install dependencies
install:
    uv sync

# Serve site locally with live reload
serve:
    uv run mkdocs serve --clean --dev-addr 127.0.0.1:8000

# force serve
force-serve:
    uv run mkdocs serve --strict --clean --dev-addr 127.0.0.1:8000

# Build site for production
build:
    uv run mkdocs build --strict

# Deploy to GitHub Pages
deploy:
    uv run mkdocs gh-deploy --force

# Clean build artifacts
clean:
    rm -rf site/
    rm -rf .cache/

# Update all dependencies
update:
    uv sync --upgrade
    @echo "Dependencies updated in pyproject.toml and uv.lock"

# Update specific package (usage: just upgrade mkdocs-material)
upgrade PACKAGE:
    uv add --upgrade {{PACKAGE}}

# Create new blog post with today's date
new-post TITLE:
    #!/usr/bin/env bash
    DATE=$(date +%Y-%m-%d)
    SLUG=$(echo "{{TITLE}}" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')
    FILE="docs/blog/${DATE}-${SLUG}.md"
    cat > "$FILE" << EOF
    ---
    title: "{{TITLE}}"
    date: ${DATE}
    authors:
      - Dr. Saad Laouadi
    categories:
      - Blog
    tags:
      - TODO
    description: >
      Add description here
    ---

    # {{TITLE}}

    Write your content here...
    EOF
    echo "Created: $FILE"
    echo "Edit with: vim $FILE"

# Create new tutorial
new-tutorial TITLE:
    #!/usr/bin/env bash
    SLUG=$(echo "{{TITLE}}" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')
    FILE="docs/tutorials/${SLUG}.md"
    cat > "$FILE" << EOF
    # {{TITLE}}

    ## Overview

    ## Prerequisites

    ## Step 1

    ## Step 2

    ## Conclusion
    EOF
    echo "Created: $FILE"

# Create new blog post in draft
create-post-draft TITLE:
    #!/usr/bin/env bash
    DATE=$(date +%Y-%m-%d)
    SLUG=$(echo "{{TITLE}}" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')
    mkdir -p notes/drafts/blog
    FILE="notes/drafts/blog/${DATE}-${SLUG}.md"
    cat > "$FILE" << EOF
    ---
    title: "{{TITLE}}"
    date: ${DATE}
    authors:
      - Dr. Saad Laouadi
    categories:
      - Blog
    tags:
      - TODO
    description: >
      Add description here
    ---

    # {{TITLE}}

    Write your content here...
    EOF
    echo "Created draft: $FILE"
    echo "Edit with: vim $FILE"

# Create new tutorial
create-tutorial TITLE:
    #!/usr/bin/env bash
    SLUG=$(echo "{{TITLE}}" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')
    FILE="docs/tutorials/${SLUG}.md"
    cat > "$FILE" << EOF
    ---
    title: "{{TITLE}}"
    date: $(date +%Y-%m-%d)
    authors:
      - Dr. Saad Laouadi
    categories:
      - Tutorial
    tags:
      - TODO
    description: >
      Add description here
    ---

    # {{TITLE}}

    ## Overview

    ## Prerequisites

    ## Step 1

    ## Step 2

    ## Conclusion
    EOF
    echo "Created: $FILE"
    echo "Edit with: vim $FILE"

# Create new tutorial in draft
create-tutorial-draft TITLE:
    #!/usr/bin/env bash
    SLUG=$(echo "{{TITLE}}" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')
    mkdir -p notes/drafts/tutorials
    FILE="notes/drafts/tutorials/${SLUG}.md"
    cat > "$FILE" << EOF
    ---
    title: "{{TITLE}}"
    date: $(date +%Y-%m-%d)
    authors:
      - Dr. Saad Laouadi
    categories:
      - Tutorial
    tags:
      - TODO
    description: >
      Add description here
    ---

    # {{TITLE}}

    ## Overview

    ## Prerequisites

    ## Step 1

    ## Step 2

    ## Conclusion
    EOF
    echo "Created draft: $FILE"
    echo "Edit with: vim $FILE"

# Create new guide
create-guide TITLE:
    #!/usr/bin/env bash
    SLUG=$(echo "{{TITLE}}" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')
    FILE="docs/guides/${SLUG}.md"
    cat > "$FILE" << EOF
    ---
    title: "{{TITLE}}"
    date: $(date +%Y-%m-%d)
    authors:
      - Dr. Saad Laouadi
    categories:
      - Guide
    tags:
      - TODO
    description: >
      Add description here
    ---

    # {{TITLE}}

    ## Introduction

    ## Table of Contents

    ## Getting Started

    ## Advanced Topics

    ## Best Practices

    ## Conclusion

    ## Resources
    EOF
    echo "Created: $FILE"
    echo "Edit with: vim $FILE"

# Create new guide in draft
create-guide-draft TITLE:
    #!/usr/bin/env bash
    SLUG=$(echo "{{TITLE}}" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')
    mkdir -p notes/drafts/guides
    FILE="notes/drafts/guides/${SLUG}.md"
    cat > "$FILE" << EOF
    ---
    title: "{{TITLE}}"
    date: $(date +%Y-%m-%d)
    authors:
      - Dr. Saad Laouadi
    categories:
      - Guide
    tags:
      - TODO
    description: >
      Add description here
    ---

    # {{TITLE}}

    ## Introduction

    ## Table of Contents

    ## Getting Started

    ## Advanced Topics

    ## Best Practices

    ## Conclusion

    ## Resources
    EOF
    echo "Created draft: $FILE"
    echo "Edit with: vim $FILE"

# Create new project showcase
create-project TITLE:
    #!/usr/bin/env bash
    SLUG=$(echo "{{TITLE}}" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')
    FILE="docs/projects/${SLUG}.md"
    cat > "$FILE" << EOF
    ---
    title: "{{TITLE}}"
    date: $(date +%Y-%m-%d)
    authors:
      - Dr. Saad Laouadi
    categories:
      - Project
    tags:
      - TODO
    description: >
      Add description here
    ---

    # {{TITLE}}

    ## Overview

    ## Problem Statement

    ## Solution

    ## Tech Stack

    ## Key Features

    ## Results

    ## Code

    GitHub: [repository-link]

    ## Lessons Learned
    EOF
    echo "Created: $FILE"
    echo "Edit with: vim $FILE"

# Create new project showcase in draft
create-project-draft TITLE:
    #!/usr/bin/env bash
    SLUG=$(echo "{{TITLE}}" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')
    mkdir -p notes/drafts/projects
    FILE="notes/drafts/projects/${SLUG}.md"
    cat > "$FILE" << EOF
    ---
    title: "{{TITLE}}"
    date: $(date +%Y-%m-%d)
    authors:
      - Dr. Saad Laouadi
    categories:
      - Project
    tags:
      - TODO
    description: >
      Add description here
    ---

    # {{TITLE}}

    ## Overview

    ## Problem Statement

    ## Solution

    ## Tech Stack

    ## Key Features

    ## Results

    ## Code

    GitHub: [repository-link]

    ## Lessons Learned
    EOF
    echo "Created draft: $FILE"
    echo "Edit with: vim $FILE"

# Move draft to published (usage: just publish-draft guides/getting-started-with-uv)
publish-draft PATH:
    #!/usr/bin/env bash
    DRAFT_FILE="notes/drafts/{{PATH}}.md"
    PUB_FILE="docs/{{PATH}}.md"

    if [ ! -f "$DRAFT_FILE" ]; then
        echo "Error: Draft not found: $DRAFT_FILE"
        exit 1
    fi

    mkdir -p $(dirname "$PUB_FILE")
    mv "$DRAFT_FILE" "$PUB_FILE"
    echo "Published: $DRAFT_FILE → $PUB_FILE"


# Show recent guides
recent-guides:
    #!/usr/bin/env bash
    for file in docs/guides/*.md; do
        date=$(grep "^date:" "$file" | cut -d' ' -f2)
        echo "$date - $(basename $file)"
    done | sort -r | head -10

# Show recent tutorials
recent-tutorials:
    #!/usr/bin/env bash
    for file in docs/tutorials/*.md; do
        date=$(grep "^date:" "$file" | cut -d' ' -f2)
        echo "$date - $(basename $file)"
    done | sort -r | head -10

# Run pre-commit on all files
lint:
    pre-commit run --all-files

# Format Python files with ruff
format:
    uv run ruff format .

# Lint Python files with ruff (with auto-fix)
ruff:
    uv run ruff check --fix .

# Lint Python files (check only, no fixes)
ruff-check:
    uv run ruff check .

# Format and lint Python files
python-lint: format ruff
    @echo "✅ Python formatting and linting complete!"

# Check for broken links
check-links:
    uv run mkdocs build --strict
    @echo "Build successful - no broken links!"

# Git commit with message (usage: just commit "message")
commit MESSAGE:
    git add .
    git commit -m "{{MESSAGE}}"

# Git push to main
push:
    git push origin main

# Full workflow: build, commit, push, deploy
publish MESSAGE:
    just build
    just commit "{{MESSAGE}}"
    just push
    just deploy
    @echo "✅ Published successfully!"

# Quick workflow: commit and push (auto-deploy via GitHub Actions)
quick MESSAGE:
    just commit "{{MESSAGE}}"
    just push
    @echo "✅ Pushed! GitHub Actions will deploy automatically."

# View site statistics
stats:
    @echo "Site Statistics:"
    @echo "****************"
    @echo "Blog posts: $(find docs/blog -name '*.md' | wc -l)"
    @echo "Tutorials: $(find docs/tutorials -name '*.md' | wc -l)"
    @echo "Guides: $(find docs/guides -name '*.md' | wc -l)"
    @echo "Projects: $(find docs/projects -name '*.md' | wc -l)"
    @echo "Total pages: $(find docs -name '*.md' | wc -l)"

# Open blog in browser
open:
    @open http://127.0.0.1:8000 || xdg-open http://127.0.0.1:8000

# Serve and open in browser
dev:
    @just open &
    @just serve

# Show project info
info:
    @echo ">>> The Polyglot Engineer Blog"
    @echo "Repository: https://github.com/dr-saad-la/polyglot-engineer-blog"
    @echo "Live Site: https://dr-saad-la.github.io/polyglot-engineer-blog/"
    @echo ""
    @echo "Python: $(python --version)"
    @echo "UV: $(uv --version)"
    @echo "MkDocs: $(uv run mkdocs --version)"
    @echo "Ruff: $(uv run ruff --version)"

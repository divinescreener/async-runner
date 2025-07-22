#!/bin/bash

# Setup pre-commit hooks for divine-async-runner

set -e

echo "Setting up pre-commit hooks for divine-async-runner..."

# Check if Poetry is available
if ! command -v poetry &> /dev/null; then
    echo "❌ Poetry is required but not installed."
    echo "Please install Poetry first: https://python-poetry.org/docs/#installation"
    exit 1
fi

# Install development dependencies
echo "Installing development dependencies..."
poetry install --with dev

# Install pre-commit hooks
echo "Installing pre-commit hooks..."
poetry run pre-commit install

# Generate secrets baseline if it doesn't exist
if [ ! -f .secrets.baseline ]; then
    echo "Generating secrets baseline..."
    poetry run detect-secrets scan --baseline .secrets.baseline
fi

echo "✅ Pre-commit hooks installed successfully!"
echo "Run 'poetry run pre-commit run --all-files' to test all hooks."
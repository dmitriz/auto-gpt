#!/bin/bash
# This script checks for sensitive information in files being committed
# Usage: ./scripts/pre-commit-check.sh

# Function to show error and exit
show_error() {
  echo "ERROR: $1"
  echo "FIX: $2"
  exit 1
}

# Check if trying to commit to main/master branch
BRANCH=$(git symbolic-ref HEAD 2>/dev/null | cut -d'/' -f3)
if [ "$BRANCH" = "main" ] || [ "$BRANCH" = "master" ]; then
  show_error "Committing directly to $BRANCH branch is not allowed." "Create a feature branch and make a pull request instead."
fi

# Prevent committing .env files
if git diff --cached --name-only | grep -E '\.env$'; then
  show_error "Attempting to commit .env file, which may contain secrets." "Remove this file with: git reset .env"
fi

# Check for potential API keys in staged files (20+ character alphanumeric strings)
API_KEYS=$(git diff --cached | grep -E '[A-Za-z0-9_-]{20,}')
if [ -n "$API_KEYS" ]; then
  echo "WARNING: Possible API keys or tokens detected in staged files:"
  echo "$API_KEYS"
  echo ""
  echo "Please review these matches to ensure you're not committing secrets."
  echo "To proceed anyway (if these are NOT secrets), use: git commit --no-verify"
  exit 1
fi

exit 0

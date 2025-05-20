#!/usr/bin/env bash
set -euo pipefail
# Simple pre-commit script to prevent accidental commit of .env files
# This file should be kept in scripts/pre-commit-check.sh
# It is called by the Git hook at .git/hooks/pre-commit

# Function to show error and exit with code 1 (failure)
show_error() {
  echo "ERROR: $1"
  echo "FIX: $2"
  exit 1
}

# Check if trying to commit to main/master branch
BRANCH=$(git rev-parse --abbrev-ref HEAD)
if [ "$BRANCH" = "main" ] || [ "$BRANCH" = "master" ]; then
  show_error "Committing directly to $BRANCH branch is not allowed." "Create a feature branch and make a pull request instead."
fi

# Prevent committing .env files but allow .env.example
# git diff --cached --name-only shows files staged for commit
# grep -E '\.env$' matches exactly .env (not .env.example)
if git diff --cached --name-only | grep -E '\.env$'; then
  show_error "Attempting to commit .env file, which may contain secrets." "Remove this file with: git reset .env"
fi

# If all checks pass, exit with code 0 (success)
exit 0

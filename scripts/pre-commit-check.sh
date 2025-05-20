#!/bin/bash
# Pre-commit script to prevent accidental commit of secrets
# This file should be kept in scripts/pre-commit-check.sh
# It is called by the Git hook at .git/hooks/pre-commit
# No need to make this executable - it's run with bash from the hook

# Function to show error and exit with code 1 (failure)
# Parameters:
#   $1: Error message to display
#   $2: Suggested fix for the error
show_error() {
  echo "ERROR: $1"
  echo "FIX: $2"
  exit 1
}

# Check if trying to commit to main/master branch
# git symbolic-ref HEAD gets the current branch reference
# cut -d'/' -f3 extracts the branch name from refs/heads/branch-name
BRANCH=$(git symbolic-ref HEAD 2>/dev/null | cut -d'/' -f3)
if [ "$BRANCH" = "main" ] || [ "$BRANCH" = "master" ]; then
  show_error "Committing directly to $BRANCH branch is not allowed." "Create a feature branch and make a pull request instead."
fi

# Prevent committing .env files but allow .env.example
# git diff --cached --name-only shows files staged for commit
# grep -E '\.env$' matches exactly .env (not .env.example)
if git diff --cached --name-only | grep -E '\.env$'; then
  show_error "Attempting to commit .env file, which may contain secrets." "Remove this file with: git reset .env"
fi

# Check for potential API keys in staged files (20+ character alphanumeric strings)
# Note: This is a basic check and may produce false positives for URLs or other long strings
# git diff --cached shows the staged content differences
# grep -E '[A-Za-z0-9_-]{20,}' finds strings with 20+ alphanumeric chars, which might be API keys
API_KEYS=$(git diff --cached | grep -E '[A-Za-z0-9_-]{20,}')
if [ -n "$API_KEYS" ]; then
  echo "WARNING: Possible API keys or tokens detected in staged files:"
  echo "$API_KEYS"
  echo ""
  echo "Please review these matches to ensure you're not committing secrets."
  echo "To proceed anyway (if these are NOT secrets), use: git commit --no-verify"
  exit 1
fi

# If all checks pass, exit with code 0 (success)
exit 0

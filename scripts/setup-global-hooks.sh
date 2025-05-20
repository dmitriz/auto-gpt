#!/bin/bash
# Script to set up global Git hooks for all repositories
# This will create hooks in your global Git template directory

# Create global Git hooks directory if it doesn't exist
HOOKS_DIR="$HOME/.git-templates/hooks"
mkdir -p "$HOOKS_DIR"

# Tell Git to use this template directory
git config --global init.templateDir "$HOME/.git-templates"

# Create global pre-commit hook
cat > "$HOOKS_DIR/pre-commit" << 'EOL'
#!/bin/bash

# Global pre-commit hook for all Git repositories
# Safety checks for sensitive information

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

# Check for potential API keys in staged files
API_KEYS=$(git diff --cached | grep -E '[A-Za-z0-9_-]{20,}')
if [ -n "$API_KEYS" ]; then
  echo "WARNING: Possible API keys or tokens detected in staged files:"
  echo "$API_KEYS"
  echo ""
  echo "Please review these matches to ensure you're not committing secrets."
  echo "To proceed anyway (if these are NOT secrets), use: git commit --no-verify"
  exit 1
fi

# Look for project-specific hook
PROJECT_HOOK="$(git rev-parse --show-toplevel)/scripts/pre-commit-check.sh"
if [ -f "$PROJECT_HOOK" ]; then
  # If this repository has its own pre-commit check, run it too
  "$PROJECT_HOOK"
fi

exit 0
EOL

# Make the hook executable
chmod +x "$HOOKS_DIR/pre-commit"

echo "Global Git hooks installed in $HOOKS_DIR"
echo "These hooks will apply to all repositories (both existing and new)"
echo "For existing repositories, run 'git init' in each repository to apply the template"

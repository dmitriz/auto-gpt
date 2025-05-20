#!/bin/bash
# Script to set up global Git hooks for all repositories
# Creates hooks in your global Git template directory
# After running this, ALL new and existing Git repositories will use these hooks
# For existing repositories, you'll need to run 'git init' in each one

# Create global Git hooks directory if it doesn't exist
# ~/.git-templates/hooks is the standard location for global Git hook templates
HOOKS_DIR="$HOME/.git-templates/hooks"
mkdir -p "$HOOKS_DIR"

# Tell Git to use this template directory
# This configures Git to copy all files from this directory when initializing a repository
# This is a permanent, user-level setting that's stored in ~/.gitconfig
# You only need to run this command once, and it will apply to all future git init operations
git config --global init.templateDir "$HOME/.git-templates"

# Create global pre-commit hook
# The 'cat > file << EOL' syntax creates a file with the content between EOL markers
cat > "$HOOKS_DIR/pre-commit" << 'EOL'
#!/bin/bash

# Global pre-commit hook for all Git repositories
# Simple protection for .env files and main branch commits

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

# Prevent committing .env files but allow .env.example
if git diff --cached --name-only | grep -E '\.env$'; then
  show_error "Attempting to commit .env file, which may contain secrets." "Remove this file with: git reset .env"
fi

# Look for project-specific hook
PROJECT_HOOK="$(git rev-parse --show-toplevel)/scripts/pre-commit-check.sh"
if [ -f "$PROJECT_HOOK" ]; then
  # Run the project's hook with bash (no need to make it executable)
  bash "$PROJECT_HOOK"
fi

exit 0
EOL

# Ensure the hook can be executed by Git
# Note: We must use chmod here because Git requires the hook to be executable
# This is a system-level hook that Git will directly execute (not called with bash)
chmod +x "$HOOKS_DIR/pre-commit"

# Show success message with usage instructions
echo "Global Git hooks installed in $HOOKS_DIR"
echo "These hooks will apply to all repositories (both existing and new)"
echo "For existing repositories, run 'git init' in each repository to apply the template"

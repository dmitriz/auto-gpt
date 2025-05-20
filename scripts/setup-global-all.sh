#!/bin/bash
# Global setup script to create all necessary files outside this repository
# This script creates and configures:
# 1. GitHub Copilot global instructions
# 2. VS Code global settings
# 3. Global Git hooks

# Color codes for better readability
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Print section header
print_section() {
  echo -e "\n${YELLOW}$1${NC}"
  echo "------------------------------------------------------------"
}

# Print success message
print_success() {
  echo -e "${GREEN}✓ $1${NC}"
}

# Function to create a directory if it doesn't exist
ensure_dir() {
  if [ ! -d "$1" ]; then
    mkdir -p "$1"
    echo "Created directory: $1"
  else
    echo "Directory already exists: $1"
  fi
}

# ====================================================================
print_section "1. Creating GitHub Copilot global instructions"
# ====================================================================

# Create .vscode directory in home folder
ensure_dir "$HOME/.vscode"

# Create the GitHub Copilot instructions file
COPILOT_INSTRUCTIONS="$HOME/.vscode/github-copilot-instructions.md"

cat > "$COPILOT_INSTRUCTIONS" << 'EOL'
<!-- Global custom instructions for GitHub Copilot that apply to all projects -->

## IMPORTANT RULES: ALWAYS FOLLOW THESE GUIDELINES

1. Focus on the exact requested task - complete it in the fastest possible way without getting distracted
2. Do not deviate from what is explicitly asked - if in doubt, ask for clarification
3. Provide extensive comments for all code - explain each line or block of code clearly
4. Comment ABOVE lines of code, not on the same line, for better readability
5. Keep solutions simple and minimalistic - avoid unnecessary dependencies
6. Never make files executable - use `bash script.sh` instead of `chmod +x script.sh`
7. Leave `.env.example` files empty (no placeholders) - just define the variable names
8. Document all changes comprehensively in README files
9. Never implement anything without explicit approval
10. Use minimal number of files - prefer fewer, longer files over many small files
11. Be conscious of time - stop and ask if something is taking too long
12. Always verify your changes for errors before completing tasks
13. Place comments in the file where the logic is executed, not in redirector files
14. Don't try different approaches - focus on the most direct way to complete a task
15. Always verify and fix errors/warnings before considering a task complete
EOL

print_success "Created global Copilot instructions: $COPILOT_INSTRUCTIONS"

# ====================================================================
print_section "2. Setting up VS Code global settings"
# ====================================================================

# Create VS Code settings directory
VS_CODE_SETTINGS_DIR="$HOME/.config/Code/User"
ensure_dir "$VS_CODE_SETTINGS_DIR"

# Path to the settings file
VS_CODE_SETTINGS="$VS_CODE_SETTINGS_DIR/settings.json"

# Check if the file already exists
if [ -f "$VS_CODE_SETTINGS" ]; then
  echo "VS Code settings file already exists. Updating..."
  # Make a backup
  cp "$VS_CODE_SETTINGS" "$VS_CODE_SETTINGS.bak"
  echo "Created backup at $VS_CODE_SETTINGS.bak"
  
  # Read the existing settings
  if command -v jq > /dev/null; then
    # Use jq if available for proper merging
    jq --arg path "$HOME/.vscode/github-copilot-instructions.md" '. + {
      "github.copilot.enable": {"*": true}, 
      "github.copilot.customization.instructionsPath": $path,
      "files.exclude": {"**/.git": false}
    }' "$VS_CODE_SETTINGS.bak" > "$VS_CODE_SETTINGS"
  else
    # Simple approach if jq is not available
    echo "Warning: jq not found, using a simplified approach"
    
    # Create a new settings file with our settings
    cat > "$VS_CODE_SETTINGS" << EOL
{
    "github.copilot.enable": { "*": true },
    "github.copilot.customization.instructionsPath": "~/.vscode/github-copilot-instructions.md",
    "files.exclude": { "**/.git": false }
}
EOL
    echo "Note: This replaces your existing settings. The backup is at $VS_CODE_SETTINGS.bak"
  fi
else
  # Create a new settings file
  cat > "$VS_CODE_SETTINGS" << EOL
{
    "github.copilot.enable": { "*": true },
    "github.copilot.customization.instructionsPath": "~/.vscode/github-copilot-instructions.md",
    "files.exclude": { "**/.git": false }
}
EOL
fi

print_success "Configured VS Code settings: $VS_CODE_SETTINGS"

# ====================================================================
print_section "3. Setting up global Git hooks"
# ====================================================================

# Create global Git hooks directory
HOOKS_DIR="$HOME/.git-templates/hooks"
ensure_dir "$HOOKS_DIR"

# Tell Git to use this template directory
git config --global init.templateDir "$HOME/.git-templates"
print_success "Set Git to use global template directory: ~/.git-templates"

# Create global pre-commit hook
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

# Make the hook executable
chmod +x "$HOOKS_DIR/pre-commit"
print_success "Created global Git pre-commit hook: $HOOKS_DIR/pre-commit"

# ====================================================================
print_section "Summary: All Global Files Created"
# ====================================================================
echo "1. Global GitHub Copilot instructions: $COPILOT_INSTRUCTIONS"
echo "2. Global VS Code settings: $VS_CODE_SETTINGS"
echo "3. Global Git hooks: $HOOKS_DIR/pre-commit"
echo "4. Git configuration: Global templateDir set to ~/.git-templates"

echo -e "\n${YELLOW}Important Next Steps:${NC}"
echo "• For existing Git repositories, run 'git init' to apply the global hooks"
echo "• Restart VS Code to apply the new settings"
echo -e "\n${GREEN}All global files have been successfully set up!${NC}"

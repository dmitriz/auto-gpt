# Global Files Documentation

This document lists all files that have been created outside this repository as part of the project setup.

## Global Configuration Files

These files are located in your home directory and provide system-wide settings:

1. **~/.vscode/github-copilot-instructions.md**
   - Purpose: Contains global GitHub Copilot instructions
   - Content: 15 coding guidelines that Copilot follows for every project
   - Created by: Manual setup

2. **~/.config/Code/User/settings.json**
   - Purpose: Global VS Code settings
   - Key settings added:

     ```json
     {
       "github.copilot.enable": { "*": true },
       "github.copilot.customization.instructionsPath": "~/.vscode/github-copilot-instructions.md",
       "files.exclude": { "**/.git": false }
     }
     ```

   - Created by: Manual setup

3. **~/.git-templates/hooks/pre-commit**
   - Purpose: Global Git hook template applied to all repositories
   - Content: Script that prevents .env files from being committed and blocks commits to main/master
   - Created by: Running `make setup-global-hooks` 
   - Activated by: Git config setting (see below)

4. **~/.gitconfig** (modified)
   - Purpose: Git global configuration
   - Setting added: `init.templateDir=~/.git-templates`
   - Modified by: Running `make setup-global-hooks`

## How to Verify These Files

You can check if these files exist and are properly configured with these commands:

```bash
# Check GitHub Copilot instructions file
ls -la ~/.vscode/github-copilot-instructions.md
cat ~/.vscode/github-copilot-instructions.md | head -5

# Check VS Code settings
cat ~/.config/Code/User/settings.json | grep copilot

# Check global Git hooks
ls -la ~/.git-templates/hooks/

# Check Git configuration
git config --global --get init.templateDir
```

## How to Install/Recreate These Files

If you need to recreate these files:

1. For GitHub Copilot instructions and VS Code settings:
   - See detailed steps in `VS_CODE_SETTINGS_DOC.md`

2. For global Git hooks:
   - Run `make setup-global-hooks` from this repository

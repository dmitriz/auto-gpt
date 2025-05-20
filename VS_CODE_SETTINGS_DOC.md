# VS Code Global Settings Documentation

This document explains the purpose of the global VS Code settings that were set up.

## Location of files

- **Global Settings**: `~/.config/Code/User/settings.json`
- **Global Copilot Instructions**: `~/.vscode/github-copilot-instructions.md`

## Settings explanation

The settings.json file contains three important settings:

1. `"github.copilot.enable": true`
   - Purpose: Enables GitHub Copilot globally for all workspaces
   - Effect: Ensures Copilot is active in every project

2. `"github.copilot.customization.instructionsPath": "~/.vscode/github-copilot-instructions.md"`
   - Purpose: Points to the file containing your custom instructions for Copilot
   - Effect: Makes Copilot follow your specific guidelines in all projects

3. `"files.exclude": { "**/.git": false }`
   - Purpose: Makes the .git directory visible in the VS Code explorer
   - Effect: Allows you to see and edit Git hooks directly in the VS Code interface

## How to verify these settings are working

### Verify VS Code and Copilot settings

1. **Verify Copilot instructions are working**:
   - Open any project and use Copilot Chat
   - Ask: "What instructions should you follow when generating code?"
   - Copilot should list your custom guidelines from the instructions file
   - Example test: Create a new file and ask Copilot to "Create a function to process user input"
   - Verify that the generated code has comments ABOVE lines (not inline) and follows your other guidelines

2. **Verify .git visibility**:
   - Open any Git repository in VS Code
   - The .git folder should be visible in the explorer panel
   - You should be able to navigate to .git/hooks to see your hook files

3. **Verify settings are actually working** (not just present in files):

   - Open a new file in VS Code and type: `// Create a function that validates user inputs`
   - Wait for Copilot suggestions and check if they:
     - Include comments ABOVE code lines (rule #4)
     - Use a simple approach (rule #5)
     - Have extensive comments (rule #3)
   - This confirms instructions are being applied, not just existing in files

### Verify Global Git Hooks

1. **Test .env file protection in this repository**:

   ```bash
   # Create and stage an .env file
   echo "SECRET=123" > .env
   git add .env
   
   # Attempt to commit (should be blocked with error message)
   git commit -m "test commit"
   
   # Clean up
   git reset .env
   rm .env
   ```

2. **Test main branch protection**:

   ```bash
   # Create a test file on main branch
   echo "test" > test.txt
   git add test.txt
   
   # Attempt to commit (should be blocked with error message)
   git commit -m "test commit on main"
   
   # Clean up
   git reset test.txt
   rm test.txt
   ```

3. **About existing repositories**:

   For repositories created before setting up global hooks, you need to run `git init` once in each repository to apply the hooks. After that, all new repositories you create will automatically have these hooks.

## Advanced customization

If you need to add more settings later, you can edit:

- **Global VS Code settings**: `~/.config/Code/User/settings.json`
- **Global Copilot instructions**: `~/.vscode/github-copilot-instructions.md`
- **Global Git hooks**: `~/.git-templates/hooks/pre-commit`

Official documentation for all available VS Code settings can be found at: <https://code.visualstudio.com/docs/getstarted/settings>

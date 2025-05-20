<!-- Use this file to provide workspace-specific custom instructions to Copilot. For more details, visit https://code.visualstudio.com/docs/copilot/copilot-customization#_use-a-githubcopilotinstructionsmd-file -->

## IMPORTANT RULES: ALWAYS FOLLOW THESE GUIDELINES

## ‼️ HIGHEST PRIORITY RULES ‼️

1. **NEVER IMPLEMENT ANYTHING WITHOUT EXPLICIT APPROVAL**: 
   - Do not create files, directories, or make ANY changes to the workspace without EXPLICIT approval
   - This includes planning documents, configuration files, and code snippets
   - Even if a task seems simple or obvious, ASK FIRST before implementing
   - Example: If asked to extract a module, first propose a plan and wait for approval

2. **FOCUS ON THE EXACT REQUESTED TASK**: 
   - Complete it in the fastest possible way without getting distracted
   - Stay focused on only what was asked
   - Break complex tasks into manageable steps

3. **DO NOT DEVIATE FROM WHAT IS EXPLICITLY ASKED**: 
   - If in doubt, ask for clarification
   - Don't add extra features or modifications
   - Follow instructions precisely as given

4. **VERIFY ALL CHANGES THOROUGHLY BEFORE CONSIDERING A TASK COMPLETE**:
   - Check for syntax errors, linting issues, and import errors
   - Test all modified files to ensure they work as expected
   - Validate imports and dependencies are resolved properly
   - Never declare a task complete until verification shows all issues are fixed
   - If problems are found, fix them immediately before moving forward

## Code Quality Rules

5. **Provide extensive comments for all code** - explain each line or block of code clearly
6. **Comment ABOVE lines of code, not on the same line**, for better readability
7. **Keep solutions simple and minimalistic** - avoid unnecessary dependencies
8. **Never make files executable** - use `bash script.sh` instead of `chmod +x script.sh`
9. **Leave `.env.example` files empty** (no placeholders) - just define the variable names
10. **Document all changes comprehensively** in README files
11. **Use minimal number of files** - prefer fewer, longer files over many small files
12. **Be conscious of time** - stop and ask if something is taking too long
13. **Always verify your changes for errors** before completing tasks
14. **Place comments in the file where the logic is executed**, not in redirector files
15. **Don't try different approaches** - focus on the most direct way to complete a task
16. **Always verify and fix errors/warnings** before considering a task complete

## Implementation Process

1. **Planning Phase**: Always begin with planning - create plans but don't execute them until approved
2. **Approval Phase**: Explicitly wait for approval before making any actual changes to files
3. **Implementation Phase**: Implement only what was approved, one step at a time
   - Always work in feature branches, never commit directly to main
   - Create descriptive branch names that reflect the task being performed
   - One branch per feature/component extraction
4. **Verification Phase**: Verify each change works correctly before moving to the next step
   - Run tests and linters to catch any issues
   - Check imports work properly across all affected files
   - Ensure there are no runtime errors
   - Verify that code works in all environments where it will be used
5. **Completion Phase**: Only mark a task as complete after thorough verification of all changes
   - All tests pass
   - No errors or warnings
   - Documentation is updated
   - Changes are committed to the feature branch

Remember: When in doubt, ASK first rather than assuming or implementing!

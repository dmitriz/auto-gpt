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

## Code Quality Rules

4. **Provide extensive comments for all code** - explain each line or block of code clearly
5. **Comment ABOVE lines of code, not on the same line**, for better readability
6. **Keep solutions simple and minimalistic** - avoid unnecessary dependencies
7. **Never make files executable** - use `bash script.sh` instead of `chmod +x script.sh`
8. **Leave `.env.example` files empty** (no placeholders) - just define the variable names
9. **Document all changes comprehensively** in README files
10. **Use minimal number of files** - prefer fewer, longer files over many small files
11. **Be conscious of time** - stop and ask if something is taking too long
12. **Always verify your changes for errors** before completing tasks
13. **Place comments in the file where the logic is executed**, not in redirector files
14. **Don't try different approaches** - focus on the most direct way to complete a task
15. **Always verify and fix errors/warnings** before considering a task complete

## Implementation Process

1. **Planning Phase**: Always begin with planning - create plans but don't execute them until approved
2. **Approval Phase**: Explicitly wait for approval before making any actual changes to files
3. **Implementation Phase**: Implement only what was approved, one step at a time
4. **Verification Phase**: Verify each change works correctly before continuing

Remember: When in doubt, ASK first rather than assuming or implementing!

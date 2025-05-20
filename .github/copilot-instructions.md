<!-- Use this file to provide workspace-specific custom instructions to Copilot. For more details, visit https://code.visualstudio.com/docs/copilot/copilot-customization#_use-a-githubcopilotinstructionsmd-file -->

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
15. Always verify and fix errors/warnings before considering a task complete- Use this file to provide workspace-specific custom instructions to Copilot. For more details, visit https://code.visualstudio.com/docs/copilot/copilot-customization#_use-a-githubcopilotinstructionsmd-file -->

This project mimics AutoGPT’s website browsing: it fetches and parses a webpage, extracts visible text, and uses OpenAI GPT to answer user questions about the page. Use requests, BeautifulSoup, and OpenAI API. Entry point: main.py.

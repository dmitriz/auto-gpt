# Simplified Migration Plan

**Components to Extract:**

1. **LLM Integration Module** (ask_llm.py)
2. **Git Hooks Utilities** (scripts/pre-commit-check.sh)
3. **VS Code Utilities** (from setup-global-all.sh)

## CORE PRINCIPLES - READ FIRST

1. **ONE COMPONENT AT A TIME**: We will extract, test, and complete ONLY ONE component fully before starting on any other component. This is the most important rule.
   - Focus entirely on one component until it's 100% working
   - Only after a component is complete will we consider the next component
   - Each component gets our full attention until completion

2. **ABSOLUTE MINIMUM CHANGES**: Each step will make the smallest possible change (often just one file). No premature directory structures or files.
   - Each change should be as small as possible to minimize risk
   - Create only what's needed for the current step, nothing more
   - Prefer modifying one file at a time when possible

3. **UNIVERSAL REUSABILITY**: Each component must work independently of our original project and be usable in any other project.
   - Components should have clear, well-defined interfaces
   - Minimize dependencies between components
   - Each extracted module should work as a standalone package

4. **CONTINUOUS VALIDATION**: We will test after EVERY single change, no matter how small, to ensure functionality is preserved.
   - Test both the original application and the extracted component
   - Verify that behavior remains identical after each change
   - Never proceed to the next step if tests fail

5. **NO PREMATURE OPTIMIZATION**: We will first focus on making each component work correctly before improving its structure, documentation, or packaging.
   - First priority: Make it work correctly
   - Second priority: Make it clean and maintainable
   - Final priority: Optimize and enhance

This document provides a detailed, step-by-step plan to extract reusable functionality from our project. Each component will be completed fully before moving to the next one. This approach ensures we don't get overwhelmed by trying to extract everything at once and reduces the risk of breaking existing functionality. By focusing on one component at a time, we can verify each extraction thoroughly and ensure our codebase remains stable throughout the process.

## Current Focus: LLM Integration Module (ask_llm.py)

We are focusing on the **LLM Integration Module (ask_llm.py)** as our first component to extract:

1. It has relatively minimal dependencies (only requires openai and python-dotenv)

2. It has a clear responsibility (interfacing with language models)

3. It provides a clean API for language model interactions

4. It's widely applicable across many AI projects

### Module Location

We will create the LLM Integration Module as a separate repository next to the current repository. To be clear:

- The module will be at path: `/home/z/repos/llm-integration`
- This is a NEW repository OUTSIDE the current repository
- We are extracting this functionality completely outside of the auto-gpt project
- All paths will use absolute references to ensure clarity

The web scraping module (browser.py) will remain as part of the core project and will not be extracted.

The remaining components to extract after this:

1. Git Hooks Utilities (scripts/pre-commit-check.sh)

2. VS Code Utilities (from setup-global-all.sh)

## Step 1: Extract LLM Integration Module

1. **Create a single directory for the extracted module**

   - `mkdir -p /home/z/repos/llm-integration`
   - This is the only new directory needed to start
   - Confirm creation with `ls -la /home/z/repos/llm-integration` to verify it exists

2. **Copy ask_llm.py to llm-integration with minimal changes**

   - `cp /home/z/repos/auto-gpt/ask_llm.py /home/z/repos/llm-integration/llm_integration.py`
   - Rename the file to match the new module purpose
   - No functionality changes yet
   - Verify with `diff -u /home/z/repos/auto-gpt/ask_llm.py /home/z/repos/llm-integration/llm_integration.py` to ensure only file path comments changed

3. **Create minimal package structure**

   - Create `/home/z/repos/llm-integration/__init__.py` to expose the module
   - Add only this line to `__init__.py`: `from .llm_integration import ask_gpt`
   - Create `/home/z/repos/llm-integration/setup.py` with only essential metadata
   - No README or extra files at this stage
   - Test that import works with `python -c "import sys; sys.path.append('/home/z/repos/llm-integration'); from llm_integration import ask_gpt; print(ask_gpt)"`

4. **Test the extracted module independently**

   - Create a simple test script that imports and uses the new module
   - Verify it works exactly the same as the original
   - Sample test script:

     ```python
     # test_llm_integration.py
     import sys
     import os
     sys.path.append('/home/z/repos/llm-integration')  # Add extracted module directory to path
     from llm_integration import ask_gpt

     # Test the function with a sample question and context
     question = "What is this text about?"
     context = "This is a test of the LLM integration module. It should work exactly the same as before."
     
     # Make sure the API key is set
     if not os.getenv("OPENAI_API_KEY"):
         print("Warning: OPENAI_API_KEY not set. Set it before running this test.")
     else:
         answer = ask_gpt(question, context)
         print(f"Question: {question}")
         print(f"Answer: {answer}")
     ```

   - Run with: `python /home/z/repos/auto-gpt/test_llm_integration.py`

5. **Update original ask_llm.py to use the new module**

   - Modify to import the functionality from the new location
   - Maintain exact same behavior and API
   - This ensures main application still works without changes
   - Example of updated ask_llm.py:

     ```python
     # Wrapper module that maintains backward compatibility
     import sys
     sys.path.append('/home/z/repos/llm-integration')  # Add extracted module directory to path
     from llm_integration import ask_gpt
     # No other changes needed - the original function is now re-exported
     ```

   - Test with: `python -c "import sys; sys.path.insert(0, '/home/z/repos/auto-gpt'); import ask_llm; print(ask_llm.ask_gpt('What is this?', 'This is a test.'))`

## Running Tests After Each Step

For each change above:

1. Run the original application to ensure it still works

   - Use `python /home/z/repos/auto-gpt/main.py https://example.com "What is this page about?"`
   - Verify the output is as expected

2. Only move to the next step if the current one is successful

   - Document each successful step with date/time
   - Use Git commits with clear messages after each step 

3. If something breaks, immediately revert to the working state

   - Use `git reset --hard HEAD~1` if changes were committed
   - Or restore from backup copies if not using Git

## Next Steps After LLM Integration Module

After completing the LLM Integration Module, we'll proceed to extract the next components in order:

1. Git Hooks Utilities (scripts/pre-commit-check.sh)
2. VS Code Utilities (from setup-global-all.sh)

## Validation Steps for Each Change

To ensure safe migration at each step:

1. **Run existing tests** (if available)

   - In this project, we can use the Makefile targets: `make run` and `make run-wikipedia`
   - Check that outputs match what you got before the change

2. **Manual verification** of core functionality

   - Try with different inputs to ensure robust testing
   - Check that error handling still works properly

3. **Create a temporary branch** for each change

   - Use: `git checkout -b extract-llm-integration-step-X`
   - This makes it easy to isolate and revert if needed

4. **Merge only when validated**

   - Run a final full test before merging back to main
   - Document exactly what was tested and how

5. **Document any issues** encountered

   - Keep a log of problems and solutions
   - This helps identify patterns and improve future migrations

## Rollback Plan

For each step:

1. **Keep original files** until new structure is confirmed working

   - Never delete original modules until the extracted version is fully tested
   - Keep backups of modified files before making changes

2. **Maintain backward compatibility** with wrapper modules

   - Make sure the original API remains unchanged
   - Use adapter patterns where needed to maintain compatibility

3. **Use Git branching** to easily revert changes

   - Create a new branch for each extraction step: `git checkout -b extract-llm-integration-step-X`
   - Commit frequently with detailed commit messages
   - If something breaks: `git checkout main` to return to a working state

## Conclusion

This simplified migration plan focuses on extracting one component at a time, starting with the LLM Integration Module. By taking small, incremental steps with thorough validation at each stage, we minimize risk while gradually transforming the codebase into reusable, standalone modules. The LLM Integration Module will be extracted to a completely separate repository at `/home/z/repos/llm-integration`. The web scraping functionality will remain part of the core project and will not be extracted.

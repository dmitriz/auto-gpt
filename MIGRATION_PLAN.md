# Simplified Migration Plan: Extracting Reusable Components

**Components to Extract (In Order):**

1. **Web Scraping Module** (browser.py)
2. **LLM Integration Module** (ask_llm.py)
3. **Git Hooks Utilities** (scripts/pre-commit-check.sh)
4. **VS Code Utilities** (from setup-global-all.sh)

## CORE PRINCIPLES - READ FIRST

1. **ONE COMPONENT AT A TIME**: We will extract, test, and complete ONLY ONE component fully before starting on any other component. This is the most important rule.
   - Focus entirely on the web scraper first until it's 100% working
   - Only after the web scraper is complete will we consider the next component
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

## Identifying the Simplest Component to Extract First

After analyzing the codebase, the **Web Scraping Module (browser.py)** is the most self-contained and easiest component to extract first:

1. It has minimal dependencies (only requires requests and BeautifulSoup)
2. It has a clear, single responsibility (fetching and parsing web pages)
3. It's already well-encapsulated with a clean API (one main function)
4. It's generally useful in many projects beyond this specific application

We will NOT begin any other component extraction until this one is completely finished.

The other components we'll extract later (in order of complexity, but only one at a time):

1. LLM Integration Module (ask_llm.py)
2. Git Hooks Utilities (scripts/pre-commit-check.sh)
3. VS Code Utilities (from setup-global-all.sh)

## Step 1: Extract Web Scraper Module

1. **Create a single directory for the extracted module**
   - `mkdir -p web-scraper`
   - This is the only new directory needed to start
   - Confirm creation with `ls -la` to verify it exists

2. **Copy browser.py to web-scraper with minimal changes**
   - `cp browser.py web-scraper/web_scraper.py`
   - Rename the file to match the new module purpose
   - No functionality changes yet
   - Verify with `diff -u browser.py web-scraper/web_scraper.py` to ensure only file path comments changed

3. **Create minimal package structure**
   - Create `web-scraper/__init__.py` to expose the module
   - Add only this line to **init**.py: `from .web_scraper import fetch_visible_text`
   - Create `web-scraper/setup.py` with only essential metadata
   - No README or extra files at this stage
   - Test that import works with `python -c "import sys; sys.path.append('.'); from web-scraper import fetch_visible_text; print(fetch_visible_text)"`

4. **Test the extracted module independently**
   - Create a simple test script that imports and uses the new module
   - Verify it works exactly the same as the original
   - Sample test script:

     ```python
     # test_web_scraper.py
     import sys
     sys.path.append('.')  # Add current directory to path
     from web-scraper import fetch_visible_text

     # Test the function with a sample URL
     url = "https://example.com"
     text = fetch_visible_text(url)
     print(f"Fetched {len(text)} characters from {url}")
     print(text[:100] + "...")  # Print first 100 chars
     ```

   - Run with: `python test_web_scraper.py`

5. **Update original browser.py to use the new module**
   - Modify to import the functionality from the new location
   - Maintain exact same behavior and API
   - This ensures main application still works without changes
   - Example of updated browser.py:

     ```python
     # Wrapper module that maintains backward compatibility
     import sys
     sys.path.append('.')  # Add current directory to path
     from web-scraper import fetch_visible_text
     # No other changes needed - the original function is now re-exported
     ```

   - Test with: `python -c "import browser; print(browser.fetch_visible_text('https://example.com')[:50])"`

## Running Tests After Each Step

For each change above:

1. Run the original application to ensure it still works
   - Use `python main.py https://example.com "What is this page about?"`
   - Verify the output is as expected

2. Only move to the next step if the current one is successful
   - Document each successful step with date/time
   - Use Git commits with clear messages after each step 

3. If something breaks, immediately revert to the working state
   - Use `git reset --hard HEAD~1` if changes were committed
   - Or restore from backup copies if not using Git

## Next Component to Extract (Only After Web Scraper is Done)

Once the web scraper module is fully extracted and tested, we'll extract the LLM integration (ask_llm.py) using the same minimalist approach.

After completing the LLM integration module, we'll continue with the remaining components in this order:

1. **Git Hooks Utilities** (scripts/pre-commit-check.sh)
   - Focus on making the Git hooks reusable across projects
   - Apply the same step-by-step approach used for the web scraper

2. **VS Code Utilities** (from setup-global-all.sh)
   - Extract the VS Code configuration automation
   - Make it a standalone utility that can be used in any project

Remember: We only move to the next component after fully completing the current one.

## Validation Steps for Each Change

To ensure safe migration at each step:

1. **Run existing tests** (if available)
   - In this project, we can use the Makefile targets: `make run` and `make run-wikipedia`
   - Check that outputs match what you got before the change

2. **Manual verification** of core functionality
   - Try with at least two different URLs to ensure robust testing
   - Check that error handling still works (e.g., try an invalid URL)

3. **Create a temporary branch** for each change
   - Use: `git checkout -b extract-web-scraper-step-X`
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
   - Create a new branch for each extraction step: `git checkout -b extract-web-scraper-step-X`
   - Commit frequently with detailed commit messages
   - If something breaks: `git checkout main` to return to a working state

## Conclusion

This simplified migration plan focuses on extracting one component at a time, starting with the simplest one - the web scraper module. By taking small, incremental steps with thorough validation at each stage, we minimize risk while gradually transforming the codebase into reusable modules.

# Migration Plan: Extracting Reusable Components

This document outlines a systematic, step-by-step plan to extract generic functionality from the current project into separate, reusable modules. The plan emphasizes small, incremental changes to ensure functionality remains intact throughout the migration process.

## Current Project Structure Analysis

The current project consists of several components:

1. **Web Agent Core** (main.py, run_web_agent.sh)
   - Application-specific entry point and CLI handling

2. **Web Scraping Module** (browser.py)
   - Generic web page fetching and text extraction

3. **LLM Integration Module** (ask_llm.py)
   - Generic OpenAI API integration

4. **Development Utilities**
   - Git hooks (scripts/pre-commit-check.sh)
   - Global setup scripts (scripts/setup-global-hooks.sh, scripts/setup-global-all.sh)
   - Documentation (VS_CODE_SETTINGS_DOC.md, GLOBAL_FILES.md)
   - Project automation (Makefile)

## Migration Plan: Small, Incremental Steps

### Phase 1: Prepare the Repository Structure (Week 1)

1. **Create a repos subdirectory structure**
   - `mkdir -p libs/{web-scraper,llm-client,git-hooks,vs-code-utils}`
   - This establishes placeholders for the future independent modules
   - Small step: Just creating directories, no code changes

2. **Create minimal README files in each subdirectory**
   - Document the intended purpose of each module
   - Small step: Just documentation, no code changes

3. **Create minimal setup.py files in each subdirectory**
   - Define basic package metadata for future Python packages
   - Small step: Just scaffolding, no code movement

### Phase 2: Extract Web Scraper Module (Week 2)

1. **Copy browser.py to libs/web-scraper**
   - `cp browser.py libs/web-scraper/web_scraper.py`
   - Small step: Just copying, original functionality untouched

2. **Refactor the web-scraper module**
   - Rename functions to match new module name
   - Add proper package documentation
   - Create tests
   - Small step: Working on the copy, original remains functional

3. **Update the original browser.py**
   - Modify to import from the new module
   - Initially, re-export the same functionality
   - Small step: Maintaining backward compatibility

4. **Test the unchanged application**
   - Verify the original application still works
   - Small step: Validating the changes preserve functionality

### Phase 3: Extract LLM Client Module (Week 3)

1. **Copy ask_llm.py to libs/llm-client**
   - `cp ask_llm.py libs/llm-client/llm_client.py`
   - Small step: Just copying, original functionality untouched

2. **Refactor the llm-client module**
   - Generalize the interface for different models
   - Add proper package documentation
   - Create tests
   - Small step: Working on the copy, original remains functional

3. **Update the original ask_llm.py**
   - Modify to import from the new module
   - Initially, re-export the same functionality
   - Small step: Maintaining backward compatibility

4. **Test the unchanged application**
   - Verify the original application still works
   - Small step: Validating the changes preserve functionality

### Phase 4: Extract Git Hooks Utilities (Week 4)

1. **Copy Git hook scripts to libs/git-hooks**
   - `cp scripts/setup-global-hooks.sh libs/git-hooks/`
   - `cp scripts/pre-commit-check.sh libs/git-hooks/`
   - Small step: Just copying, original functionality untouched

2. **Refactor the Git hooks scripts**
   - Make them more configurable and reusable
   - Add proper documentation
   - Small step: Working on copies, originals remain functional

3. **Update the original scripts**
   - Modify to reference or import from the new module
   - Small step: Maintaining backward compatibility

4. **Test the unchanged functionality**
   - Verify the Git hooks still work as expected
   - Small step: Validating the changes preserve functionality

### Phase 5: Extract VS Code Utilities (Week 5)

1. **Copy VS Code setup scripts to libs/vs-code-utils**
   - Extract VS Code setup functionality from scripts/setup-global-all.sh
   - Small step: Extract and refactor one piece at a time

2. **Refactor the VS Code utilities**
   - Make them more configurable and reusable
   - Add proper documentation
   - Small step: Working on copies, originals remain functional

3. **Update the original scripts**
   - Modify to reference or import from the new module
   - Small step: Maintaining backward compatibility

4. **Test the unchanged functionality**
   - Verify the VS Code setup still works as expected
   - Small step: Validating the changes preserve functionality

### Phase 6: Package and Publish (Week 6-8)

For each extracted module:

1. **Complete package structure**
   - Add proper **init**.py files
   - Finalize setup.py with dependencies
   - Add license and contribution guides
   - Small step: One module at a time

2. **Create tests for each package**
   - Add unit tests for critical functionality
   - Add CI configuration
   - Small step: One module at a time

3. **Document usage**
   - Create detailed README with examples
   - Add docstrings and type hints
   - Small step: One module at a time

4. **Test independent modules**
   - Verify each module works independently
   - Small step: One module at a time

5. **Publish to PyPI or internal repository**
   - Register package name
   - Publish initial version
   - Small step: One module at a time, starting with the most stable

### Phase 7: Transition the Main Application (Week 9-10)

1. **Update dependencies**
   - Update requirements.txt to use the published packages
   - Small step: One dependency at a time

2. **Refactor main application**
   - Update imports to use the published packages
   - Remove any unnecessary code
   - Small step: One module at a time

3. **Expand functionality**
   - Add new features using the modular components
   - Small step: One feature at a time

## Validation Steps for Each Change

To ensure safe migration at each step:

1. **Run existing tests** (if available)
2. **Manual verification** of core functionality
3. **Create a temporary branch** for each change
4. **Merge only when validated**
5. **Document any issues** encountered

## Rollback Plan

For each step:

1. **Keep original files** until new structure is confirmed working
2. **Maintain backward compatibility** with wrapper modules
3. **Document specific rollback steps** for each phase
4. **Use Git branching** to easily revert changes

## Timeline and Progress Tracking

- Each phase estimated at 1-2 weeks
- Total migration time: 10-12 weeks
- Track progress in a simple spreadsheet or project board
- Weekly status updates to stakeholders

## Conclusion

This migration plan provides a systematic approach to extracting reusable components while ensuring the application remains functional throughout the process. By taking small, incremental steps with thorough validation at each stage, we can safely transition to a more modular and maintainable codebase.

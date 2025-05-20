
# .PHONY tells Make these targets don't create files with these names
# This prevents issues if files with the same names exist
.PHONY: setup run run-wikipedia run-news run-custom setup-secrets setup-global-hooks help

# Help target shows available commands
help:
	@echo "Available commands:"
	@echo "  make setup               - Set up the virtual environment and install dependencies"
	@echo "  make setup-secrets       - Install local Git hook to prevent committing secrets"
	@echo "  make setup-global-hooks  - Install global Git hooks for all repositories"
	@echo "  make run                 - Run with example.com and a basic question"
	@echo "  make run-wikipedia       - Run with Wikipedia AI article"
	@echo "  make run-news            - Run with Hacker News"
	@echo "  make run-custom          - Run with custom URL and question (requires URL= and QUESTION= parameters)"
	@echo "  make help                - Show this help message"

# Create virtual environment and install dependencies
setup:
	python -m venv venv
	. venv/bin/activate && pip install -r requirements.txt

# Run the web agent with a simple example
run:
	. venv/bin/activate && python main.py https://example.com "What is this page about?"

# Run the web agent on Wikipedia AI article
run-wikipedia:
	. venv/bin/activate && python main.py https://en.wikipedia.org/wiki/Artificial_intelligence "What are the main ethical concerns about AI described on this page?"

# Run the web agent on Hacker News
run-news:
	. venv/bin/activate && python main.py https://news.ycombinator.com "What are the top discussions happening right now?"

# Run the web agent with custom URL and question
run-custom:
	@if [ -z "$(URL)" ] || [ -z "$(QUESTION)" ]; then \
		echo "Error: URL and QUESTION parameters are required"; \
		echo "Usage: make run-custom URL=\"https://example.com\" QUESTION=\"What is this page about?\""; \
		exit 1; \
	fi
	. venv/bin/activate && python main.py "$(URL)" "$(QUESTION)"

# Set up local Git hooks in THIS repository only
setup-secrets:
	@echo "Setting up pre-commit hooks for secret detection..."
	# Create scripts directory if it doesn't exist
	@mkdir -p scripts
	# Copy example script if it exists, ignore errors
	@[ -f scripts/pre-commit-check.sh ] || cp scripts/pre-commit-check.sh.example scripts/pre-commit-check.sh 2>/dev/null || true
	# Create Git hooks directory
	@mkdir -p .git/hooks
	# Create a hook that calls the script with bash (no need to make executable)
	@echo '#!/bin/bash\nbash "$(git rev-parse --show-toplevel)/scripts/pre-commit-check.sh"' > .git/hooks/pre-commit
	@echo "Secret detection hooks installed. Run 'make setup-global-hooks' to apply to all repositories."

# Set up global Git hooks for ALL repositories on your machine
setup-global-hooks:
	@echo "Setting up global Git hooks for all repositories..."
	# Run the script using bash (no need to make it executable)
	@bash scripts/setup-global-hooks.sh
	@echo "Global hooks installed. Remember to run 'git init' in existing repositories to apply the template."

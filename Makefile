.PHONY: setup run run-wikipedia run-news run-custom help

help:
	@echo "Available commands:"
	@echo "  make setup           - Set up the virtual environment and install dependencies"
	@echo "  make run             - Run with example.com and a basic question"
	@echo "  make run-wikipedia   - Run with Wikipedia AI article"
	@echo "  make run-news        - Run with Hacker News"
	@echo "  make run-custom      - Run with custom URL and question (requires URL= and QUESTION= parameters)"
	@echo "  make help            - Show this help message"

setup:
	python -m venv venv
	. venv/bin/activate && pip install -r requirements.txt

run:
	. venv/bin/activate && python main.py https://example.com "What is this page about?"

run-wikipedia:
	. venv/bin/activate && python main.py https://en.wikipedia.org/wiki/Artificial_intelligence "What are the main ethical concerns about AI described on this page?"

run-news:
	. venv/bin/activate && python main.py https://news.ycombinator.com "What are the top discussions happening right now?"

run-custom:
	@if [ -z "$(URL)" ] || [ -z "$(QUESTION)" ]; then \
		echo "Error: URL and QUESTION parameters are required"; \
		echo "Usage: make run-custom URL=\"https://example.com\" QUESTION=\"What is this page about?\""; \
		exit 1; \
	fi
	. venv/bin/activate && python main.py "$(URL)" "$(QUESTION)"

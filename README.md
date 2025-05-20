# Web Agent

A simple Python project that mimics AutoGPT’s ability to browse websites and answer questions about them using OpenAI GPT.

## Features

- Fetches and parses a webpage using `requests` and `BeautifulSoup`.
- Extracts visible text from the page.
- Uses OpenAI GPT (via API) to answer user questions about the page content.
- CLI interface: provide a URL and a question.

## Usage

1. Install dependencies:

   ```bash
   pip install -r requirements.txt
   ```

2. Set your OpenAI API key in the `.env` file.
3. Run the CLI:

   ```bash
   python main.py "https://example.com" "What is the main topic?"
   ```

## Files

- `main.py`: CLI entry point
- `browser.py`: Handles webpage scraping and text extraction
- `ask_llm.py`: Handles OpenAI GPT API queries
- `.env`: Place your OpenAI API key here
- `requirements.txt`: Project dependencies

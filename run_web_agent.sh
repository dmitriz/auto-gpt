#!/bin/bash
set -euo pipefail

# Activate virtual environment if exists
if [ -d "venv" ]; then
    source venv/bin/activate
fi

# Validate that both URL and question arguments are provided
if [ $# -lt 2 ]; then
    echo "Error: Missing required arguments"
    echo "Usage: $0 <url> <question>"
    echo "  <url>: The webpage URL to analyze"
    echo "  <question>: The question to ask about the webpage"
    exit 1
fi

# Run the web agent with provided arguments
python main.py "$1" "$2"

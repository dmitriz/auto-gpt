#!/bin/bash
set -euo pipefail

# Activate virtual environment if exists
if [ -d "venv" ]; then
    source venv/bin/activate
fi

# Run the web agent with provided arguments
python main.py "$1" "$2"

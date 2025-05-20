# Main entry point for the AutoGPT web browsing and question answering application
# This script ties together the web browser and language model components

import argparse
from browser import fetch_visible_text
from ask_llm import ask_gpt

def main():
    # Set up command-line argument parsing
    parser = argparse.ArgumentParser(description="Ask questions about a webpage using GPT.")
    # URL argument - the webpage to analyze
    parser.add_argument("url", help="URL of the webpage to analyze")
    # Question argument - what to ask about the webpage
    parser.add_argument("question", help="Question to ask about the webpage")
    # Parse the arguments
    args = parser.parse_args()

    # Step 1: Fetch and parse the webpage content
    print(f"Fetching and parsing {args.url} ...")
    text = fetch_visible_text(args.url)
    
    # Step 2: Send the question and content to the language model
    print("Sending question to GPT...")
    # Limit context to 4000 characters to manage token usage
    answer = ask_gpt(args.question, text[:4000])
    
    # Step 3: Display the answer
    print("\nAnswer:")
    print(answer)

# Standard Python idiom to only run the main function when executed as a script
if __name__ == "__main__":
    main()

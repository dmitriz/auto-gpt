import argparse
from browser import fetch_visible_text
from ask_llm import ask_gpt

def main():
    parser = argparse.ArgumentParser(description="Ask questions about a webpage using GPT.")
    parser.add_argument("url", help="URL of the webpage to analyze")
    parser.add_argument("question", help="Question to ask about the webpage")
    args = parser.parse_args()

    print(f"Fetching and parsing {args.url} ...")
    text = fetch_visible_text(args.url)
    print("Sending question to GPT...")
    answer = ask_gpt(args.question, text[:4000])  # Limit context for token safety
    print("\nAnswer:")
    print(answer)

if __name__ == "__main__":
    main()

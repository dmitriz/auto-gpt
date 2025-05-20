# Web page scraping and text extraction module
# Uses requests to fetch web pages and BeautifulSoup to parse HTML

import requests
from bs4 import BeautifulSoup

def fetch_visible_text(url):
    """
    Fetches a webpage and extracts its visible text content.
    
    Args:
        url (str): The URL of the webpage to fetch and parse
        
    Returns:
        str: The visible text content of the webpage
    """
    # Send HTTP GET request to the URL
    response = requests.get(url)
    
    # Raise an exception for 4XX/5XX status codes
    response.raise_for_status()
    
    # Parse the HTML content with BeautifulSoup
    soup = BeautifulSoup(response.text, 'html.parser')
    
    # Remove script, style, and noscript elements that don't contain visible text
    for element in soup(['script', 'style', 'noscript']):
        element.decompose()
    
    # Extract visible text by joining all text fragments
    # stripped_strings automatically handles whitespace cleanup
    visible_text = ' '.join(soup.stripped_strings)
    
    return visible_text

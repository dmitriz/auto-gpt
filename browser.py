from bs4 import BeautifulSoup
from security import safe_requests

def fetch_visible_text(url):
    response = safe_requests.get(url)
    response.raise_for_status()
    soup = BeautifulSoup(response.text, 'html.parser')
    # Remove script and style elements
    for element in soup(['script', 'style', 'noscript']):
        element.decompose()
    # Extract visible text
    visible_text = ' '.join(soup.stripped_strings)
    return visible_text

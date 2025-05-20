# Original functionality - preserving API compatibility
# This file implements the same function directly to avoid import issues

import os
from openai import OpenAI
from dotenv import load_dotenv

# Load environment variables from .env file (including the OpenAI API key)
load_dotenv()

# Initialize the OpenAI client with the API key from environment variables
client = OpenAI(api_key=os.getenv("OPENAI_API_KEY"))

def ask_gpt(question, context):
    """
    Sends a question and context to OpenAI's GPT model and returns the answer.
    
    Args:
        question (str): The question to ask about the context
        context (str): The text context for the model to reference (e.g., webpage content)
        
    Returns:
        str: The model's response to the question
    """
    # Create a prompt that includes both the context and the question
    prompt = f"Context: {context}\n\nQuestion: {question}\nAnswer:"
    
    # Call the OpenAI API to generate a completion
    response = client.chat.completions.create(
        model="gpt-3.5-turbo",  # Use GPT-3.5 Turbo model
        messages=[{"role": "user", "content": prompt}],
        max_tokens=256,  # Limit response length
        temperature=0.2,  # Lower temperature for more focused answers
    )
    
    # Extract and return the generated text, removing extra whitespace
    return response.choices[0].message.content.strip()

import os
from openai import OpenAI
from dotenv import load_dotenv

load_dotenv()
client = OpenAI(api_key=os.getenv("OPENAI_API_KEY"))

def ask_gpt(question, context):
    prompt = f"Context: {context}\n\nQuestion: {question}\nAnswer:"
    response = client.chat.completions.create(
        model="gpt-3.5-turbo",
        messages=[{"role": "user", "content": prompt}],
        max_tokens=256,
        temperature=0.2,
    )
    return response.choices[0].message.content.strip()

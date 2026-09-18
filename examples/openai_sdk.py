"""Chat Completions through TopxAI with the OpenAI SDK.

Any text model on the catalogue works here (Claude, GPT, Grok, GLM, Kimi);
the key goes where the provider's key would go.
"""
from openai import OpenAI

client = OpenAI(base_url="https://ai.topxea.com/v1", api_key="sk-...")
reply = client.chat.completions.create(
    model="claude-sonnet-5",
    messages=[{"role": "user", "content": "Say hello in one sentence."}],
)
print(reply.choices[0].message.content)

"""Messages through TopxAI with the Anthropic SDK.

The SDK appends /v1/messages itself, so the base URL is the origin.
"""
from anthropic import Anthropic

client = Anthropic(base_url="https://ai.topxea.com", api_key="sk-...")
reply = client.messages.create(
    model="claude-sonnet-5",
    max_tokens=256,
    messages=[{"role": "user", "content": "Say hello in one sentence."}],
)
print(reply.content[0].text)

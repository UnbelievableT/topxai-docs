# Connect your SDK

> The base URL, every endpoint with its auth header, working examples for the OpenAI and Anthropic SDKs, and what each error status means.

This page is also published at https://ai.topxea.com/docs/connect-your-sdk (English and Chinese).

Use the SDK you already have; the key goes where the provider's key would go. The **API endpoint** panel at the top of the **API keys** page lists every path with a copy button. **Copy base URL** copies the origin `https://ai.topxea.com` without `/v1`: right for the Anthropic SDK; OpenAI-style SDKs need `/v1` added, or copy the endpoint row.

## Endpoints

- `POST /v1/chat/completions`: OpenAI Chat Completions, `Authorization: Bearer <key>`, every text model except Jev (GLM and Kimi only here)
- `POST /v1/responses`: OpenAI Responses, Bearer, GPT models and `grok-4.6`
- `POST /v1/messages`: Anthropic Messages, `x-api-key: <key>`, Claude models; a raw request also needs `anthropic-version: 2023-06-01` and `max_tokens`
- `POST /v1/images/generations` and `POST /v1/images/edits`: OpenAI Images, Bearer, GPT Image 2.5 models
- `POST /v1/videos/generations`, `GET /v1/videos/{request_id}` for status, `GET /v1/videos/{request_id}/content` for the video: Bearer, Grok Imagine Video
- `POST /v1/systemone` (or `/v1/system_one`): TypeSafe System One, Bearer, Jev
- `GET /v1/models`: the models your key can call

## OpenAI Python SDK

Pass the base URL with `/v1`; the SDK appends `/chat/completions`.

```python
from openai import OpenAI

client = OpenAI(base_url="https://ai.topxea.com/v1", api_key="sk-...")
reply = client.chat.completions.create(
    model="claude-sonnet-5",
    messages=[{"role": "user", "content": "Say hello in one sentence."}],
)
print(reply.choices[0].message.content)
```

## Anthropic SDK

The Anthropic SDK appends `/v1/messages` itself, so its base URL is the origin; the key travels as `x-api-key`.

```python
from anthropic import Anthropic

client = Anthropic(base_url="https://ai.topxea.com", api_key="sk-...")
reply = client.messages.create(
    model="claude-sonnet-5",
    max_tokens=256,
    messages=[{"role": "user", "content": "Say hello in one sentence."}],
)
print(reply.content[0].text)
```

## Coding tools

- Claude Code: Claude models work with Claude Code and any Anthropic-compatible client. **CC Switch** in a key's row menu opens a `ccswitch://` import with the endpoint (`https://ai.topxea.com` for Claude, `https://ai.topxea.com/v1` for Codex), the key and the **Primary Model** you pick, plus optional **Haiku Model**, **Sonnet Model** and **Opus Model** for Claude.
- Codex CLI: GPT and Grok models, at `https://ai.topxea.com/v1`.
- Trae and similar editors take the same two values. Trae's add-model test sends a small image, and `GLM-5.3-Abliterated` is text only; the relay swaps it for `[Attachment omitted: this model accepts text only.]`, so the test passes but the model gets no attachments.
- Jev: the TypeSafe SDKs read `TYPESAFE_BASE_URL=https://ai.topxea.com` and `TYPESAFE_API_KEY`. The one-command setup under a Jev key installs the TypeSafe agent skill, writes `~/.config/topxai/typesafe.env`, a marked block in `~/.zshrc` or `~/.bashrc` and the env in `~/.claude/settings.json`, then sends one ping; without `--key` it prompts for the key without echo.

## If the first call fails

- 401: the key is missing or invalid.
- 402: the balance is empty.
- 403: the model id is not sold here, is not on this key's route, or is excluded by the key's model limits; the message says which.
- 404: the provider answered that the model does not exist.
- 429: rate limited; `Retry-After` gives the wait, at most 60 seconds.
- 503: no line can serve the model right now, or the provider is overloaded; retry.

Every error message ends with a request id you can send to support@topxea.com.

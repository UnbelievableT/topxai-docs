# opencode with TopxAI: a custom provider in opencode.json

> Declare TopxAI in opencode.json with @ai-sdk/openai-compatible, the base URL and the model ids, then pick them with /models.

This page is also published at https://ai.topxea.com/docs/use-topxai-with-opencode (English and Chinese).

opencode takes custom providers in `opencode.json` (in the project or in `~/.config/opencode/`). One block with the `@ai-sdk/openai-compatible` package covers every TopxAI text model; a second with `@ai-sdk/anthropic` keeps Claude on the Messages API.

## opencode.json

```json
{
  "$schema": "https://opencode.ai/config.json",
  "provider": {
    "topxai": {
      "npm": "@ai-sdk/openai-compatible",
      "name": "TopxAI",
      "options": {
        "baseURL": "https://ai.topxea.com/v1",
        "apiKey": "{env:TOPXAI_API_KEY}"
      },
      "models": {
        "claude-sonnet-5": {
          "name": "Claude Sonnet 5",
          "limit": { "context": 200000, "output": 64000 }
        },
        "gpt-5.6-sol": {
          "name": "GPT-5.6 Sol",
          "limit": { "context": 400000, "output": 128000 }
        },
        "grok-4.6": {
          "name": "Grok 4.6",
          "limit": { "context": 256000, "output": 32000 }
        },
        "kimi-k3": {
          "name": "Kimi K3",
          "limit": { "context": 1000000, "output": 32000 }
        }
      }
    },
    "topxai-claude": {
      "npm": "@ai-sdk/anthropic",
      "name": "TopxAI (Anthropic API)",
      "options": {
        "baseURL": "https://ai.topxea.com/v1",
        "apiKey": "{env:TOPXAI_API_KEY}"
      },
      "models": {
        "claude-sonnet-5": { "name": "Claude Sonnet 5" },
        "claude-opus-5": { "name": "Claude Opus 5" }
      }
    }
  }
}
```

Then:

```bash
export TOPXAI_API_KEY=sk-...
opencode
```

and choose a model with `/models`; the provider names appear as headings.

## Notes

- `{env:TOPXAI_API_KEY}` reads the key from the environment; `{file:~/.secrets/topxai}` reads it from a file. Either keeps the key out of the config.
- The `@ai-sdk/anthropic` package expects a base URL ending in `/v1` and appends `/messages`; the `@ai-sdk/openai-compatible` package appends `/chat/completions`.
- `limit` is what opencode uses for its context meter; the values above are the models' windows, not a TopxAI limit.
- Model ids must match the catalogue exactly; `GET https://ai.topxea.com/v1/models` with your key lists them.

## If it fails

- 401: the key is wrong or was pasted with a space. 402: the balance is empty. 403: the model id is not sold here or is not on this key's route. See [Common error responses](common-error-responses.md).
- The model works in curl but not in the tool: [that page](the-model-works-in-curl-but-not-in-my-tool.md) lists the usual causes, one per tool.

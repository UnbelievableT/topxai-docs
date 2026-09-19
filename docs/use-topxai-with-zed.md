# Zed with TopxAI: OpenAI- and Anthropic-compatible providers

> Add TopxAI to Zed as an openai_compatible provider for GPT, Grok, Kimi and GLM, and as an anthropic_compatible provider for Claude, in settings.json.

This page is also published at https://ai.topxea.com/docs/use-topxai-with-zed (English and Chinese).

Zed's agent takes custom providers under `language_models` in `settings.json`. TopxAI is one `openai_compatible` provider for the text models on Chat Completions and one `anthropic_compatible` provider for Claude.

## settings.json

```json
{
  "language_models": {
    "openai_compatible": {
      "TopxAI": {
        "api_url": "https://ai.topxea.com/v1",
        "available_models": [
          {
            "name": "gpt-5.6-sol",
            "display_name": "GPT-5.6 Sol",
            "max_tokens": 400000
          },
          {
            "name": "grok-4.6",
            "display_name": "Grok 4.6",
            "max_tokens": 256000
          },
          {
            "name": "kimi-k3",
            "display_name": "Kimi K3",
            "max_tokens": 1000000
          }
        ]
      }
    },
    "anthropic_compatible": {
      "TopxAI Claude": {
        "api_url": "https://ai.topxea.com",
        "available_models": [
          {
            "name": "claude-sonnet-5",
            "display_name": "Claude Sonnet 5",
            "max_tokens": 200000,
            "max_output_tokens": 64000,
            "capabilities": {
              "tools": true,
              "images": true,
              "prompt_caching": true
            }
          },
          {
            "name": "claude-opus-5",
            "display_name": "Claude Opus 5",
            "max_tokens": 200000,
            "max_output_tokens": 64000,
            "capabilities": {
              "tools": true,
              "images": true,
              "prompt_caching": true
            }
          }
        ]
      }
    }
  }
}
```

The key does not go in `settings.json`. Enter it in the provider's row in the agent settings, or export the variable Zed derives from the provider name: `TOPXAI_API_KEY` and `TOPXAI_CLAUDE_API_KEY` for the two providers above.

## Notes

- `max_tokens` is the context window Zed assumes for its "context left" meter; use the model's real window.
- Enable `prompt_caching` on the Claude provider: TopxAI forwards `cache_control` breakpoints and bills cache reads at one tenth of the input price.
- Zed's Edit Prediction has its own provider setting and is not covered by these entries.

## If it fails

- 401: the key is wrong or was pasted with a space. 402: the balance is empty. 403: the model id is not sold here or is not on this key's route. See [Common error responses](common-error-responses.md).
- The model works in curl but not in the tool: [that page](the-model-works-in-curl-but-not-in-my-tool.md) lists the usual causes, one per tool.

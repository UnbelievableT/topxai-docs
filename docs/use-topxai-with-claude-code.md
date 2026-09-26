# Claude Code with TopxAI: ANTHROPIC_BASE_URL and the key

> Point Claude Code at https://ai.topxea.com with two environment variables and pick claude-sonnet-5, claude-opus-5-5 or claude-fable-5-1 as its model.

This page is also published at https://ai.topxea.com/docs/use-topxai-with-claude-code (English and Chinese).

Claude Code talks to the Anthropic Messages API, which TopxAI serves at `https://ai.topxea.com/v1/messages`. Two environment variables move it over; nothing else changes.

## Setup

```bash
export ANTHROPIC_BASE_URL=https://ai.topxea.com
export ANTHROPIC_AUTH_TOKEN=sk-...        # a TopxAI key on the Claude or Auto route
export ANTHROPIC_MODEL=claude-sonnet-5    # optional: the default model
claude
```

`ANTHROPIC_AUTH_TOKEN` sends the key as a Bearer token; `ANTHROPIC_API_KEY` sends it as `x-api-key`. TopxAI accepts both, so use whichever your shell already has. The base URL is the origin without `/v1`: Claude Code adds `/v1/messages` itself.

To make it permanent, put the same values under `env` in `~/.claude/settings.json`:

```json
{
  "env": {
    "ANTHROPIC_BASE_URL": "https://ai.topxea.com",
    "ANTHROPIC_AUTH_TOKEN": "sk-...",
    "ANTHROPIC_MODEL": "claude-sonnet-5"
  }
}
```

Claude Code also reads `ANTHROPIC_DEFAULT_OPUS_MODEL`, `ANTHROPIC_DEFAULT_SONNET_MODEL` and `ANTHROPIC_DEFAULT_HAIKU_MODEL` for the models it switches between; set them to catalogue ids (`claude-opus-5-5`, `claude-sonnet-5`) so a switch never asks for a model TopxAI does not sell.

## Which key

A key on the **Auto route** sends each request to the lowest-priced route that serves the model, the shared pool first. A key on the **Claude official line** pins the provider's own line at 90% of list. Both are created on the [API keys](https://ai.topxea.com/keys) page; the [routes page](shared-pool-official-line-and-auto-route.md) explains the difference.

## CC Switch

If you keep several endpoints, the **CC Switch** entry in a key's row menu on the keys page opens a `ccswitch://` import with the endpoint, the key and the model already filled in.

## What Claude Code sends

Claude Code sends its own system prompt and tool definitions with every request; those tokens are billed as input like any other. Prompt caching applies at the cache-read and cache-write prices on the [model's page](https://ai.topxea.com/pricing/claude-sonnet-5), and the [usage log](reading-your-usage-log.md) shows the cached and uncached counts separately.

## If it fails

- 401: the key is wrong or was pasted with a space. 402: the balance is empty. 403: the model id is not sold here or is not on this key's route. See [Common error responses](common-error-responses.md).
- The model works in curl but not in the tool: [that page](the-model-works-in-curl-but-not-in-my-tool.md) lists the usual causes, one per tool.

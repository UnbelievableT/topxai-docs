# LobeChat with TopxAI: the OpenAI proxy address

> Set OpenAI’s API proxy address to https://ai.topxea.com/v1 in LobeChat, or OPENAI_PROXY_URL for a deployment, and fetch the model list.

This page is also published at https://ai.topxea.com/docs/use-topxai-with-lobechat (English and Chinese).

LobeChat's OpenAI provider accepts a proxy address, which is all TopxAI needs. The Anthropic provider takes one too, for Claude on the Messages API.

## In the app

1. **Settings → AI Service Provider → OpenAI**.
2. **API Key**: a TopxAI key. **API Proxy Address**: `https://ai.topxea.com/v1`.
3. Click **Get model list**; the models your key can call appear. Enable the ones you want.
4. **Check** sends one request and shows the reply.

For Claude on the Anthropic provider: API key the same, proxy address `https://ai.topxea.com` (no `/v1`), models `claude-sonnet-5` and `claude-opus-5`.

## Self-hosted, with variables

```bash
OPENAI_API_KEY=sk-...
OPENAI_PROXY_URL=https://ai.topxea.com/v1
OPENAI_MODEL_LIST=-all,+claude-sonnet-5,+gpt-5.6-sol,+grok-4.6,+kimi-k3
ANTHROPIC_API_KEY=sk-...
ANTHROPIC_PROXY_URL=https://ai.topxea.com
```

`OPENAI_MODEL_LIST` starts with `-all` to drop LobeChat's built-in OpenAI names, then adds the catalogue ids; without it the picker shows models TopxAI does not sell and every one of them returns 403.

## Images

LobeChat's image generation with the OpenAI provider works with `gpt-image-2.5-sunburst` and `gpt-image-2.5-flare` through the same proxy address.

## If it fails

- 401: the key is wrong or was pasted with a space. 402: the balance is empty. 403: the model id is not sold here or is not on this key's route. See [Common error responses](common-error-responses.md).
- The model works in curl but not in the tool: [that page](the-model-works-in-curl-but-not-in-my-tool.md) lists the usual causes, one per tool.

# ChatBox with TopxAI: a custom provider

> In ChatBox, add a custom provider in OpenAI API compatible mode with host https://ai.topxea.com and path /v1/chat/completions, then add the model ids.

This page is also published at https://ai.topxea.com/docs/use-topxai-with-chatbox (English and Chinese).

ChatBox reaches any OpenAI-compatible endpoint through a custom provider.

## Setup

1. **Settings → Model Provider → Add Custom Provider**.
2. **Name**: TopxAI. **API Mode**: OpenAI API Compatible.
3. **API Host**: `https://ai.topxea.com`. **API Path**: `/v1/chat/completions`.
4. **API Key**: a TopxAI key on the Auto route.
5. **Model**: add `claude-sonnet-5`, `gpt-5.6-sol`, `grok-4.6`, `kimi-k3` or `GLM-5.3-Abliterated`; or fetch the list, which reads `/v1/models`.
6. Save and pick the provider in a chat.

## Notes

- Every text model except Jev is on `/v1/chat/completions`, including Claude, so one provider is enough. Jev answers typed questions through `/v1/systemone` and is not a chat model.
- If ChatBox offers a separate **Anthropic** provider with a custom host, `https://ai.topxea.com` and the same key work there for `claude-sonnet-5` and `claude-opus-5`.
- Image generation in ChatBox with this provider uses `gpt-image-2.5-sunburst` or `gpt-image-2.5-flare`, billed per image.

## If it fails

- 401: the key is wrong or was pasted with a space. 402: the balance is empty. 403: the model id is not sold here or is not on this key's route. See [Common error responses](common-error-responses.md).
- The model works in curl but not in the tool: [that page](the-model-works-in-curl-but-not-in-my-tool.md) lists the usual causes, one per tool.

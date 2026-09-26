# Dify with TopxAI: the OpenAI-API-compatible provider

> Add each TopxAI model to Dify through the OpenAI-API-compatible provider with endpoint https://ai.topxea.com/v1, your key and the model id.

This page is also published at https://ai.topxea.com/docs/use-topxai-with-dify (English and Chinese).

Dify's **OpenAI-API-compatible** model provider takes an endpoint URL, a key and a model name per model. Each TopxAI model you want in Dify is one entry.

## Add a model

1. **Settings → Model Provider → OpenAI-API-compatible → Add model**.
2. **Model Type**: LLM. **Model Name**: `claude-sonnet-5` (exactly as in the catalogue).
3. **API Key**: a TopxAI key on the [Auto route](shared-pool-official-line-and-auto-route.md). **API endpoint URL**: `https://ai.topxea.com/v1`.
4. **Completion mode**: Chat. **Model context size**: the model's window (1050000 for [GPT-6 Sol](https://ai.topxea.com/pricing/gpt-6-sol), 1000000 for [Claude Sonnet 5](https://ai.topxea.com/pricing/claude-sonnet-5) and [Kimi K3](https://ai.topxea.com/pricing/kimi-k3), 500000 for [Grok 4.7](https://ai.topxea.com/pricing/grok-4.7)). **Upper bound for max tokens**: the model's output limit.
5. **Function calling**: Tool Call, for agent nodes. **Vision**: on for the Claude and GPT models, off for `GLM-5.3-Abliterated` (text only).
6. Save; the model appears in the picker of every app.

Repeat for `gpt-6-sol`, `grok-4.7`, `kimi-k3` and `GLM-5.3-Abliterated`.

## Images

Add `gpt-image-2.5-sunburst` with **Model Type**: Text to Image if your Dify version lists that type for the compatible provider; otherwise call `/v1/images/generations` from an HTTP Request node with the same key.

## Workflows and cost

Dify sends the prompt template, the knowledge-base chunks and the conversation with each LLM node. All of it is input tokens at the model's price on the route the key uses; the [usage log](reading-your-usage-log.md) lists each request with its route and charge.

## If it fails

- 401: the key is wrong or was pasted with a space. 402: the balance is empty. 403: the model id is not sold here or is not on this key's route. See [Common error responses](common-error-responses.md).
- The model works in curl but not in the tool: [that page](the-model-works-in-curl-but-not-in-my-tool.md) lists the usual causes, one per tool.

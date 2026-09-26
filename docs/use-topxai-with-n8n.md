# n8n with TopxAI: an OpenAI credential with a base URL

> Create an OpenAI credential in n8n with base URL https://ai.topxea.com/v1 and a TopxAI key, then use any catalogue model in the Chat Model and AI Agent nodes.

This page is also published at https://ai.topxea.com/docs/use-topxai-with-n8n (English and Chinese).

n8n's OpenAI credential has a **Base URL** field, which is all TopxAI needs. The Anthropic credential has one too.

## Credential

1. **Credentials → Add credential → OpenAI**.
2. **API Key**: a TopxAI key on the [Auto route](shared-pool-official-line-and-auto-route.md). **Base URL**: `https://ai.topxea.com/v1`.
3. Save. n8n tests the credential by listing `/v1/models`.

For Claude through the Messages API: **Anthropic** credential, key the same, base URL `https://ai.topxea.com`.

## Nodes

- **OpenAI Chat Model** (for AI Agent, Basic LLM Chain and the other [LangChain](use-topxai-with-langchain.md) nodes): choose the credential, then pick the model from the list n8n fetched or type the id (`claude-sonnet-5`, `gpt-6-sol`, `grok-4.7`, `kimi-k3`, `GLM-5.3-Abliterated`).
- **OpenAI** node, **Message a model** operation: the same credential and ids; **Generate an image** with `gpt-image-2.5-sunburst` or `gpt-image-2.5-flare`.
- **Anthropic Chat Model**: the Anthropic credential and `claude-sonnet-5` or `claude-opus-5-5`.

## Notes

- Operations that call endpoints TopxAI does not serve (audio transcription, assistants, files) fail with 404; keep those on the provider's own credential.
- The AI Agent node sends tool definitions and memory with each turn; all of it is input at the model's price. The [usage log](reading-your-usage-log.md) at TopxAI shows every call the workflow made.

## If it fails

- 401: the key is wrong or was pasted with a space. 402: the balance is empty. 403: the model id is not sold here or is not on this key's route. See [Common error responses](common-error-responses.md).
- The model works in curl but not in the tool: [that page](the-model-works-in-curl-but-not-in-my-tool.md) lists the usual causes, one per tool.

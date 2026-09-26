# Cline and Roo Code with TopxAI: the OpenAI-compatible provider

> Set the provider to OpenAI Compatible with base URL https://ai.topxea.com/v1, a TopxAI key and a model id; or the Anthropic provider with a custom base URL.

This page is also published at https://ai.topxea.com/docs/use-topxai-with-cline-and-roo-code (English and Chinese).

Cline, Roo Code and Kilo Code share the same provider settings. Two of their providers reach TopxAI: **OpenAI Compatible** for every text model, and **Anthropic** with a custom base URL for the Claude models.

## OpenAI Compatible

In the extension's settings:

- **API Provider**: OpenAI Compatible
- **Base URL**: `https://ai.topxea.com/v1`
- **API Key**: a TopxAI key ([Auto route](shared-pool-official-line-and-auto-route.md) covers every model)
- **Model ID**: `claude-sonnet-5`, `gpt-6-sol`, `grok-4.7`, `kimi-k3` or `GLM-5.3-Abliterated`

Leave the "Azure" and "legacy format" switches off. The model id must match the catalogue exactly; the picker cannot list TopxAI's models by itself, so type it.

## Anthropic with a custom base URL

For Claude models the Anthropic provider keeps [prompt caching](how-requests-are-billed.md) and the Messages-specific features:

- **API Provider**: Anthropic
- **Use custom base URL**: on, `https://ai.topxea.com`
- **API Key**: the TopxAI key
- **Model**: `claude-sonnet-5` or `claude-opus-5-5`

The base URL here is the origin without `/v1`; the extension appends `/v1/messages`.

## Agent mode and cost

These tools send the whole conversation, tool definitions and file contents with each turn. Prompt caching on the Claude line is where the savings are: cache reads bill at one tenth of the input price. The [usage log](reading-your-usage-log.md) separates cached from uncached tokens per request.

## If it fails

- 401: the key is wrong or was pasted with a space. 402: the balance is empty. 403: the model id is not sold here or is not on this key's route. See [Common error responses](common-error-responses.md).
- The model works in curl but not in the tool: [that page](the-model-works-in-curl-but-not-in-my-tool.md) lists the usual causes, one per tool.

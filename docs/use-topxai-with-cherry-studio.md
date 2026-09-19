# Cherry Studio with TopxAI: add a provider

> Add TopxAI in Cherry Studio as an OpenAI-type provider with address https://ai.topxea.com and your key; Cherry appends /v1. Claude also works as Anthropic type.

This page is also published at https://ai.topxea.com/docs/use-topxai-with-cherry-studio (English and Chinese).

Cherry Studio adds custom providers under **Settings → Model Provider**. One OpenAI-type provider reaches every TopxAI text model; an Anthropic-type provider keeps Claude on the Messages API.

## OpenAI type

1. **Settings → Model Provider → Add**. Name `TopxAI`, type **OpenAI**.
2. **API Key**: a TopxAI key. **API Address**: `https://ai.topxea.com`.
3. **Manage** or **Add** models: type the ids `claude-sonnet-5`, `gpt-5.6-sol`, `grok-4.6`, `kimi-k3`, `GLM-5.3-Abliterated`, or fetch the list.
4. **Check** with one of them.

Cherry Studio adds `/v1/chat/completions` to the address on its own. Enter the origin only; an address ending in `/v1` produces `/v1/v1/...` and a 404. If you ever need the exact path, end the address with `#` and Cherry uses it as typed.

## Anthropic type

Add a second provider of type **Anthropic** with the same key and address `https://ai.topxea.com`, models `claude-sonnet-5` and `claude-opus-5`. This route sends `x-api-key` and supports prompt caching.

## Images

An OpenAI-type provider also serves **Paint** with `gpt-image-2.5-sunburst` and `gpt-image-2.5-flare`, billed per image by size.

## If it fails

- 401: the key is wrong or was pasted with a space. 402: the balance is empty. 403: the model id is not sold here or is not on this key's route. See [Common error responses](common-error-responses.md).
- The model works in curl but not in the tool: [that page](the-model-works-in-curl-but-not-in-my-tool.md) lists the usual causes, one per tool.

# Continue with TopxAI: models in config.yaml

> Add TopxAI models to ~/.continue/config.yaml with provider openai or anthropic and apiBase, then use them for chat, edit and agent mode in VS Code or JetBrains.

This page is also published at https://ai.topxea.com/docs/use-topxai-with-continue (English and Chinese).

Continue reads its models from `~/.continue/config.yaml`. A model entry names the provider, the model id, the base URL and the key; TopxAI fits the `openai` provider for every text model and the `anthropic` provider for Claude.

## config.yaml

```yaml
name: TopxAI
version: 0.0.1
schema: v1

models:
  - name: Claude Sonnet 5 (TopxAI)
    provider: anthropic
    model: claude-sonnet-5
    apiBase: https://ai.topxea.com
    apiKey: sk-...
    roles: [chat, edit, apply]
  - name: GPT-5.6 Sol (TopxAI)
    provider: openai
    model: gpt-5.6-sol
    apiBase: https://ai.topxea.com/v1
    apiKey: sk-...
    roles: [chat, edit, apply]
  - name: Kimi K3 (TopxAI)
    provider: openai
    model: kimi-k3
    apiBase: https://ai.topxea.com/v1
    apiKey: sk-...
```

Two details:

- The `anthropic` provider takes the origin without `/v1` and adds `/v1/messages`; the `openai` provider takes the origin with `/v1` and adds `/chat/completions`.
- `apiKey` may also be `${{ secrets.TOPXAI_API_KEY }}` with the key stored in Continue's secrets, so the file can be committed.

## Roles

`chat`, `edit` and `apply` all work with the chat models above. Autocomplete (`roles: [autocomplete]`) needs a fill-in-the-middle model; none of the catalogue models is one, so leave autocomplete on whatever you use today.

## Agent mode

Agent mode needs tool calling. Add `capabilities: [tool_use]` to a model entry if Continue does not detect it for a catalogue id it has not seen before.

## If it fails

- 401: the key is wrong or was pasted with a space. 402: the balance is empty. 403: the model id is not sold here or is not on this key's route. See [Common error responses](common-error-responses.md).
- The model works in curl but not in the tool: [that page](the-model-works-in-curl-but-not-in-my-tool.md) lists the usual causes, one per tool.

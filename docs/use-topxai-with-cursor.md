# Cursor with TopxAI: override the OpenAI base URL

> In Cursor, paste a TopxAI key as the OpenAI key, turn on the base URL override with https://ai.topxea.com/v1 and add the model ids you want to chat with.

This page is also published at https://ai.topxea.com/docs/use-topxai-with-cursor (English and Chinese).

Cursor lets you bring your own OpenAI-compatible endpoint for chat. The override applies to the models you add by name; Cursor's own features that run on its servers keep using Cursor's models.

## Setup

1. Open **Cursor Settings → Models**.
2. Under **OpenAI API Key**, paste a TopxAI key (Auto route covers every model).
3. Turn on **Override OpenAI Base URL** and enter `https://ai.topxea.com/v1`.
4. Click **Verify**. Cursor sends one small request; the usage log at TopxAI shows it.
5. Under the model list, **Add model** and type the catalogue id exactly: `claude-sonnet-5`, `gpt-5.6-sol`, `grok-4.6`, `kimi-k3`, `GLM-5.3-Abliterated`. Enable the ones you want in the picker.

Cursor sends every added model to `/v1/chat/completions`, which serves every text model except Jev, so Claude models work here through the OpenAI format without a separate Anthropic key.

## What to expect

- Chat and inline edits with an added model go through TopxAI and are billed at the model's price on the route the key uses.
- Turning the override on disables Cursor's built-in OpenAI models in the picker; turn it off to get them back.
- Cursor sends its own system prompt and, in agent mode, tool definitions; those are input tokens like any other.

## If it fails

- 401: the key is wrong or was pasted with a space. 402: the balance is empty. 403: the model id is not sold here or is not on this key's route. See [Common error responses](common-error-responses.md).
- The model works in curl but not in the tool: [that page](the-model-works-in-curl-but-not-in-my-tool.md) lists the usual causes, one per tool.

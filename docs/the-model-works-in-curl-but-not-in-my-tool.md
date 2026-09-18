# The model works in curl but not in my tool

> Seven places where a tool differs from the working curl: base URL, auth header, model id, key route and limits, IP whitelist, GLM and Jev endpoints, timeouts.

This page is also published at https://ai.topxea.com/docs/the-model-works-in-curl-but-not-in-my-tool (English and Chinese).

The **First API request** curl in the **Get started** panel on the **Dashboard** sends the exact path, header and model id. A tool failing with the same key usually differs in one of seven ways.

## 1. The base URL

The **API endpoint** panel on **API keys** gives `https://ai.topxea.com` and leaves the path to the client. OpenAI-style tools append `/chat/completions`, so their base URL must end with `/v1`:

```text
https://ai.topxea.com/v1
```

Without `/v1` the tool posts to `https://ai.topxea.com/chat/completions`, the console's web page: 200 with HTML, and the tool reports a JSON parse error. `/v1` twice gives 404 `Invalid URL (POST /v1/v1/chat/completions)`. Anthropic-style tools and TypeSafe's SDKs append `/v1/messages` and `/v1/systemone` themselves, so they take `https://ai.topxea.com` without `/v1`.

## 2. The auth header

OpenAI-style endpoints read `Authorization: Bearer sk-...`. `x-api-key` is accepted only on `/v1/messages` and `/v1/models`, so an Anthropic tool pointed at `/v1/chat/completions` gets 401 `Invalid token`.

## 3. The model id

Ids are case-sensitive: `GLM-5.3-Abliterated`, `claude-sonnet-5`. A tool that lowercases the name gets 403 `Model is not offered by this service`. List what the key can call:

```bash
curl https://ai.topxea.com/v1/models -H "Authorization: Bearer sk-..."
```

## 4. The key's route and limits

A key belongs to one **Group**; one on `claude-shared` cannot call `gpt-6-astra` and gets 403 `Model is not available on this API key route`. Tools that switch vendors need a key on **Auto route**, which routes each model to its lowest-priced line. A model outside the key's **Model limits** answers 403 `This token has no access to model ...`.

## 5. The key's IP whitelist

A key with an **IP Whitelist (supports CIDR)** works from your laptop's curl and answers 403 from a server not on the list.

## 6. Chat-only models and Jev

`GLM-5.3-Abliterated` and `kimi-k3` are served on `/v1/chat/completions` only; GPT and Grok models also take `/v1/responses`, Claude models `/v1/messages`. GLM accepts text only: an editor's image probe is replaced by `[Attachment omitted: this model accepts text only.]`, so the probe passes but the model never sees pictures. `jev-1.13.0` is TypeSafe's System One model on `POST /v1/systemone`. It returns typed judgments, not chat: set `TYPESAFE_BASE_URL=https://ai.topxea.com` in TypeSafe's SDK, not in a chat client.

## 7. Timeouts, streaming and video

The gateway waits up to 30 minutes for the provider's first byte and as long again between stream chunks; a shorter timeout is your tool's. For long generations use `stream: true`; a mid-stream error is one `data: {"error":...}` event (`event: error` first on `/v1/messages`) and the stream ends without `[DONE]`. Video is asynchronous: `POST /v1/videos/generations` returns the job document with a `request_id` at once. Poll `GET /v1/videos/{request_id}`, then fetch `GET /v1/videos/{request_id}/content`; a tool expecting the clip in the POST gets JSON, not a file.

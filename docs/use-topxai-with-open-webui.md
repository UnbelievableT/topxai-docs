# Open WebUI with TopxAI: one OpenAI connection, every model

> Add https://ai.topxea.com/v1 as an OpenAI API connection in Open WebUI; the model list fills from /v1/models and every text model is ready to chat.

This page is also published at https://ai.topxea.com/docs/use-topxai-with-open-webui (English and Chinese).

Open WebUI treats any OpenAI-compatible endpoint as an "OpenAI API connection" and lists its models from `/v1/models`. One connection brings in every TopxAI text model.

## In the admin panel

1. **Admin Panel → Settings → Connections**.
2. Under **OpenAI API**, add a connection: URL `https://ai.topxea.com/v1`, key `sk-...` (a TopxAI key on the [Auto route](shared-pool-official-line-and-auto-route.md)).
3. Save. The model picker now lists the models your key can call.

## With environment variables

For a Docker deployment, the same two values as variables:

```bash
docker run -d -p 3000:8080 \
  -e OPENAI_API_BASE_URL=https://ai.topxea.com/v1 \
  -e OPENAI_API_KEY=sk-... \
  -v open-webui:/app/backend/data \
  --name open-webui ghcr.io/open-webui/open-webui:main
```

## What is listed

`/v1/models` returns the models the key's route can serve: on the Auto route, every text model and the image models. [Jev](jev-typesafe-system-one.md) is listed only for keys on the TypeSafe route and is not usable from a chat window, since it answers typed questions through `/v1/systemone`, not chat.

## Images

Open WebUI's image generation setting also takes an OpenAI-compatible endpoint. Use the same URL and key and set the model to `gpt-image-2.5-sunburst` or `gpt-image-2.5-flare`; images bill per picture by size, as on the [image generation page](image-generation.md).

## If it fails

- 401: the key is wrong or was pasted with a space. 402: the balance is empty. 403: the model id is not sold here or is not on this key's route. See [Common error responses](common-error-responses.md).
- The model works in curl but not in the tool: [that page](the-model-works-in-curl-but-not-in-my-tool.md) lists the usual causes, one per tool.

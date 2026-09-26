# API reference: every endpoint, with an OpenAPI specification

> Every endpoint TopxAI serves, what each accepts and returns, the two ways to send the key, and the OpenAPI 3.1 file at /openapi.json for API tools.

This page is also published at https://ai.topxea.com/docs/api-reference (English and Chinese).

TopxAI forwards request bodies unchanged and returns responses unchanged, so the reference for a body is the provider's own documentation. This page lists what TopxAI itself defines: the endpoints, which models each serves, how the key travels, and the fields the relay validates or prices. The same information is machine-readable at [`/openapi.json`](https://ai.topxea.com/openapi.json) (OpenAPI 3.1), which Postman, Insomnia, Bruno, Swagger UI, Redoc and code generators load directly.

## Base URLs

- `https://ai.topxea.com/v1` for OpenAI-style SDKs and tools; they append `/chat/completions`, `/responses`, `/images/…`, `/models`.
- `https://ai.topxea.com` for the Anthropic SDK; it appends `/v1/messages`.

## Authentication

A TopxAI key (`sk-…`) from the [API keys](https://ai.topxea.com/keys) page, sent one of two ways:

- `Authorization: Bearer <key>` on every endpoint.
- `x-api-key: <key>` on `/v1/messages`, the way the Anthropic SDK sends it.

The key's route decides which models it can call; an Auto-route key can call every model.

## Endpoints

| Endpoint                              | Format                    | Models                                                       | Notes                                                                                             |
| ------------------------------------- | ------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------------------------------------------- |
| `POST /v1/chat/completions`           | OpenAI Chat Completions   | every text model except [Jev](jev-typesafe-system-one.md) | [GLM-5.3-Abliterated](https://ai.topxea.com/pricing/glm-5.3-abliterated) and kimi-k3 only here; `stream: true` for SSE |
| `POST /v1/responses`                  | OpenAI Responses          | gpt-6-astra, gpt-6-sol, grok-4.7                           | what [Codex CLI](use-topxai-with-codex-cli.md) uses                                            |
| `POST /v1/messages`                   | Anthropic Messages        | the Claude models                                            | needs `anthropic-version`; no `max_tokens` means the model's output limit; `cache_control` forwarded |
| `POST /v1/images/generations`         | OpenAI Images             | gpt-image-2.5-sunburst, gpt-image-2.5-flare                  | priced per image by the `size` tier; `n` 1 to 128                                                 |
| `POST /v1/images/edits`               | OpenAI Images (multipart) | the same two                                                 | priced like generation                                                                            |
| `POST /v1/videos/generations`         | video job                 | grok-imagine-video-1.5                                       | `duration` 1 to 15 s, `resolution` 480p/720p/1080p; billed on acceptance                          |
| `GET /v1/videos/{request_id}`         | job status                |                                                              | keep polling on pending, queued, processing, running, in_progress                                 |
| `GET /v1/videos/{request_id}/content` | the file                  |                                                              | after `done`                                                                                      |
| `POST /v1/systemone`                  | TypeSafe System One       | jev-1.13.0, jev-latest, jev-preview                          | `model`, `state`, `questions`; also `/v1/system_one`                                              |
| `GET /v1/models`                      | OpenAI model list         |                                                              | filtered to the key's route                                                                       |
| `GET /api/pricing`                    | JSON price table          |                                                              | no key needed; the data behind [/pricing](https://ai.topxea.com/pricing)                                               |

## Status codes

`400` the body failed validation, the message names the field. `401` key missing or invalid. `402` balance empty. `403` model not sold here, not on this key's route, or excluded by the key's model limits. `404` the provider says the model does not exist, or an unknown video job. `422` TypeSafe's validation detail (System One only). `429` rate limited, `Retry-After` in seconds. `503` no line can serve the model now; retry. Every error message ends with a request id; quote it to support@topxea.com.

## Using the specification

```bash
curl -O https://ai.topxea.com/openapi.json
```

Import the file into Postman or Insomnia to get a request per endpoint with the examples filled in, or feed it to `openapi-generator` for a typed client. The file's `servers` entry is the production origin; nothing in it is specific to a key or an account.

## Not served

Batch, fine-tuning, files, assistants, vector stores, realtime, audio and embeddings are not relayed; requests to those paths return 404. Keep them on the provider's own key. The [comparison with the providers' APIs](topxai-vs-the-providers-own-apis.md) lists what else stays direct.

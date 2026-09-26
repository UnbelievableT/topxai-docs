# TopxAI vs the providers' own APIs: price, retention and what stays direct

> What changes when Claude, GPT, Grok or Kimi go through TopxAI: the price per token, one key and one balance, zero retention, and what stays with the provider.

This page is also published at https://ai.topxea.com/docs/topxai-vs-the-providers-own-apis (English and Chinese).

Calling a provider directly is the baseline every relay is measured against. This page lists what changes when the same request goes through TopxAI, including what you give up.

## What changes

|                         | Direct                                                                                       | Through TopxAI                                                                                                          |
| ----------------------- | -------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------- |
| Price per token         | The provider's list price                                                                    | Shared pool 50% of list, official line 90%; Kimi 80%; Jev 107%; GLM-5.3-Abliterated above list, on a private deployment |
| Accounts and keys       | One account, one key, one invoice per provider                                               | One account, one Auto-route key for every model, one prepaid USD balance                                                |
| Payment                 | The provider's billing: card, monthly invoice, prepaid, in the provider's currency and terms | Prepaid USD by card on topxea.com, crypto invoice or gift card; $0.50 credit at sign-up                                 |
| Request path            | Client → provider                                                                            | Client → TopxAI → provider; the extra hop adds the round trip between TopxAI and the provider                           |
| Prompts and completions | The provider's retention policy                                                              | Relayed in memory, never stored; the usage log keeps token counts, model, route and identifiers                         |
| Rate limits             | The provider's per-account limits                                                            | Per-key request limits and the shared pool's capacity; the official line calls the provider under TopxAI's own account  |
| Usage records           | The provider's dashboard                                                                     | One usage-log row per request with the route and the charge, filterable by key, model and route                         |
| Model versions          | Every model and snapshot the provider offers                                                 | The 13 catalogue models; new releases arrive when they are added                                                        |

## What stays with the provider

TopxAI serves Chat Completions, Responses, Messages, [image generation](image-generation.md) and edits, [video generation](video-generation.md), `/v1/systemone` and `/v1/models`. Anything else stays on the provider's own key:

- Batch APIs and their discounts
- Fine-tuning, files, assistants, vector stores
- Realtime and audio endpoints
- Embeddings (no embedding model in the catalogue)
- Provider-side features that need account-level settings, such as organisation-wide data controls

## The same either way

The request body is forwarded unchanged and the response is returned unchanged: tool calling, structured output, streaming, vision inputs, [prompt caching](how-requests-are-billed.md) and reasoning settings behave as they do at the provider. TopxAI adds no system prompt and no headers of its own; the relay's test suite asserts that a Claude Messages request leaves byte for byte as it arrived.

## Deciding

Go direct when you need an endpoint TopxAI does not serve, the provider's own billing terms, or a model outside the catalogue. Go through TopxAI when the models you use are in the catalogue, the price per token matters, and one key with one balance is simpler than several accounts. The two are not exclusive: most tools take a base URL per model, so the catalogue models can run through TopxAI while the rest stay direct.

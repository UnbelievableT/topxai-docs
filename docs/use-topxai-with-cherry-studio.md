# Cherry Studio with TopxAI: first chat and endpoint setup

> Connect a route-scoped TopxAI key to Cherry Studio, choose the right endpoint, and diagnose the first request without guessing URL suffixes.

Canonical page: https://ai.topxea.com/docs/use-topxai-with-cherry-studio


Start with one model and a key whose route includes it. For example, create a Claude-route key for `claude-sonnet-5`. A single OpenAI-compatible connection does not make every model available to every key.

## Choose the endpoint your version exposes

Cherry Studio has changed its provider settings between versions. Older releases show a single **API Address** field and add a version suffix. The current v2 source stores a separate base URL for each endpoint. Follow the field in your installed version and inspect the resulting request path if setup fails.

| Endpoint | Base URL for a v2 endpoint configuration | Example model |
| --- | --- | --- |
| OpenAI Chat Completions | `https://ai.topxea.com/v1` | `claude-sonnet-5` on a Claude key; `gpt-5.6-sol` on a GPT key |
| OpenAI Responses | `https://ai.topxea.com/v1` | `gpt-5.6-sol`, `grok-4.6` on their matching routes |
| Anthropic Messages | `https://ai.topxea.com` | `claude-sonnet-5`, `claude-opus-5` |

The resulting POST paths must be `/v1/chat/completions`, `/v1/responses`, or `/v1/messages`, respectively. Select **Chat Completions** for Kimi and GLM; they do not use TopxAI's Responses endpoint. Jev uses a separate protocol and is outside this setup.

In older versions that explicitly append `/v1`, start with `https://ai.topxea.com` in the single API Address field. Do not apply that rule blindly to v2 endpoint fields. An address containing `/v1` is not inherently wrong: the final request path is what matters. Avoid the advanced `#` endpoint override for this first setup.

## Complete the first chat

1. Open **Settings → Model Provider**, add a custom provider and name it `TopxAI`. Choose an OpenAI-compatible Chat Completions connection, or Anthropic for a native Claude connection. Labels vary by version.
2. Set the matching address above and enter your TopxAI key locally. Keep screenshots and exported settings free of credentials.
3. Fetch the model list or manually add a model permitted by that key. Fetching `/v1/models` checks discovery, not generation.
4. Select that provider and model in a new chat. Send `Say hello in one sentence.` Set a small output limit if the client exposes one. A connectivity check that generates text also consumes balance.
5. Confirm a response, then open TopxAI **Usage** to verify the model, route and charge. Add other models only after this works.

New TopxAI accounts currently receive $0.50 welcome credit. Check Wallet before adding credit; the key's own quota must also cover the request reservation.

## Diagnose the boundary that failed

| Symptom | Check next |
| --- | --- |
| 401 | Correct key, no surrounding whitespace, correct authentication type |
| 402 with positive balance | Key quota and requested output limit; the initial reservation can exceed the available balance |
| 403 | The key's route and model limits; choosing a model in Cherry does not expand them |
| 404 or duplicated `/v1/v1` | Final request path and the version-specific address field |
| Models load but chat fails | Selected endpoint, model permissions and response format |
| Curl works but the client fails | Extra tools, attachments, reasoning options and automatic retries; start with plain text |
| Timeout after submission | Check Usage and the request ID before repeating; do not assume the first request never ran |

Image generation is a separate configuration and route. A working text-model key does not establish that image requests are enabled.

## Verification scope and sources

This guide was checked against Cherry Studio's [endpoint resolver](https://github.com/CherryHQ/cherry-studio/blob/6ae3b04f7aefb76f8828780b7f147960212f69ad/src/main/ai/provider/endpoint.ts), [base URL selection](https://github.com/CherryHQ/cherry-studio/blob/6ae3b04f7aefb76f8828780b7f147960212f69ad/src/main/ai/utils/provider.ts) and [provider registry](https://github.com/CherryHQ/cherry-studio/blob/6ae3b04f7aefb76f8828780b7f147960212f69ad/docs/references/provider-model/provider-registry.md) on September 19, 2026. It is a source-reviewed custom-provider recipe, not a claim that TopxAI is an official built-in preset or that every desktop version was tested end to end.

See [Connect your SDK](connect-your-sdk.md) for a minimal comparison request and [Common error responses](common-error-responses.md) for error details.

# Shared pool, official line and auto route

> Same models, different routing and price: what each API-key route means and how Auto route picks one for you.

This page is also published at https://ai.topxea.com/docs/shared-pool-official-line-and-auto-route (English and Chinese).

Every [API key](create-an-api-key-and-choose-a-route.md) belongs to one route, the **Group** field when you create a key (**Edit** changes it later). The route decides how traffic reaches the provider and which fixed USD price applies; the models are the same.

## The routes

Claude, OpenAI and Grok each have two routes:

- Shared pool (`claude-shared`, `openai-shared`, `grok-shared`): 50% of list price.
- Official line (`claude-official`, `openai-official`, `grok-official`): 90% of list price. If the official line has no dedicated channel for a model, the shared pool serves it at the official price and the log records `fallback_group`.

Claude routes sell `claude-opus-5-5`, `claude-sonnet-5` and `claude-fable-5-1`; OpenAI routes sell `gpt-6-astra` and `gpt-6-sol`; Grok routes sell `grok-4.7`, plus `grok-imagine-video-1.5` on the official line only, billed per second.

Three lines have one route and no shared pool:

- Kimi: `kimi-official`, `kimi-k3` at 80% of list price.
- [Jev](jev-typesafe-system-one.md) (TypeSafe's System One model): `typesafe-official`, 107% of TypeSafe's list price, via `POST /v1/systemone`. Model `jev-1.13.0` (aliases `jev-latest`, `jev-preview` bill the same): $0.04494 per million input tokens, output $0.
- GLM: `z-official`, a private deployment of a fine-tuned GLM 5.3, text only, priced above the base model's list price.

Image models (`gpt-image-2.5-sunburst`, `gpt-image-2.5-flare`) sit on the `image` route, priced per image.

Prices differ per lane (input, output, cache read, cache write), and OpenAI and Grok add a long-context tier from 272,001 and 200,000 input tokens. Expand a route's model-count button in the Group list (**4 models** for Claude) for its **USD per 1M tokens** table.

Two refusals happen before anything is forwarded or charged, both HTTP 403 `permission_denied`: a model outside the catalogue gets "Model is not offered by this service"; a model your route does not sell gets "Model is not available on this API key route".

## Auto route

Pick **Auto route** and one key covers the catalogue. Per request the relay lists the routes that sell the model (shared pool, official line, then single-route lines) and takes the cheapest one that can serve it now, by input price then output; image and video compare their cheapest size or resolution. Ties keep shared first. Only Claude, OpenAI and Grok text models have a real choice.

A route with no configured price is skipped; if none is left, the request gets the same 403 as above. If no priced route has an enabled channel, the first priced candidate is tried and fails with HTTP 503 `upstream_unavailable`, "The model provider is temporarily unavailable. Please retry." Nothing is charged either way.

Today every Claude, OpenAI and Grok text model resolves to its shared pool. The [usage log](reading-your-usage-log.md) shows the concrete route next to the key name; `auto_route: true` appears only in the API's log record, never `auto` as a route.

For a dedicated official-price line, write to support@topxea.com.

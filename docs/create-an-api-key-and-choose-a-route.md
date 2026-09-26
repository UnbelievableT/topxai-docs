# Create an API key and choose a route

> The key drawer step by step, what each route means, and the three 403 refusals a key can hit.

This page is also published at https://ai.topxea.com/docs/create-an-api-key-and-choose-a-route (English and Chinese).

Open **API keys** in the sidebar and click **Create API key**.

## The form

1. **Name**: any label; the placeholder suggests `production-backend`.
2. **Group**: the route the key is billed on. Nothing is preselected; saving without one fails with **Choose a group**. An **N models** button on each row expands its price table (**USD per 1M tokens**, **USD per image** or **USD per second**), with a **Long context** row where that tier exists.
3. **Quota**: **Unlimited quota** on, or off with a **Quota (USD)** after which the key stops.
4. **Expiry**: an **Expiration time**, or a preset: **Never**, **1 Hour**, **1 Day**, **1 Month**.
5. **Quantity** (creating only): up to 50 keys; the first keeps the name you typed, the rest get a random suffix.
6. **Advanced settings**, collapsed by default: **Model limits** and **IP Whitelist (supports CIDR)**, both empty.

Click **Save changes**. The key starts with `sk-`.

## The routes

**Auto route** is listed first and covers the whole catalogue with one key. Each request goes to the lowest-priced line that can serve its model right now, normally the [shared pool](shared-pool-official-line-and-auto-route.md); when the pool cannot, it goes to the official line at its higher price, so the billed route can differ per request. The [usage log](reading-your-usage-log.md) shows that route under **Group**.

- Claude, OpenAI and Grok: a **Shared pool** (`claude-shared`, `openai-shared`, `grok-shared`) at 50% of list and an **Official line** (`claude-official`, `openai-official`, `grok-official`) at 90%. A text model is sold only on its own vendor's two routes. Grok's official line is also the only route for `grok-imagine-video-1.5`, per second.
- OpenAI **Image generation** (`image`): the only route for `gpt-image-2.5-sunburst` and `gpt-image-2.5-flare`, per image by size.
- GLM **Private deployment** (`z-official`): `GLM-5.3-Abliterated`, a fine-tuned GLM 5.3 on a private deployment, text only, above list.
- Kimi **Official line** (`kimi-official`): `kimi-k3` at 80% of list.
- TypeSafe **Official line** (`typesafe-official`, marked **Official key · 107% of list price**): `jev-1.13.0`. Its **Full API key** popover adds **One-command setup for Jev**.

Official-line requests fall back to the shared pool when no dedicated line is configured; for a dedicated official-price line, write to support@topxea.com.

## Three refusals

Three checks run before a provider is reached; each fails with HTTP 403:

- `Model is not offered by this service`: the model id is not in the catalogue.
- `Model is not available on this API key route`: the model is not on this key's route, such as a GPT model on a Claude key.
- `This token has no access to model <name>`: the key's **Model limits** exclude it. Pick them under **Select models (empty allows all)**; `jev-latest` and `jev-preview` count as `jev-1.13.0` here.

**IP Whitelist** takes one IP or CIDR block per line; addresses can be spoofed, so pair it with a gateway such as nginx or a CDN.

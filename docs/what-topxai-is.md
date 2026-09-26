# What TopxAI is

> One base URL, fourteen models on seven lines, prepaid USD credit, and nothing you send is stored.

This page is also published at https://ai.topxea.com/docs/what-topxai-is (English and Chinese).

TopxAI is the model API service run by TopXEA, the team behind topxea.com. Point an OpenAI- or Anthropic-compatible client at one base URL, pay from a prepaid USD balance, and the relay forwards each request to the model you named.

## One endpoint

The base URL is `https://ai.topxea.com/v1`. It serves OpenAI-style Chat Completions and Responses, Anthropic-style Messages, [image generation](image-generation.md) and edits, [video generation](video-generation.md), and `/v1/systemone` for [Jev](jev-typesafe-system-one.md). Keep your SDK; change the base URL and the key.

## Fourteen models on seven lines

- Claude: `claude-fable-5-1`, `claude-sonnet-5`, `claude-opus-5-5`
- OpenAI: `gpt-6-astra`, `gpt-image-2.5-sunburst`, `gpt-image-2.5-flare`
- Grok: `grok-4.7`, `grok-imagine-video-1.5`
- GLM: `GLM-5.3-Abliterated`
- Kimi: `kimi-k3`
- DeepSeek: `deepseek-flash`, `deepseek-v4-pro`
- Jev: `jev-1.13.0` (`jev-latest` and `jev-preview` are its aliases, billed as it)

Claude, OpenAI, Grok, Kimi, DeepSeek and Jev are the providers' own models. [GLM-5.3-Abliterated](https://ai.topxea.com/pricing/glm-5.3-abliterated) is a fine-tuned GLM 5.3 served from a private deployment, not the vendor's API: text only, priced above list.

## Routes and prices

Every price is a fixed USD figure per model and route, listed under **Models & pricing** at https://ai.topxea.com/#models. The [shared pool](shared-pool-official-line-and-auto-route.md) is 50% of the provider's list price, the official line 90%, Kimi's single official line 80%. DeepSeek's single official line is 80% of the DeepSeek list price in both of the provider's tiers: peak hours (01:00-04:00 and 06:00-10:00 UTC, Monday to Friday, except Chinese public holidays) cost twice the off-peak hours, and the tier is decided when a request is accepted. Jev is 107% of TypeSafe's list price: $0.04494 per million input tokens, output free. GLM runs on its private deployment above list.

A key is pinned to one route, such as `claude-shared`, or set to **Auto route**, which picks the lowest-priced line that serves each request's model.

Text bills per million tokens with separate input, output and cache lanes; images per picture by size (1K or 2K); video per second by resolution (480p, 720p or 1080p). Once the input reaches 272,001 tokens on `gpt-6-astra` or `gpt-6-sol`, or 200,000 tokens on `grok-4.7`, the whole request bills at long-context lanes: double the input price, higher output. Each request writes a usage-log row with model, route and charge.

## Prepaid USD

Credit is added on the **Wallet** page under **Add credit**, by **Card / local payment** (checkout runs on topxea.com) or **Crypto · USDT / USDC**, between $10 and $10,000 per payment; an unpaid order expires after 60 minutes. **Redeem a code** takes a **Redemption code**; **Gift cards** sells one to keep or give away. Only your own requests spend the balance, and every deduction is listed.

## Zero retention

Prompts, completions and uploaded files pass through TopxAI in memory and are never written to disk; bodies, headers and upstream error bodies are not stored. What is kept is metadata: token counts, model name, route, status, latency, timestamps, the [API key](create-an-api-key-and-choose-a-route.md) identifier, request ids and the charge. The provider serving the request handles the content under its own terms and retention policy, which TopxAI does not control.

## Support

The help button at the bottom right of the site, or support@topxea.com.

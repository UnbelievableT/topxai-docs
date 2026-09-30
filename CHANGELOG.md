# Changelog

Every dated change to TopxAI; also at https://ai.topxea.com/changelog with an RSS feed at https://ai.topxea.com/changelog/feed.xml.

## 2026-09-30 · GPT-6.1 Sol replaces GPT-6 Sol

The OpenAI shared and official routes move to `gpt-6.1-sol`. Update the model ID in your client: `gpt-6-sol` is retired, including its reasoning suffixes, with no forwarding alias. For keys restricted to specific models, update the allowed-model list too. Unrestricted keys and route keys without a model restriction keep working with the same key.

Default USD prices per million tokens, based on [OpenAI's model page](https://developers.openai.com/api/docs/models/gpt-6.1-sol), checked September 30, 2026:

| Category    | Shared (50%) | Official (90%) | OpenAI Standard |
| ----------- | ------------ | -------------- | --------------- |
| Input       | $1           | $1.80          | $2              |
| Output      | $5           | $9             | $10             |
| Cache read  | $0.05        | $0.09          | $0.10           |
| Cache write | $1.25        | $2.25          | $2.50           |

Cache reads cost half as much as on GPT-6 Sol; the other standard rates are unchanged. Above 272,000 input tokens, including cache tokens, the whole request uses the long-context tier: input and cache rates double, output rates multiply by 1.5. Existing administrator route-price overrides are preserved; accepted requests and historical charges retain their captured prices.

The context window remains 1,050,000 tokens, with up to 128,000 output tokens. Reasoning levels are `low`, `medium` (default), `high`, `xhigh` and `max`. Reasoning cannot be disabled; legacy `none` and `minimal` are normalized to `low`. Chat Completions and Anthropic-compatible requests use Responses upstream, preserving the client's response format and tools.

The [Codex installer](https://ai.topxea.com/downloads) uses the new model by default. See the [upgrade guide](https://ai.topxea.com/blog/gpt-6-1-sol) and [current prices](https://ai.topxea.com/pricing/gpt-6.1-sol).

## 2026-09-27 · GLM-5.3-Abliterated publishes its reasoning modes and 1M-token context

[GLM-5.3-Abliterated](glm-5-3-abliterated.md) runs on a deployment with a 1,000,000-token context and three reasoning modes. `/api/pricing` now publishes both: `context_window` 1000000, `max_output` 131072, and the reasoning efforts `low`, `high` and `max`, with `max` as the default. TopxAI Desktop reads the feed, so it now offers the effort picker for this model and plans for the full window. Until now its requests always ran at max and it treated the model as a 128K-token window.

Fixed: switching reasoning the way Z.ai's own API does, with `"thinking": {"type": "disabled"}` or `{"type": "enabled"}`, failed with a 400, because this deployment rejects the object. The relay now turns `disabled` into `reasoning_effort: "none"`, which runs as low with the reasoning text left out, and drops `enabled`. The boolean form `"thinking": false` is accepted as well; on every model it used to fail with a JSON error, and other lines now receive it as the object form.

Prices do not change. The model page explains where the reasoning text appears and how its tokens are billed.

## 2026-09-24 · Claude Fable 5 is retired; use Fable 5.1

`claude-fable-5` has left the catalogue. New requests for it are refused with HTTP 403 and the error code `model_not_offered`, and it no longer appears in `/v1/models` or the price table. Switch to `claude-fable-5-1`; it is not selected automatically.

Fable 5.1 costs the same per input and output token on both Claude routes ($5 / $25 shared, $9 / $45 official, USD per million tokens), and its cache reads are cheaper: $0.125 shared and $0.225 official, against $0.50 and $0.90 for Fable 5. Cache writes are unchanged.

Past requests to Fable 5 keep their usage-log rows and the prices they were charged. The catalogue now holds 14 models on 7 lines.

## 2026-09-24 · Old model IDs claude-opus-5, gpt-5.6-sol and grok-4.6 are retired

`claude-opus-5`, `gpt-5.6-sol` and `grok-4.6` stopped working on September 24. Until now each of them forwarded to its upgraded model. Requests for them are now refused with HTTP 403 and the error code `model_not_offered`, and they no longer appear in `/v1/models` or the price table.

Switch to the new IDs: `claude-opus-5-5`, `gpt-6-sol` and `grok-4.7`. Their prices are in the upgrade notes for [Opus 5.5](https://ai.topxea.com/changelog/claude-opus-5-5), [GPT-6 Sol](https://ai.topxea.com/changelog/gpt-6-sol) and [Grok 4.7](https://ai.topxea.com/changelog/grok-4-7); this change does not touch them.

An API key whose model limits name only an old ID can no longer reach the new model. Edit the key's model limits and select the new ID.

Past requests made with the old IDs keep their usage-log rows and the prices they were charged.

## 2026-09-23 · Claude Opus 5.5 replaces Opus 5 with lower token prices

Select `claude-opus-5-5` on the shared or official Claude route. Existing calls to `claude-opus-5`, including reasoning-effort suffixes, use Opus 5.5 at the new prices. Existing API keys restricted to Opus 5 can use the new model.

Prices in USD per million tokens, based on [Anthropic's published standard prices](https://platform.claude.com/docs/en/about-claude/pricing), verified September 23, 2026:

| Category | Shared (50%) | Official (90%) | Anthropic list |
| --- | --- | --- | --- |
| Input | $2 | $3.60 | $4 |
| Output | $10 | $18 | $20 |
| Cache read | $0.10 | $0.18 | $0.20 |
| Cache write, 5 minutes | $2.50 | $4.50 | $5 |
| Cache write, 1 hour | $4 | $7.20 | $8 |

Opus 5.5 supports a 1M-token context and up to 128K output tokens. Adaptive thinking is always enabled; the default effort is medium. Requests that disable thinking are translated to low effort. Other models and their prices are unchanged. Requests already accepted and historical usage retain their captured prices.

Manual thinking budgets are converted to effort levels. Opus 5.5 does not support forced tool selection (`any`/`tool`, or OpenAI `required`/named functions); these requests return an error without a charge. Use automatic tool selection for supported tool conversations. Provider-native computer-use clients must adopt Anthropic's new toolset format; ordinary custom tools are unchanged.

## 2026-09-23 · GPT-6 Sol is available at half the OpenAI Standard price

Use `gpt-6-sol` on the shared or official OpenAI route. Calls to `gpt-5.6-sol`, including reasoning suffixes, now use GPT-6 Sol at the new prices. Keys restricted to the previous model also allow GPT-6 Sol.

USD per million tokens, based on [OpenAI's Standard prices](https://developers.openai.com/api/docs/models/gpt-6-sol), checked September 23, 2026:

| Category | Shared (50%) | Official (90%) | OpenAI Standard |
| --- | --- | --- | --- |
| Input | $1 | $1.80 | $2 |
| Output | $5 | $9 | $10 |
| Cache read | $0.10 | $0.18 | $0.20 |
| Cache write | $1.25 | $2.25 | $2.50 |

These rates apply up to 272K input tokens. Above that, the whole request bills at the long-context rates, as on OpenAI: input and cache rates double and output rises by half (input, output, cache read and cache write are $2, $7.50, $0.20 and $2.50 on shared, $3.60, $13.50, $0.36 and $4.50 on official). An earlier version of this note said the prices stayed fixed at every context length; that was wrong, see [Long-context prices for GPT-6 Sol and Grok 4.7](https://ai.topxea.com/changelog#long-context-prices-for-gpt-6-sol-and-grok-4-7). Cache writes and reads are separate token categories, not additional fees on top of uncached input. Other models retain their current prices, and accepted requests and historical usage retain their captured prices.

GPT-6 Sol supports text and image input, a 1.05M-token context window, up to 922K input tokens and 128K output tokens. Reasoning levels are `none`, `low`, `medium` (default), `high`, `xhigh` and `max`; legacy `minimal` maps to `low`.

Use the Responses API for reasoning and tools. TopxAI also accepts Chat Completions and Anthropic-compatible clients: reasoning-enabled Chat requests use the existing Responses conversion, preserving the client response format and streaming. Chat requests with `reasoning_effort: none` can use native Chat tool calling. Sampling parameters unsupported during reasoning are removed before forwarding.

The current upstreams support implicit prompt caching. Explicit `prompt_cache_breakpoint` requests are currently rejected by both suppliers; leave cache selection implicit. The cache-write rate applies only to write tokens actually reported by the upstream. Cache misses are not treated as cache writes.

## 2026-09-23 · Grok 4.7 is available at half the xAI Standard price

Use `grok-4.7` on either Grok route. Calls to `grok-4.6`, including explicit reasoning modifiers, now select Grok 4.7. Existing keys restricted to Grok 4.6 continue to work with the upgraded model.

USD per million tokens, compared with [xAI Standard prices](https://docs.x.ai/developers/models/grok-4.7) below 200K input tokens, verified September 23, 2026:

| Category | Shared (50%) | Official (90%) | xAI Standard |
| --- | --- | --- | --- |
| Input | $1 | $1.80 | $2 |
| Output | $3 | $5.40 | $6 |
| Cache read | $0.25 | $0.45 | $0.50 |

These rates apply to prompts under 200K tokens. From 200K, the whole request bills at the long-context rates, twice every rate above, as on xAI: input, output and cache read are $2, $6 and $0.50 on shared, $3.60, $10.80 and $0.90 on official. An earlier version of this note said the prices stayed fixed across the context window; that was wrong, see [Long-context prices for GPT-6 Sol and Grok 4.7](https://ai.topxea.com/changelog#long-context-prices-for-gpt-6-sol-and-grok-4-7). Cached input is charged at the cache-read rate instead of the regular input rate. Cache misses use the regular input rate; there is no separate cache-write premium. Reasoning tokens use the output rate. Existing administrator overrides and historical charges are preserved.

Grok 4.7 supports text and image input, a 500K-token context window, function calling and structured outputs. Reasoning is always enabled: choose `low`, `medium`, `high` (default) or `xhigh`.

Chat Completions and Responses both support streaming and tool use. When continuing a Responses conversation, pass all returned output items into the next input, including reasoning items and their `encrypted_content`. The configured upstreams currently return `grok-4.7-build` as their response model identifier for requests to `grok-4.7`; the offered model and captured TopxAI billing model remain `grok-4.7`.

## 2026-09-23 · Long-context prices for GPT-6 Sol and Grok 4.7

The GPT-6 Sol and Grok 4.7 upgrades on September 23 dropped the long-context tier that GPT-5.6 Sol and Grok 4.6 carried, so long prompts were billed at the standard rates. The tier is back. Once the input context of a request (prompt plus cached tokens) crosses the threshold, every token in that request bills at the long-context rate, as on OpenAI and xAI. Requests below the threshold cost the same as before, and requests accepted before the change settle at the price they were quoted.

GPT-6 Sol, input above 272K tokens (from 272,001), USD per million tokens:

| Category | Shared (50%) | Official (90%) | OpenAI Standard |
| --- | --- | --- | --- |
| Input | $2 | $3.60 | $4 |
| Output | $7.50 | $13.50 | $15 |
| Cache read | $0.20 | $0.36 | $0.40 |
| Cache write | $2.50 | $4.50 | $5 |

Grok 4.7, prompt of 200K tokens or more, USD per million tokens:

| Category | Shared (50%) | Official (90%) | xAI Standard |
| --- | --- | --- | --- |
| Input | $2 | $3.60 | $4 |
| Output | $6 | $10.80 | $12 |
| Cache read | $0.50 | $0.90 | $1 |

Rates follow the [GPT-6 Sol](https://developers.openai.com/api/docs/models/gpt-6-sol) and [Grok 4.7](https://docs.x.ai/developers/models/grok-4.7) model pages, checked September 23, 2026. The price table on each model page lists both tiers, and the usage log shows which tier a request settled at.

## 2026-09-22 · Codex CLI downloads and a one-command installer

Codex CLI users who cannot reach GitHub or npm from their network no longer have to.

## Downloads

The new [Downloads](https://ai.topxea.com/downloads) page, linked from the top bar, lists the Codex CLI packages for macOS (Apple silicon and Intel), Windows (x64 and ARM64) and Linux (x64 and ARM64). Every file is the official npm package for that system, served unchanged by the mirror run by Alibaba Cloud (registry.npmmirror.com), and shown with the integrity value npm records for it; the row for your own computer is flagged. The current release is open, older ones are folded underneath.

## One command

The page also carries the installer. On macOS and Linux:

```bash
curl -fsSL https://ai.topxea.com/install/codex.sh | sh -s -- --key sk-...
```

On Windows:

```powershell
$env:TOPXAI_API_KEY = "sk-..."; irm https://ai.topxea.com/install/codex.ps1 | iex
```

It downloads the current package for your system through the mirror, verifies its integrity, puts `codex` on your PATH, adds TopxAI as the model provider in `~/.codex/config.toml` with `gpt-5.6-sol` as the default model, stores the key and checks that the key can list models. Signed in, the page fills the command with one of your own keys. Running it again updates Codex and keeps the configuration.

## The guide

The [Codex CLI page](use-topxai-with-codex-cli.md) in the docs now covers the whole path: where to get Codex, what the installer changes, the same setup by hand, models, updating and the usual failures.

## 2026-09-22 · DeepSeek V4.1 Flash and V4 Pro join the catalogue, with off-peak and peak hours

A seventh line joins the catalogue.

## Two DeepSeek models

`deepseek-flash` (DeepSeek-V4.1-Flash, 1M-token context, up to 384K output tokens, text and images in) and `deepseek-v4-pro` (DeepSeek-V4-Pro-0813) run on the `deepseek-official` line through Chat Completions. Both are priced at 80% of the DeepSeek list price.

## Off-peak and peak hours

DeepSeek publishes two tariffs. Peak hours are 01:00-04:00 and 06:00-10:00 UTC, Monday to Friday, except Chinese public holidays; every other hour, weekends and public holidays are off-peak at half the peak rate. TopxAI applies the same calendar:

| Model             | Off-peak input / cache read / output | Peak input / cache read / output |
| ----------------- | ------------------------------------ | -------------------------------- |
| `deepseek-flash`  | $0.12 / $0.0024 / $0.48              | $0.24 / $0.0048 / $0.96          |
| `deepseek-v4-pro` | $0.528 / $0.0176 / $1.584            | $1.056 / $0.0352 / $3.168        |

The tier is decided when the relay accepts a request and frozen with its price, so a long stream that crosses the boundary keeps the tier it was quoted. Every usage-log row for these models carries an "Off-peak" or "Peak hours" chip, the billing details name the lanes that were charged, the models table shows both tariffs, and the Studio toolbar says which tier is in force before you send. The hosted MCP `list_models` tool reports the current tier and both tariffs.

## 2026-09-18 · Auto-route keys, the blog, three more languages and the help messenger

One key can now cover the whole catalogue. When you create a key, pick **Auto route**: each request goes to the lowest-priced route that serves its model, shared pool before official line, and a single-line model (GLM, Kimi, Jev) lands on its line. The usage log records the route actually used. Per-route keys remain for pinning a line.

Also new:

- The keys page lists the base URL `https://ai.topxea.com/v1` and every endpoint it serves.
- A blog at `/blog`; the first article is the Jev setup guide. A model covered by an article gets an **Introduction** link on the price table.
- The interface is available in Japanese, Russian and Spanish, next to English and Chinese.
- The **Support** link in the footer and the help button at the bottom right open a messenger shared with topxea.com, so a conversation continues on either site. Email still works: support@topxea.com.
- An Acceptable Use Policy at `/acceptable-use-policy` in all five languages.

## 2026-09-18 · Card payments on topxea.com and gift cards

**Card / local payment** in the wallet now settles through topxea.com. Under **Add credit**, choose the card option, enter an amount between $10 and $10,000 and press **Continue to secure checkout**. You land on the payment page of topxea.com (Waffo); once the main site confirms the payment, your balance is credited. If the confirmation is slow, **Check payment** on the order asks for the latest status. Crypto top-ups with USDT or USDC are unchanged.

The wallet also sells gift cards. Under **Gift cards**, **Buy a gift card** issues a one-time redemption code for the amount you paid instead of adding credit to your own balance. The code appears in the order details and under **My gift cards**; any account can redeem it once under **Redeem a code**. Credit codes can also be listed for sale on topxea.com.

Usage log rows for images and video now itemize the per-image or per-second charge.

## 2026-09-18 · GLM-5.3-Abliterated, Kimi K3 and Jev join the catalogue

Three lines join Claude, OpenAI and Grok.

## GLM-5.3-Abliterated

A fine-tuned GLM 5.3 with its refusal alignment removed, served from a private deployment rather than the vendor API. Text only, priced above the Z.ai list price: $4 per 1M input tokens, $7 per 1M output. Fixed: an image, audio or file part sent to this model is replaced with a short note and the text is forwarded, instead of the request failing with a 400.

## Kimi K3

`kimi-k3` by Moonshot AI runs on one official line at 80% of list price: $2.40 input and $12 output per 1M tokens, with a 1M-token context.

## Jev

`jev-1.13.0` (aliases `jev-latest` and `jev-preview`) is TypeSafe's System One model. It answers typed questions about a state with probabilities instead of generating text, through `POST /v1/systemone`. $0.04494 per 1M input tokens, 107% of TypeSafe's list price; output is free. A key on the TypeSafe route shows a one-command setup under the key:

```bash
curl -fsSL https://ai.topxea.com/install/typesafe.sh | sh -s -- --key sk-xxxx
```

## 2026-09-18 · Image and video generation, long-context tiers

## Images

`gpt-image-2.5-sunburst` and `gpt-image-2.5-flare` replace `gpt-image-2` on the image route, through `/v1/images/generations` and `/v1/images/edits`. Billing is per picture by size: $0.03 up to 1024x1024 (1K) and $0.05 up to 2048x2048 (2K). An omitted or `auto` size is pinned to 1024x1024 before the request is priced.

## Video

`grok-imagine-video-1.5` on the Grok official line: `POST /v1/videos/generations`, 1 to 15 seconds (default 8), billed per second by resolution: $0.05 at 480p, $0.10 at 720p, $0.20 at 1080p. Poll `GET /v1/videos/{request_id}`. A failed or expired job is refunded in full, a shorter clip pro rata.

## Long context

`gpt-6-astra`, `gpt-5.6-sol` and `grok-4.6` now carry the providers' long-context tier: above 272K input tokens for OpenAI, from 200K for xAI, the whole request settles at the higher lanes. Claude, GLM and Kimi have no tier. The price table and the usage log show the tier and the per-unit charges.

## 2026-09-12 · Credit codes, shared sign-in with topxea.com and the regional notice

- Credit codes: the wallet has a **Redeem a code** section. Enter a code and press **Redeem credit**; each code adds its USD value to your balance once, and a used code cannot be redeemed by another account. Codes are issued by TopXEA, and the entry is rate-limited per account and IP.
- Shared sign-in: ai.topxea.com uses the same sign-in as topxea.com. On load, the console checks for a session that is already active on the main site and signs you in with it. The bridge does not touch your balance, keys or language.
- Regional notice: on first visit the site shows a **Service availability** dialog: TopxAI does not provide any services to users located in mainland China. The privacy policy and the user agreement carry the same sentence.
- The usage log now lists deposits and redemptions as their own rows, and each consumption row shows the selling price that was frozen for that request.

## 2026-09-11 · TopxAI is live: Claude, OpenAI and Grok through one endpoint

TopxAI is live at https://ai.topxea.com. It relays Claude, OpenAI and Grok models through one OpenAI- and Anthropic-compatible endpoint. Set the base URL to `https://ai.topxea.com/v1` and use your TopxAI key.

- Models: `claude-fable-5-1`, `claude-fable-5`, `claude-sonnet-5`, `claude-opus-5`, `gpt-6-astra`, `gpt-5.6-sol`, `gpt-image-2` and `grok-4.6`.
- Two routes per vendor: the shared pool at 50% of list price and the official line at 90%. Both reach the vendor's own models and differ only in routing and price. You pick the route when you create a key; `gpt-image-2` has its own image route.
- Fixed USD prices per million tokens, charged from a prepaid balance. Every request writes a usage-log row with model, route and charge.
- Zero retention: prompts, completions and files pass through in memory and are never written to disk. Logs hold token counts, model names, routes and identifiers.
- Upstream errors are masked into a fixed set of public error codes, each with a request id.
- Public pages are crawlable, with sitemap and robots.txt.

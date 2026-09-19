# Changelog

Every dated change to TopxAI; also at https://ai.topxea.com/changelog with an RSS feed at https://ai.topxea.com/changelog/feed.xml.

## 2026-09-18 · Image and video generation, long-context tiers

## Images

`gpt-image-2.5-sunburst` and `gpt-image-2.5-flare` replace `gpt-image-2` on the image route, through `/v1/images/generations` and `/v1/images/edits`. Billing is per picture by size: $0.03 up to 1024x1024 (1K) and $0.05 up to 2048x2048 (2K). An omitted or `auto` size is pinned to 1024x1024 before the request is priced.

## Video

`grok-imagine-video-1.5` on the Grok official line: `POST /v1/videos/generations`, 1 to 15 seconds (default 8), billed per second by resolution: $0.05 at 480p, $0.10 at 720p, $0.20 at 1080p. Poll `GET /v1/videos/{request_id}`. A failed or expired job is refunded in full, a shorter clip pro rata.

## Long context

`gpt-6-astra`, `gpt-5.6-sol` and `grok-4.6` now carry the providers' long-context tier: above 272K input tokens for OpenAI, from 200K for xAI, the whole request settles at the higher lanes. Claude, GLM and Kimi have no tier. The price table and the usage log show the tier and the per-unit charges.

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

## 2026-09-18 · Card payments on topxea.com and gift cards

**Card / local payment** in the wallet now settles through topxea.com. Under **Add credit**, choose the card option, enter an amount between $10 and $10,000 and press **Continue to secure checkout**. You land on the payment page of topxea.com (Waffo); once the main site confirms the payment, your balance is credited. If the confirmation is slow, **Check payment** on the order asks for the latest status. Crypto top-ups with USDT or USDC are unchanged.

The wallet also sells gift cards. Under **Gift cards**, **Buy a gift card** issues a one-time redemption code for the amount you paid instead of adding credit to your own balance. The code appears in the order details and under **My gift cards**; any account can redeem it once under **Redeem a code**. Credit codes can also be listed for sale on topxea.com.

Usage log rows for images and video now itemize the per-image or per-second charge.

## 2026-09-18 · Auto-route keys, the blog, three more languages and the help messenger

One key can now cover the whole catalogue. When you create a key, pick **Auto route**: each request goes to the lowest-priced route that serves its model, shared pool before official line, and a single-line model (GLM, Kimi, Jev) lands on its line. The usage log records the route actually used. Per-route keys remain for pinning a line.

Also new:

- The keys page lists the base URL `https://ai.topxea.com/v1` and every endpoint it serves.
- A blog at `/blog`; the first article is the Jev setup guide. A model covered by an article gets an **Introduction** link on the price table.
- The interface is available in Japanese, Russian and Spanish, next to English and Chinese.
- The **Support** link in the footer and the help button at the bottom right open a messenger shared with topxea.com, so a conversation continues on either site. Email still works: support@topxea.com.
- An Acceptable Use Policy at `/acceptable-use-policy` in all five languages.

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

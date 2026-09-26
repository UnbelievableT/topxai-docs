# What TopxAI stores and what it never stores

> Request and response content passes through memory only; here is what the usage log, account and payment records keep, and for how long.

This page is also published at https://ai.topxea.com/docs/what-topxai-stores-and-what-it-never-stores (English and Chinese).

## Content is relayed, not kept

Request and response bodies sent to `https://ai.topxea.com/v1` live in memory only for the relay attempt. Prompts, messages, system instructions, tool definitions and arguments, images, audio and files, completions, streamed deltas, tool calls, headers and upstream error bodies are never written to disk or a database. They are not used to train models, build profiles or serve advertising, and TopxAI does not sell data about you.

The upstream provider serving your model, and on some routes an intermediary API provider, does process the content under retention terms TopxAI does not control.

## What the usage log keeps

Each request leaves a metadata row; a request retried upstream leaves one error row per failed attempt plus one row for the final attempt. **Usage logs** in the console shows **Time**, **Type**, **Token** (the key name), **Model**, **Stream**, **Tokens**, **Cost** and **Latency**. The row also holds user id, username, key id, routing group, channel and request ids, and an IP only if the per-user `record_ip_log` setting is on.

A failed request leaves an error row with zero tokens and zero charge: the HTTP status and a fixed public category such as `rate_limited`, never the provider's message, which may echo your prompt.

## Account, payment and browser records

To run your account TopxAI processes your Clerk user id and verified primary email, session identifiers, network metadata (IP address, user agent, and location data where regional access controls are on) and payment records (order id, USD amount, payment method, provider transaction reference).

Card numbers and wallet private keys never pass through TopxAI; Waffo handles card checkout on topxea.com, NOWPayments handles USDT and USDC. A crypto top-up's transaction hash and addresses are public on chain and cannot be deleted.

[API key](create-an-api-key-and-choose-a-route.md)s are kept in recoverable form (you can view and copy them in the console), so revoke any key that leaks; personal access tokens are kept as digests. The only cookies are an HttpOnly session cookie, a `topxai_session` hint and Clerk's own; none serve advertising.

## Retention

Account and payment records stay while your account is active and as long as accounting and legal obligations require; network metadata is kept briefly. Usage records have no promised period: by default, diagnostic rows and settled per-request detail older than 30 days are pruned, so **Usage logs** shows roughly the last 30 days, while settlement records, daily totals, balances and top-ups are kept permanently.

## What you can do

**Delete** or **Disable** a key from its detail drawer. To access, export or delete other data, or close your account, use the help button at the bottom right or write to support@topxea.com; requests are verified through your signed-in account and answered within 30 days.

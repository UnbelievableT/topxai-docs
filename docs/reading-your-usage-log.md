# Reading your usage log

> What each row of the usage log shows, how to filter it, and what is never recorded.

This page is also published at https://ai.topxea.com/docs/reading-your-usage-log (English and Chinese).

**Usage logs** opens on today's Consume rows, one per successful request. Pick **All types** or another type (Top-up, Manage, System, Error, Refund, Login) in the type selector for the rest.

## What a row shows

- **Time** and **Type**.
- **Token**: the key name, then the billed route (for example `claude-shared`). An [Auto route](shared-pool-official-line-and-auto-route.md) key shows its concrete route, with no auto flag.
- **Model**: what you requested.
- **Stream**: Stream or Sync, plus output speed in tokens per second.
- **Tokens**: input / output, plus Cache Read, Cache Write (5m), Cache Write (1h) or Cache Creation lines when cached.
- **Cost**: the USD actually charged.
- **Latency**: first token and duration.
- **Details**: the route and its input / output price per million tokens, plus `+N` for further notes (long context, cache prices) that open in **Details**.

The **Details** panel starts with **Request ID** (quote it to support), **Upstream Request ID**, **Token**, **Group** and **Response Time** (with FRT for streams). **Billing Details** names the route, model and unit (USD per 1M tokens, image or second), splits **Total input** into Uncached input, Cache Read and Cache Write, then lists Item, Quantity, Unit price and Amount, a **Billing precision adjustment** line when rounding moved the total, and **Wallet charged**. A long-context request also states the threshold and its input tokens. **Stream Status** appears only when a stream ended abnormally, with **End Reason**, **Soft Errors** and **End Error** (`stream_terminated`).

A Refund row reads **Billing refund**; its **Refund Details** give the amount, original request, task id and reason. Failed, expired or shorter videos refund this way.

An Error row carries no tokens and no charge, only the HTTP status and a fixed error category. A retried request leaves an Error row beside its final Consume row; only that attempt is charged.

Login rows record the login method, IP address and user agent under **Login Info**.

## Filters

The bar has quick ranges (24h, 7d, 14d, 30d), a date picker, **Model Name**, **Group** (a route id such as `openai-official`) and the type selector. **More** adds **Token Name**, **Request ID** and **Upstream Request ID**. **Search** or Enter applies; **Reset** returns to today's Consume rows. **Hide** masks key names, routes, the totals and the Group and Token Name boxes.

Below the filters, **Net consumption** sums the selected range next to **RPM** and **TPM**; **Gross charges** and **Billing refunds** appear when the range contains a refund.

## What is never in the log

Rows hold metadata only: model, route, token counts, charge, latency, request ids, status. Prompts, completions, system prompts, tool calls, images, files and upstream error bodies are never written, and the relay keeps them nowhere else. Rows are pruned after the retention window (30 days by default), and there is no export button.

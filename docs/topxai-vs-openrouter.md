# TopxAI vs OpenRouter: what is the same and what differs

> Compare current model and route prices, including OpenRouter discounts: selected TopxAI shared routes cost less, Sol matches, and Kimi can cost more.

This page is also published at https://ai.topxea.com/docs/topxai-vs-openrouter (English and Chinese).

Both services put many providers' models behind one endpoint and one balance. The differences are in how many models, what a token costs, and what else is on offer. This page states what each side publishes; OpenRouter's numbers are from their documentation on 2026-09-19 and may change.

## Side by side

|                         | TopxAI                                                                                             | OpenRouter                                                              |
| ----------------------- | -------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------- |
| Models                  | 13, six lines: Claude, GPT, Grok, GLM (private deployment), Kimi, Jev                              | Hundreds, from most providers                                           |
| Token price             | Claude/GPT/Grok shared routes at 50% of the listed provider reference, their official routes at 90%; Kimi 80%; Jev 107%; GLM is a different private fine-tune | Varies by provider, route and promotion; not always the model vendor's list price |
| Fee on top-up           | None: the amount credited is the amount you enter (regional tax may be added at checkout)          | Standard lists a 5.5% platform fee; payment conditions and other plans differ ([pricing](https://openrouter.ai/pricing)) |
| API formats             | OpenAI Chat Completions and Responses, Anthropic Messages, Images, video, `/v1/systemone`          | OpenAI-style API; see their docs for what else is supported             |
| Routing                 | Auto route picks the lowest-priced of TopxAI's own routes for the model; per-route keys pin a line | Routes across providers, with fallbacks and provider preferences        |
| Prompts and completions | Relayed in memory, never stored                                                                    | Their privacy page describes logging options and zero-retention routes  |
| Extras                  | Usage log per request with route and charge; gift cards; shared sign-in with topxea.com            | Web search plugin, presets, app attribution, provider analytics         |
| Free start              | $0.50 credit at sign-up                                                                            | Free-tier models                                                        |

## Current price examples

Checked on September 19, 2026 against the [TopxAI price API](https://ai.topxea.com/api/pricing), [OpenRouter model API](https://openrouter.ai/api/v1/models) and the linked provider pages. Prices below are USD per million tokens, shown as **input / output**, for standard online requests below any long-context threshold. They exclude platform fees, taxes, cache tokens and tool charges; Batch and Flex are separate service tiers.

| Model | TopxAI route | TopxAI input / output | OpenRouter standard input / output | Comparison |
| --- | --- | --- | --- | --- |
| Claude Sonnet 5 | Shared | $1 / $5 | $2 / $10 | TopxAI 50% lower |
| Claude Opus 5 | Shared | $2.50 / $12.50 | $5 / $25 | TopxAI 50% lower |
| Claude Fable 5.1 | Shared | $5 / $25 | $10 / $50 | TopxAI 50% lower |
| GPT-6 Astra | Shared | $5 / $25 | $10 / $50 | TopxAI 50% lower |
| GPT-5.6 Sol | Shared | $2 / $10 | $2 / $10 | Same token price during OpenRouter's current promotion |
| Grok 4.6 | Shared | $1 / $3 | $2 / $6 | TopxAI 50% lower |
| Kimi K3 | Official | $2.40 / $12 | From $1.70 / $8.50 | TopxAI about 41% higher than the lowest listed route |

[OpenRouter's Sol page](https://openrouter.ai/openai/gpt-5.6-sol) lists a 50%-off OpenAI standard endpoint; its cheaper Flex endpoint is not standard routing. [Its Kimi page](https://openrouter.ai/moonshotai/kimi-k3) lists Relace at $1.70 / $8.50 and Moonshot AI at $3 / $15. TopxAI's Kimi official route is 20% below that Moonshot route, but not below every third-party host. A lower advertised rate does not establish equal throughput, availability or hosting conditions.

The 50% saving applies to the specified shared routes and comparison prices, not every TopxAI model or route. Auto routing can select a different-priced route; inspect the billed route in the usage log. Provider Batch/Flex discounts, cache hit rates, long-context tiers and retries can change an actual workload's bill. These are public price comparisons, not a paid performance or billing benchmark. Recheck the live ledgers before purchasing.

## Where TopxAI is the better fit

- You use a handful of the big models and the price per token matters: on the shared pool, `claude-sonnet-5` is $1 input / $5 output per 1M tokens against a $2 / $10 list price ([model page](https://ai.topxea.com/pricing/claude-sonnet-5)).
- You want the Anthropic Messages format, not only an OpenAI-style one, for Claude Code, the Anthropic SDK or any tool that speaks it.
- You want a fixed, published price per route and a log row per request that shows which route it took.
- You want nothing stored: no prompt, no completion, no file.

## Where OpenRouter is the better fit

- You need a model TopxAI does not sell: an open-weight model, a small vendor, or the latest release before it reaches the catalogue.
- You want cross-provider fallbacks or a preference for a particular hosting provider.
- You rely on their extras: web search in the request, presets, or per-app analytics.
- Your chosen provider has a lower current price for the model you need, such as the Kimi K3 routes above; compare the actual route, not only the vendor's reference price.

## Using both

Nothing prevents it. Both are OpenAI-compatible, so a client that takes a base URL and a model id switches with two values. A LiteLLM or opencode configuration can list TopxAI models next to OpenRouter models under separate provider names ([LiteLLM page](use-topxai-with-litellm.md), [opencode page](use-topxai-with-opencode.md)).

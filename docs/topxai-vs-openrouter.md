# TopxAI vs OpenRouter: what is the same and what differs

> Both relay requests on prepaid credit. OpenRouter lists hundreds of models at list price plus a top-up fee; TopxAI sells 13 models at 50% to 90% of list.

This page is also published at https://ai.topxea.com/docs/topxai-vs-openrouter (English and Chinese).

Both services put many providers' models behind one endpoint and one balance. The differences are in how many models, what a token costs, and what else is on offer. This page states what each side publishes; OpenRouter's numbers are from their documentation on 2026-09-19 and may change.

## Side by side

|                         | TopxAI                                                                                             | OpenRouter                                                              |
| ----------------------- | -------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------- |
| Models                  | 13, six lines: Claude, GPT, Grok, GLM (private deployment), Kimi, Jev                              | Hundreds, from most providers                                           |
| Token price             | Shared pool 50% of the provider's list, official line 90%; Kimi 80%; Jev 107%; GLM above list      | The provider's list price, passed through                               |
| Fee on top-up           | None: the amount credited is the amount you enter (regional tax may be added at checkout)          | A percentage fee on credit purchases; their FAQ states the current rate |
| API formats             | OpenAI Chat Completions and Responses, Anthropic Messages, Images, video, `/v1/systemone`          | OpenAI-style API; see their docs for what else is supported             |
| Routing                 | Auto route picks the lowest-priced of TopxAI's own routes for the model; per-route keys pin a line | Routes across providers, with fallbacks and provider preferences        |
| Prompts and completions | Relayed in memory, never stored                                                                    | Their privacy page describes logging options and zero-retention routes  |
| Extras                  | Usage log per request with route and charge; gift cards; shared sign-in with topxea.com            | Web search plugin, presets, app attribution, provider analytics         |
| Free start              | $0.50 credit at sign-up                                                                            | Free-tier models                                                        |

## Where TopxAI is the better fit

- You use a handful of the big models and the price per token matters: on the shared pool, `claude-sonnet-5` is $1 input / $5 output per 1M tokens against a $2 / $10 list price ([model page](https://ai.topxea.com/pricing/claude-sonnet-5)).
- You want the Anthropic Messages format, not only an OpenAI-style one, for Claude Code, the Anthropic SDK or any tool that speaks it.
- You want a fixed, published price per route and a log row per request that shows which route it took.
- You want nothing stored: no prompt, no completion, no file.

## Where OpenRouter is the better fit

- You need a model TopxAI does not sell: an open-weight model, a small vendor, or the latest release before it reaches the catalogue.
- You want cross-provider fallbacks or a preference for a particular hosting provider.
- You rely on their extras: web search in the request, presets, or per-app analytics.

## Using both

Nothing prevents it. Both are OpenAI-compatible, so a client that takes a base URL and a model id switches with two values. A LiteLLM or opencode configuration can list TopxAI models next to OpenRouter models under separate provider names ([LiteLLM page](use-topxai-with-litellm.md), [opencode page](use-topxai-with-opencode.md)).

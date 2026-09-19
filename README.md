# TopxAI — one API endpoint for Claude, GPT, Grok, GLM, Kimi and Jev

[TopxAI](https://ai.topxea.com) is the model API service run by [TopXEA](https://topxea.com). Thirteen models from six lines are served through OpenAI- and Anthropic-compatible endpoints at fixed USD prices, on prepaid credit, and nothing you send is stored.

This repository holds the public documentation in Markdown. The same pages are published, in English and Chinese, at **https://ai.topxea.com/docs**.

- Sign in and create a key: https://ai.topxea.com/keys
- Models and prices: https://ai.topxea.com/#models
- Documentation: https://ai.topxea.com/docs
- Every model's price on its own page: https://ai.topxea.com/pricing · price calculator: https://ai.topxea.com/tools/price-calculator
- API reference and OpenAPI 3.1: https://ai.topxea.com/docs/api-reference · [openapi.json](openapi.json)
- Changelog: https://ai.topxea.com/changelog · [CHANGELOG.md](CHANGELOG.md) · RSS https://ai.topxea.com/changelog/feed.xml
- Blog: https://ai.topxea.com/blog
- Support: the help button at the bottom right of any page, or support@topxea.com

## Quick start

Point the SDK you already use at TopxAI; the key goes where the provider's key would go.

```python
from openai import OpenAI

client = OpenAI(base_url="https://ai.topxea.com/v1", api_key="sk-...")
reply = client.chat.completions.create(
    model="claude-sonnet-5",
    messages=[{"role": "user", "content": "Say hello in one sentence."}],
)
print(reply.choices[0].message.content)
```

```python
from anthropic import Anthropic

client = Anthropic(base_url="https://ai.topxea.com", api_key="sk-...")
reply = client.messages.create(
    model="claude-sonnet-5",
    max_tokens=256,
    messages=[{"role": "user", "content": "Say hello in one sentence."}],
)
print(reply.content[0].text)
```

More in [examples/](examples/) and in [Connect your SDK](docs/connect-your-sdk.md).

## Endpoints

| Path | Dialect | Models |
| --- | --- | --- |
| `POST /v1/chat/completions` | OpenAI Chat Completions | every text model except Jev |
| `POST /v1/responses` | OpenAI Responses | GPT models |
| `POST /v1/messages` | Anthropic Messages | Claude models |
| `POST /v1/images/generations`, `POST /v1/images/edits` | OpenAI Images | `gpt-image-2.5-sunburst`, `gpt-image-2.5-flare` |
| `POST /v1/videos/generations`, `GET /v1/videos/{request_id}` | OpenAI Videos | `grok-imagine-video-1.5` |
| `POST /v1/systemone` | TypeSafe System One | `jev-1.13.0` |
| `GET /v1/models` | OpenAI | the models your key can use |

## Models and prices

Prices are in USD, fixed per model and route; the live table at https://ai.topxea.com/#models and `GET https://ai.topxea.com/api/pricing` are the source of truth. Text models bill per million tokens (input / output; cache read where the provider supports it). The **shared pool** is 50% of the provider's list price, the **official line** 90%; a key on **Auto route** sends each request to the lowest-priced line that serves its model.

| Model | Shared pool (in / out) | Official line (in / out) |
| --- | --- | --- |
| `claude-fable-5-1` | $5 / $25 | $9 / $45 |
| `claude-fable-5` | $5 / $25 | $9 / $45 |
| `claude-opus-5` | $2.50 / $12.50 | $4.50 / $22.50 |
| `claude-sonnet-5` | $1 / $5 | $1.80 / $9 |
| `gpt-6-astra` | $5 / $25 | $9 / $45 |
| `gpt-5.6-sol` | $2 / $10 | $3.60 / $18 |
| `grok-4.6` | $1 / $3 | $1.80 / $5.40 |
| `kimi-k3` | — | $2.40 / $12 (80% of list) |
| `jev-1.13.0` (TypeSafe System One) | — | $0.04494 / output free |
| `GLM-5.3-Abliterated` (private deployment) | — | $4 / $7 |

| Model | Unit | Price |
| --- | --- | --- |
| `gpt-image-2.5-sunburst`, `gpt-image-2.5-flare` | per image | $0.03 up to 1024×1024, $0.05 up to 2048×2048 |
| `grok-imagine-video-1.5` | per second of video | $0.05 at 480p, $0.10 at 720p, $0.20 at 1080p |

`GLM-5.3-Abliterated` is a fine-tuned GLM 5.3 with its refusal alignment removed, served from a private deployment rather than the vendor's API; it is text only, priced above list, and covered by the same [Acceptable Use Policy](https://ai.topxea.com/acceptable-use-policy) as every other line. Prices as of 2026-09-18.

## Documentation

### Getting started

- [What TopxAI is](docs/what-topxai-is.md) — One base URL, thirteen models on six lines, prepaid USD credit, and nothing you send is stored.
- [Create an API key and choose a route](docs/create-an-api-key-and-choose-a-route.md) — The key drawer step by step, what each route means, and the three 403 refusals a key can hit.
- [Connect your SDK](docs/connect-your-sdk.md) — The base URL, every endpoint with its auth header, working examples for the OpenAI and Anthropic SDKs, and what each error status means.
- [API reference: every endpoint, with an OpenAPI specification](docs/api-reference.md) — Every endpoint TopxAI serves, what each accepts and returns, the two ways to send the key, and the OpenAPI 3.1 file at /openapi.json for API tools.

### Integrations

- [Claude Code with TopxAI: ANTHROPIC_BASE_URL and the key](docs/use-topxai-with-claude-code.md) — Point Claude Code at https://ai.topxea.com with two environment variables and pick claude-sonnet-5, claude-opus-5 or the Fable models as its model.
- [Codex CLI with TopxAI: a model provider in config.toml](docs/use-topxai-with-codex-cli.md) — Add TopxAI as a model provider in ~/.codex/config.toml with the Responses API base URL, then run Codex on gpt-5.6-sol, gpt-6-astra or grok-4.6.
- [Cursor with TopxAI: override the OpenAI base URL](docs/use-topxai-with-cursor.md) — In Cursor, paste a TopxAI key as the OpenAI key, turn on the base URL override with https://ai.topxea.com/v1 and add the model ids you want to chat with.
- [Cline and Roo Code with TopxAI: the OpenAI-compatible provider](docs/use-topxai-with-cline-and-roo-code.md) — Set the provider to OpenAI Compatible with base URL https://ai.topxea.com/v1, a TopxAI key and a model id; or the Anthropic provider with a custom base URL.
- [Continue with TopxAI: models in config.yaml](docs/use-topxai-with-continue.md) — Add TopxAI models to ~/.continue/config.yaml with provider openai or anthropic and apiBase, then use them for chat, edit and agent mode in VS Code or JetBrains.
- [Zed with TopxAI: OpenAI- and Anthropic-compatible providers](docs/use-topxai-with-zed.md) — Add TopxAI to Zed as an openai_compatible provider for GPT, Grok, Kimi and GLM, and as an anthropic_compatible provider for Claude, in settings.json.
- [Aider with TopxAI: OPENAI_API_BASE and the model name](docs/use-topxai-with-aider.md) — Run aider against TopxAI with OPENAI_API_BASE=https://ai.topxea.com/v1 and --model openai/claude-sonnet-5, or the Anthropic variables for the Claude line.
- [opencode with TopxAI: a custom provider in opencode.json](docs/use-topxai-with-opencode.md) — Declare TopxAI in opencode.json with @ai-sdk/openai-compatible, the base URL and the model ids, then pick them with /models.
- [Open WebUI with TopxAI: one OpenAI connection, every model](docs/use-topxai-with-open-webui.md) — Add https://ai.topxea.com/v1 as an OpenAI API connection in Open WebUI; the model list fills from /v1/models and every text model is ready to chat.
- [LobeChat with TopxAI: the OpenAI proxy address](docs/use-topxai-with-lobechat.md) — Set OpenAI’s API proxy address to https://ai.topxea.com/v1 in LobeChat, or OPENAI_PROXY_URL for a deployment, and fetch the model list.
- [Cherry Studio with TopxAI: add a provider](docs/use-topxai-with-cherry-studio.md) — Add TopxAI in Cherry Studio as an OpenAI-type provider with address https://ai.topxea.com and your key; Cherry appends /v1. Claude also works as Anthropic type.
- [ChatBox with TopxAI: a custom provider](docs/use-topxai-with-chatbox.md) — In ChatBox, add a custom provider in OpenAI API compatible mode with host https://ai.topxea.com and path /v1/chat/completions, then add the model ids.
- [LangChain with TopxAI: ChatOpenAI and ChatAnthropic with a base URL](docs/use-topxai-with-langchain.md) — Use TopxAI from LangChain (Python and JavaScript) by passing base_url to ChatOpenAI for every text model, or to ChatAnthropic for Claude with prompt caching.
- [Vercel AI SDK with TopxAI: createOpenAI, createAnthropic and openai-compatible](docs/use-topxai-with-vercel-ai-sdk.md) — Create an AI SDK provider with baseURL https://ai.topxea.com/v1 and a TopxAI key, then use generateText or streamText with any catalogue model.
- [LiteLLM with TopxAI: proxy config and the Python SDK](docs/use-topxai-with-litellm.md) — Route LiteLLM to TopxAI with model openai/<id> and api_base https://ai.topxea.com/v1, in the proxy’s model_list or a completion() call.
- [Dify with TopxAI: the OpenAI-API-compatible provider](docs/use-topxai-with-dify.md) — Add each TopxAI model to Dify through the OpenAI-API-compatible provider with endpoint https://ai.topxea.com/v1, your key and the model id.
- [n8n with TopxAI: an OpenAI credential with a base URL](docs/use-topxai-with-n8n.md) — Create an OpenAI credential in n8n with base URL https://ai.topxea.com/v1 and a TopxAI key, then use any catalogue model in the Chat Model and AI Agent nodes.
- [llm CLI with TopxAI: extra-openai-models.yaml](docs/use-topxai-with-llm-cli.md) — Register TopxAI models in llm’s extra-openai-models.yaml with api_base https://ai.topxea.com/v1, store the key with llm keys set, and prompt from the shell.

### Routes and pricing

- [Shared pool, official line and auto route](docs/shared-pool-official-line-and-auto-route.md) — Same models, different routing and price: what each API-key route means and how Auto route picks one for you.
- [How requests are billed](docs/how-requests-are-billed.md) — Billing units, long-context tiers, the up-front reservation and what happens to it when a request fails.
- [Reading your usage log](docs/reading-your-usage-log.md) — What each row of the usage log shows, how to filter it, and what is never recorded.

### Models

- [Jev (TypeSafe System One)](docs/jev-typesafe-system-one.md) — What Jev returns, how to call POST /v1/systemone, the one-line setup under a TypeSafe official-line key, and what it costs.
- [GLM-5.3-Abliterated](docs/glm-5-3-abliterated.md) — A fine-tuned GLM 5.3 on a private deployment: text only, priced above list, and covered by a compliance notice.
- [Image generation](docs/image-generation.md) — gpt-image-2.5-sunburst and -flare: the two endpoints, the 1K and 2K per-image prices, how the size tier is chosen, and where the image link comes from.
- [Video generation](docs/video-generation.md) — grok-imagine-video-1.5: submit a job, poll it, per-second prices by resolution, refunds on failure, and how forgotten jobs are refunded after 24 hours.

### Payments and credit

- [Top up with a card](docs/top-up-with-a-card.md) — Add USD credit with a card, Apple Pay, Google Pay or a local e-wallet; the checkout runs on topxea.com through Waffo.
- [Pay with crypto](docs/pay-with-crypto.md) — Top up with USDT or USDC through a NOWPayments invoice: what to send, how long confirmation takes, and what happens if you send too little.
- [Gift cards and credit codes](docs/gift-cards-and-credit-codes.md) — Buy a single-use credit code, redeem one on any account, and what the User Agreement says about refunds.

### Troubleshooting

- [Common error responses](docs/common-error-responses.md) — What each HTTP status and error code from the gateway means, and what to change before you retry.
- [The model works in curl but not in my tool](docs/the-model-works-in-curl-but-not-in-my-tool.md) — Seven places where a tool differs from the working curl: base URL, auth header, model id, key route and limits, IP whitelist, GLM and Jev endpoints, timeouts.
- [Sign-in and account](docs/sign-in-and-account.md) — How sign-in is shared with topxea.com, how sessions and devices work, the regional service notice, and how to reach support.

### Comparisons

- [TopxAI vs OpenRouter: what is the same and what differs](docs/topxai-vs-openrouter.md) — Compare current model and route prices, including OpenRouter discounts: selected TopxAI shared routes cost less, Sol matches, and Kimi can cost more.
- [TopxAI vs the providers' own APIs: price, retention and what stays direct](docs/topxai-vs-the-providers-own-apis.md) — What changes when Claude, GPT, Grok or Kimi go through TopxAI: the price per token, one key and one balance, zero retention, and what stays with the provider.

### Privacy and policies

- [What TopxAI stores and what it never stores](docs/what-topxai-stores-and-what-it-never-stores.md) — Request and response content passes through memory only; here is what the usage log, account and payment records keep, and for how long.
- [Acceptable use and abuse reports](docs/acceptable-use-and-abuse-reports.md) — The six prohibited content categories, how enforcement works, why GLM's private deployment is no exception, and how to report abuse.
## Retention and policies

Prompts, completions and uploaded files are relayed in memory and never written to disk; the usage log keeps token counts, model names, routes and request ids. Details: [Privacy Policy](https://ai.topxea.com/privacy-policy), [User Agreement](https://ai.topxea.com/user-agreement), [Acceptable Use Policy](https://ai.topxea.com/acceptable-use-policy).

## About TopXEA

TopXEA (https://topxea.com) sells MetaTrader expert advisors, parameter sets and equity research, and runs TopxAI as its model API. Announcements: [X @topxea](https://x.com/topxea), [Telegram @topxea](https://t.me/topxea).

## Contributing

Corrections to these pages are welcome as pull requests; the pages mirror https://ai.topxea.com/docs and are updated from there.

## License

The documentation in this repository is released under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/); the code snippets under `examples/` are public domain (CC0).

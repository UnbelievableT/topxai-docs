# Codex CLI with TopxAI: a model provider in config.toml

> Add TopxAI as a model provider in ~/.codex/config.toml with the Responses API base URL, then run Codex on gpt-5.6-sol, gpt-6-astra or grok-4.6.

This page is also published at https://ai.topxea.com/docs/use-topxai-with-codex-cli (English and Chinese).

Codex CLI speaks the OpenAI Responses API. TopxAI serves it at `https://ai.topxea.com/v1/responses` for the GPT models and `grok-4.6`, so Codex needs one provider block and one environment variable.

## Setup

In `~/.codex/config.toml` (user level; Codex ignores `model_provider` in a project's `.codex/config.toml`):

```toml
model = "gpt-5.6-sol"
model_provider = "topxai"

[model_providers.topxai]
name = "TopxAI"
base_url = "https://ai.topxea.com/v1"
env_key = "TOPXAI_API_KEY"
wire_api = "responses"
```

Then export the key and start Codex:

```bash
export TOPXAI_API_KEY=sk-...   # a TopxAI key on the OpenAI, Grok or Auto route
codex
```

`wire_api = "responses"` is the default and the only value current Codex releases accept; it is written out so nobody wonders. `base_url` is the origin with `/v1`; Codex appends `/responses`.

## Models

- `gpt-5.6-sol` and `gpt-6-astra`: the OpenAI line, on the shared pool (50% of list) or the official line (90%).
- `grok-4.6`: the only non-OpenAI model on the Responses endpoint.
- Claude, GLM, Kimi and Jev are not reachable through Codex, because Codex only speaks Responses.

Switch models with `codex -m gpt-6-astra` or by editing `model`. Reasoning effort is set with `model_reasoning_effort`; TopxAI forwards it unchanged.

## Long context

Once a request's input context reaches 272,001 tokens, the whole request bills at the model's long-context rate, shown on the [model's page](https://ai.topxea.com/pricing/gpt-5.6-sol). Codex compacts long sessions on its own; the usage log shows which rate each request settled at.

## If it fails

- 401: the key is wrong or was pasted with a space. 402: the balance is empty. 403: the model id is not sold here or is not on this key's route. See [Common error responses](common-error-responses.md).
- The model works in curl but not in the tool: [that page](the-model-works-in-curl-but-not-in-my-tool.md) lists the usual causes, one per tool.

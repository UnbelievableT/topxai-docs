# Aider with TopxAI: OPENAI_API_BASE and the model name

> Run aider against TopxAI with OPENAI_API_BASE=https://ai.topxea.com/v1 and --model openai/claude-sonnet-5, or the Anthropic variables for the Claude line.

This page is also published at https://ai.topxea.com/docs/use-topxai-with-aider (English and Chinese).

Aider uses [LiteLLM](use-topxai-with-litellm.md) underneath, so any OpenAI-compatible endpoint works through the `openai/` prefix, and the Anthropic endpoint through `anthropic/`.

## OpenAI-compatible (every text model)

```bash
export OPENAI_API_BASE=https://ai.topxea.com/v1
export OPENAI_API_KEY=sk-...          # a TopxAI key on the Auto route
aider --model openai/claude-sonnet-5
```

Any catalogue id except [Jev](jev-typesafe-system-one.md) goes after `openai/`: `openai/gpt-6-sol`, `openai/grok-4.7`, `openai/kimi-k3`, `openai/GLM-5.3-Abliterated`.

## Anthropic (Claude, with prompt caching)

```bash
export ANTHROPIC_API_BASE=https://ai.topxea.com
export ANTHROPIC_API_KEY=sk-...
aider --model anthropic/claude-sonnet-5 --cache-prompts
```

`--cache-prompts` turns on Aider's cache breakpoints; TopxAI forwards them and bills cache reads at one tenth of the input price.

## Model metadata

Aider warns when it has no context-window or price data for a model name. Add a `.aider.model.metadata.json` next to your project so the warnings stop and the token meter is right:

```json
{
  "openai/claude-sonnet-5": {
    "max_input_tokens": 1000000,
    "max_output_tokens": 128000,
    "input_cost_per_token": 0.000001,
    "output_cost_per_token": 0.000005,
    "litellm_provider": "openai",
    "mode": "chat"
  }
}
```

The costs above are the shared-pool prices from the [model's page](https://ai.topxea.com/pricing/claude-sonnet-5); Aider uses them only for its running total, the actual charge is in the TopxAI [usage log](reading-your-usage-log.md).

## Persisting it

Put the same values in `~/.aider.conf.yml` (`model: openai/claude-sonnet-5`, `openai-api-base: https://ai.topxea.com/v1`) and the key in `~/.aider/oai.env` or your shell profile.

## If it fails

- 401: the key is wrong or was pasted with a space. 402: the balance is empty. 403: the model id is not sold here or is not on this key's route. See [Common error responses](common-error-responses.md).
- The model works in curl but not in the tool: [that page](the-model-works-in-curl-but-not-in-my-tool.md) lists the usual causes, one per tool.

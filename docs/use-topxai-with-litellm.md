# LiteLLM with TopxAI: proxy config and the Python SDK

> Route LiteLLM to TopxAI with model openai/<id> and api_base https://ai.topxea.com/v1, in the proxy’s model_list or a completion() call.

This page is also published at https://ai.topxea.com/docs/use-topxai-with-litellm (English and Chinese).

LiteLLM reaches any OpenAI-compatible endpoint with the `openai/` prefix and an `api_base`, and the Anthropic endpoint with `anthropic/`. That covers every TopxAI text model.

## Python SDK

```python
import litellm

reply = litellm.completion(
    model="openai/claude-sonnet-5",
    api_base="https://ai.topxea.com/v1",
    api_key="sk-...",
    messages=[{"role": "user", "content": "Say hello in one sentence."}],
)
print(reply.choices[0].message.content)
```

For Claude with prompt caching through the Messages API:

```python
reply = litellm.completion(
    model="anthropic/claude-sonnet-5",
    api_base="https://ai.topxea.com",
    api_key="sk-...",
    messages=[...],
)
```

## Proxy config.yaml

```yaml
model_list:
  - model_name: claude-sonnet-5
    litellm_params:
      model: openai/claude-sonnet-5
      api_base: https://ai.topxea.com/v1
      api_key: os.environ/TOPXAI_API_KEY
  - model_name: gpt-5.6-sol
    litellm_params:
      model: openai/gpt-5.6-sol
      api_base: https://ai.topxea.com/v1
      api_key: os.environ/TOPXAI_API_KEY
  - model_name: kimi-k3
    litellm_params:
      model: openai/kimi-k3
      api_base: https://ai.topxea.com/v1
      api_key: os.environ/TOPXAI_API_KEY
```

Start it with `litellm --config config.yaml`; clients then call the proxy with the `model_name` values.

## Cost tracking

LiteLLM prices by model name and knows nothing about TopxAI's routes. To make its cost column match the usage log, set `input_cost_per_token` and `output_cost_per_token` in `litellm_params` from the [model's page](https://ai.topxea.com/pricing/claude-sonnet-5) (for example `0.000001` and `0.000005` for `claude-sonnet-5` on the shared pool).

## If it fails

- 401: the key is wrong or was pasted with a space. 402: the balance is empty. 403: the model id is not sold here or is not on this key's route. See [Common error responses](common-error-responses.md).
- The model works in curl but not in the tool: [that page](the-model-works-in-curl-but-not-in-my-tool.md) lists the usual causes, one per tool.

# llm CLI with TopxAI: extra-openai-models.yaml

> Register TopxAI models in llm’s extra-openai-models.yaml with api_base https://ai.topxea.com/v1, store the key with llm keys set, and prompt from the shell.

This page is also published at https://ai.topxea.com/docs/use-topxai-with-llm-cli (English and Chinese).

Simon Willison's `llm` reads extra OpenAI-compatible models from a YAML file in its config directory. Each TopxAI model is one entry.

## Register the models

```bash
llm keys set topxai            # paste a TopxAI key on the Auto route
cat > "$(dirname "$(llm keys path)")/extra-openai-models.yaml" <<'EOF'
- model_id: claude-sonnet-5
  model_name: claude-sonnet-5
  api_base: https://ai.topxea.com/v1
  api_key_name: topxai
  supports_tools: true
  vision: true
- model_id: gpt-5.6-sol
  model_name: gpt-5.6-sol
  api_base: https://ai.topxea.com/v1
  api_key_name: topxai
  supports_tools: true
  vision: true
- model_id: kimi-k3
  model_name: kimi-k3
  api_base: https://ai.topxea.com/v1
  api_key_name: topxai
  supports_tools: true
EOF
llm models | grep -i topxea
```

`api_key_name` points at the key stored with `llm keys set`, so the YAML holds no secret. `model_id` is the name you use on the command line; `model_name` is what is sent to TopxAI. They can differ (`model_id: sonnet`) if you want a short alias.

## Prompt

```bash
llm -m claude-sonnet-5 "Say hello in one sentence."
llm -m gpt-5.6-sol -s "Answer in JSON" "List three ports of Portugal"
cat main.go | llm -m kimi-k3 "Explain this file"
```

`llm logs -n 1` shows the last request and response; the charge is in the TopxAI usage log.

## Responses API

Add `responses: true` to a GPT entry to send it through `/v1/responses` instead of Chat Completions; TopxAI serves both for the GPT models.

## If it fails

- 401: the key is wrong or was pasted with a space. 402: the balance is empty. 403: the model id is not sold here or is not on this key's route. See [Common error responses](common-error-responses.md).
- The model works in curl but not in the tool: [that page](the-model-works-in-curl-but-not-in-my-tool.md) lists the usual causes, one per tool.

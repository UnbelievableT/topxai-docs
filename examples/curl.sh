#!/bin/sh
# Three endpoints, one key. Replace sk-... with a key from https://ai.topxea.com/keys
KEY="sk-..."

# OpenAI-style Chat Completions (Claude, GPT, Grok, GLM, Kimi)
curl https://ai.topxea.com/v1/chat/completions \
  -H "Authorization: Bearer $KEY" -H "Content-Type: application/json" \
  -d '{"model":"gpt-5.6-sol","messages":[{"role":"user","content":"Say hello in one sentence."}]}'

# Anthropic-style Messages (Claude)
curl https://ai.topxea.com/v1/messages \
  -H "x-api-key: $KEY" -H "anthropic-version: 2023-06-01" -H "Content-Type: application/json" \
  -d '{"model":"claude-sonnet-5","max_tokens":256,"messages":[{"role":"user","content":"Say hello in one sentence."}]}'

# Image generation (GPT Image 2.5), billed per picture by size
curl https://ai.topxea.com/v1/images/generations \
  -H "Authorization: Bearer $KEY" -H "Content-Type: application/json" \
  -d '{"model":"gpt-image-2.5-sunburst","prompt":"a lighthouse at dusk, oil painting","size":"1024x1024"}'

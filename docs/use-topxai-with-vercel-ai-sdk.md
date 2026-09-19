# Vercel AI SDK with TopxAI: createOpenAI, createAnthropic and openai-compatible

> Create an AI SDK provider with baseURL https://ai.topxea.com/v1 and a TopxAI key, then use generateText or streamText with any catalogue model.

This page is also published at https://ai.topxea.com/docs/use-topxai-with-vercel-ai-sdk (English and Chinese).

The AI SDK's provider packages accept a `baseURL`, so TopxAI is one `create…` call away.

## @ai-sdk/openai

```ts
import { createOpenAI } from '@ai-sdk/openai'
import { generateText } from 'ai'

const topxai = createOpenAI({
  baseURL: 'https://ai.topxea.com/v1',
  apiKey: process.env.TOPXAI_API_KEY,
})

const { text } = await generateText({
  model: topxai.chat('claude-sonnet-5'),
  prompt: 'Say hello in one sentence.',
})
```

`topxai.chat(id)` uses Chat Completions and serves every text model except Jev. `topxai.responses("gpt-5.6-sol")` uses the Responses API, which TopxAI serves for the GPT models and `grok-4.6`. `topxai.image("gpt-image-2.5-sunburst")` generates images, billed per picture.

## @ai-sdk/anthropic

```ts
import { createAnthropic } from '@ai-sdk/anthropic'

const claude = createAnthropic({
  baseURL: 'https://ai.topxea.com/v1',
  apiKey: process.env.TOPXAI_API_KEY,
})

const { text } = await generateText({
  model: claude('claude-opus-5'),
  prompt: 'Say hello in one sentence.',
})
```

This package's base URL ends in `/v1` (it appends `/messages`), unlike the Anthropic Python SDK, which takes the origin.

## @ai-sdk/openai-compatible

For a provider object without OpenAI-specific options:

```ts
import { createOpenAICompatible } from '@ai-sdk/openai-compatible'

const topxai = createOpenAICompatible({
  name: 'topxai',
  baseURL: 'https://ai.topxea.com/v1',
  apiKey: process.env.TOPXAI_API_KEY,
})
const model = topxai('kimi-k3')
```

## Notes

- `streamText`, tool calling and `Output.object` structured output work as with the provider's own endpoint.
- `usage` on the result carries the token counts TopxAI returns; the charge itself is in the usage log.

## If it fails

- 401: the key is wrong or was pasted with a space. 402: the balance is empty. 403: the model id is not sold here or is not on this key's route. See [Common error responses](common-error-responses.md).
- The model works in curl but not in the tool: [that page](the-model-works-in-curl-but-not-in-my-tool.md) lists the usual causes, one per tool.

# LangChain with TopxAI: ChatOpenAI and ChatAnthropic with a base URL

> Use TopxAI from LangChain (Python and JavaScript) by passing base_url to ChatOpenAI for every text model, or to ChatAnthropic for Claude with prompt caching.

This page is also published at https://ai.topxea.com/docs/use-topxai-with-langchain (English and Chinese).

LangChain's chat model classes take a base URL. `ChatOpenAI` reaches every TopxAI text model through Chat Completions; `ChatAnthropic` reaches Claude through the Messages API.

## Python

```python
from langchain_openai import ChatOpenAI
from langchain_anthropic import ChatAnthropic

llm = ChatOpenAI(
    model="claude-sonnet-5",
    base_url="https://ai.topxea.com/v1",
    api_key="sk-...",
)
print(llm.invoke("Say hello in one sentence.").content)

claude = ChatAnthropic(
    model="claude-sonnet-5",
    base_url="https://ai.topxea.com",
    api_key="sk-...",
    max_tokens=1024,
)
```

Swap `model` for `gpt-5.6-sol`, `grok-4.6`, `kimi-k3` or `GLM-5.3-Abliterated` on `ChatOpenAI`. Tool calling, streaming and structured output work as with the provider's own endpoint; TopxAI forwards the request unchanged.

## JavaScript

```ts
import { ChatOpenAI } from '@langchain/openai'
import { ChatAnthropic } from '@langchain/anthropic'

const llm = new ChatOpenAI({
  model: 'gpt-5.6-sol',
  apiKey: process.env.TOPXAI_API_KEY,
  configuration: { baseURL: 'https://ai.topxea.com/v1' },
})

const claude = new ChatAnthropic({
  model: 'claude-sonnet-5',
  apiKey: process.env.TOPXAI_API_KEY,
  anthropicApiUrl: 'https://ai.topxea.com',
})
```

## Environment variables

Both libraries also read `OPENAI_BASE_URL` / `OPENAI_API_KEY` and `ANTHROPIC_BASE_URL` / `ANTHROPIC_API_KEY`, so a deployment can switch endpoints without a code change.

## Embeddings

The catalogue has no embedding model; keep `OpenAIEmbeddings` on the provider you use today.

## If it fails

- 401: the key is wrong or was pasted with a space. 402: the balance is empty. 403: the model id is not sold here or is not on this key's route. See [Common error responses](common-error-responses.md).
- The model works in curl but not in the tool: [that page](the-model-works-in-curl-but-not-in-my-tool.md) lists the usual causes, one per tool.

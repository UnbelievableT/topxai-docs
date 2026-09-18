# GLM-5.3-Abliterated

> A fine-tuned GLM 5.3 on a private deployment: text only, priced above list, and covered by a compliance notice.

This page is also published at https://ai.topxea.com/docs/glm-5-3-abliterated (English and Chinese).

`GLM-5.3-Abliterated` is a commercially fine-tuned variant of Z.ai's GLM-5.3, served from a private deployment rather than the provider's official API. The tuning adds vertical business skills and removes the built-in refusal alignment (that is what "abliterated" means). It is the one catalogue model that is not the provider's own line, and it is labelled as a private deployment everywhere it appears.

The model id is case-sensitive. Send it exactly as `GLM-5.3-Abliterated`. An id in the wrong case is not in the catalogue, and the relay answers 403 with the message "Model is not offered by this service".

## Route and endpoint

The model is sold on one route only, shown on the **API keys** page as **GLM** with the line name **private deployment** (route id `z-official`). There is no shared pool behind it, so a request on this route goes only to its dedicated upstream. An **Auto route** key dispatches the model to the same place.

The only endpoint is `POST /v1/chat/completions`:

```bash
curl https://ai.topxea.com/v1/chat/completions \
  -H "content-type: application/json" \
  -H "Authorization: Bearer sk-xxxx" \
  -d '{"model":"GLM-5.3-Abliterated","messages":[{"role":"user","content":"Say hello in one sentence."}]}'
```

The `model` field of the response says `GLM-5.3-Abliterated`, not the upstream's internal id. The same holds when you stream: every chunk, and the final chunk that carries `usage`, names the catalogue model.

## Text only

This deployment takes text and tool calls only. If a message carries an image, audio, file or video part, the relay does not fail the request with a 400. It replaces each such part with one text part that reads:

```text
[Attachment omitted: this model accepts text only.]
```

The rest of the message is forwarded as sent, and the model sees the note in its context. Some clients send a small test image with their "add model" probe; with this rewrite the probe still passes. The rewrite is wired into `/v1/chat/completions` only, one more reason to send this model through that endpoint.

The relay also drops, for every model but relevant here because this upstream rejects them, a `tool_choice` with no tools and empty containers such as `"tools": []`, `"logit_bias": {}` or `"stop": []`. Real tools, biases and stop sequences are forwarded untouched.

## Price

Per 1M tokens on the private deployment: input $4.00, output $7.00, cache read $0.40. That is above the Z.ai list price of the base GLM-5.3 (input $1.40, output $4.40, cache read $0.26, verified 2026-09-18). On the home page price list that reference row is labelled **Provider list price · GLM-5.3**, with the percentage above list next to each lane; the source is https://docs.z.ai/guides/overview/pricing.

## Compliance notice

This notice appears in small print wherever the model is described, and it applies to every request:

Because fine-tuning may affect safety alignment, the model may produce biased, offensive or locally unlawful content. Users bear full responsibility for compliance and legal consequences.

The AI Acceptable Use Policy covers this line exactly as it covers Claude, OpenAI, Grok, Kimi and Jev. Removing the refusal alignment does not remove the policy. If you are unsure whether a use case is allowed, ask through the help button at the bottom right or support@topxea.com before building on it.

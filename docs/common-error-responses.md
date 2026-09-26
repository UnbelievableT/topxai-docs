# Common error responses

> What each HTTP status and error code from the gateway means, and what to change before you retry.

This page is also published at https://ai.topxea.com/docs/common-error-responses (English and Chinese).

Errors share one shape. OpenAI-style endpoints return `{"error":{"message":"...","type":"...","code":"...","param":null}}`; `/v1/messages` returns `{"type":"error","error":{"type":"...","message":"..."}}`. The message ends with `(request id: ...)`; the `x-request-id` response header carries the same id. Mid-stream, the status is already 200: the error is one `data: {"error":...}` event (`event: error` first on `/v1/messages`) and the stream ends without `[DONE]`. A `/v1/responses` stream that has started ends with `response.failed` instead when it breaks off or fails (see the last two sections). Support needs that id; prompts and responses are not stored.

## 401 authentication_error

Message: `Invalid token`. The key is missing, in the wrong header, disabled, expired, or its own **Quota (USD)** is spent to zero (a key with some quota left, but less than the request's estimate, gets a 402 instead). A 401 is about your key; failed upstream credentials surface as `upstream_unavailable`. Send it as `Authorization: Bearer sk-...`.

## 403 permission_denied

The message names the check:

- `Model is not offered by this service`: unknown id or wrong case (`GLM-5.3-Abliterated`, not `glm-5.3-abliterated`).
- `Model is not available on this API key route`: the key's **Group** does not sell this model; create a key on **Auto route**.
- `This token has no access to model ...`: the key's **Model limits** exclude it.
- `The service is not available in your region.` or `Your service region could not be verified. Please contact support.`: regional access controls (code `region_unavailable`, no request id).

## 402 insufficient_quota

Message: `Insufficient quota. Top up your balance and try again.` The gateway first reserves the prompt plus the output you allow (`max_tokens`, `max_completion_tokens` or `max_output_tokens`; 8192 when unset) against your balance and the key's **Quota (USD)**, then settles on real usage. A positive balance means the reserve exceeded one of them: lower `max_tokens`, raise the key's quota, or use **Add credit** on **Wallet**.

## 429 rate_limited

The gateway's per-account limit (all your keys together) answers `Request limit reached: successful requests are limited to M per N-minute window`, or, counting failures too, `Total request limit reached: requests are limited to M per N-minute window, failed requests included. Check that your requests are correct`. The message follows your `Accept-Language` header (English, Chinese, Japanese, Russian or Spanish); without the header it uses the language saved on your account, and English when none is saved. A provider limit returns `Rate limit exceeded. Please retry after a short delay.` Wait the `Retry-After` seconds when present.

## 400 invalid_request

A provider rejection is returned as `The request was rejected. Check the parameters and try again.`, never the provider's text. Gateway checks keep their message, such as `duration must be between 1 and 15 seconds`. A safety refusal is `content_filtered`. On `/v1/chat/completions`, [GLM-5.3-Abliterated](https://ai.topxea.com/pricing/glm-5.3-abliterated) does not reject images: each attachment becomes `[Attachment omitted: this model accepts text only.]` and the text is forwarded.

## 404 and 5xx

An upstream 404 is `model_not_found`; `internal_error` is 500. `upstream_unavailable` is 502, or 503 for provider overload or no channel able to serve the model; `upstream_timeout` is 504. The gateway retried another channel where it could. A failed request is refunded to your balance (a stream that broke off or failed after producing output is charged for that output, see below); **Billing refunds** lists only later corrections, not this. Video differs: the fee is taken when the provider accepts the job; polling a failed, expired or shorter clip refunds it in full or pro rata, and that refund is listed there.

## stream_interrupted

The provider's stream broke off or went silent before the answer was complete. You get the text that arrived, then one error instead of the normal end (`[DONE]`, `message_stop` or `response.completed`): code `stream_interrupted` with type `upstream_error` on OpenAI-style endpoints, type `api_error` on `/v1/messages`. A `/v1/responses` stream ends with `response.failed`, whose `error.code` is `server_error` with the same message. The OpenAI and Anthropic SDKs raise an exception on this event. The text you already have is incomplete: retry the request. If the break came before anything reached you, the gateway first tries another attempt and, failing that, answers HTTP 502 with this code. A connection lost after the provider had finished its answer is a normal end.

Output produced before the break is charged once, on the provider's reported usage or, without one, on the counted text. A stream that produced no output is refunded and listed as a failed request, and so is a request you cancel before the first token. Cancel mid-answer and the output generated so far is charged.

## An error partway through an answer

When the provider reports an error after part of the answer has streamed, you get the text that arrived, then the error as one event in the shape above, with its usual code (for example `upstream_unavailable`) and no normal end. A `/v1/responses` stream ends with `response.failed`, `error.code` `server_error`, carrying that message, also when the error comes before any text. Retry the request: the answer is incomplete.

Billing is the same as for a stream that broke off: the output produced before the error is charged once, and an error before any output is refunded and listed as a failed request. A retry never adds a second charge. One exception: a request Grok rejects on its child-safety check is refunded and charged the separate violation fee, even when the rejection arrives partway through the answer.

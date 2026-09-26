# How requests are billed

> Billing units, long-context tiers, the up-front reservation and what happens to it when a request fails.

This page is also published at https://ai.topxea.com/docs/how-requests-are-billed (English and Chinese).

Every request is priced from one fixed USD tariff: the model on your key's route, as on the **Models** page (**Auto route** keys pay the route picked per request). The tariff is captured before forwarding; later price edits never touch a request in flight. A model with no price on your route is refused with HTTP 400 `invalid_request`, "model ... has no configured USD price for this [API key](create-an-api-key-and-choose-a-route.md) route".

## Units

Text models bill per million tokens, one price per lane: input, output, cache read and cache write (Claude also prices a 1-hour cache write). Cached tokens are not regular input; a lane with no price of its own bills as input. [Jev](jev-typesafe-system-one.md) bills input only, output $0.

Image models bill per image: `1k` (up to 1024x1024) or `2k` (up to 2048x2048). An omitted or `auto` size is pinned to 1024x1024; a larger output than requested settles at its class. Both `gpt-image-2.5-*` models cost $0.03 per 1K image and $0.05 per 2K, times `n`.

`grok-imagine-video-1.5` bills per second: $0.05 at 480p (default), $0.10 at 720p, $0.20 at 1080p, for 1 to 15 seconds (default 8).

## Long-context tiers

OpenAI and Grok models carry a long-prompt tariff: once total input context (prompt plus cache tokens) reaches 272,001 tokens (`gpt-6-astra`, `gpt-6-sol`) or 200,000 tokens (`grok-4.7`), the whole request settles at the long lanes, not just the excess. Claude, Kimi, GLM and Jev have no tier; the tier is decided at settlement.

## Peak hours

DeepSeek models (`deepseek-flash`, `deepseek-v4-pro`) carry two complete tariffs. The peak tariff applies to a request accepted during the provider's peak hours: 09:00-12:00 and 14:00-18:00 Beijing time (01:00-04:00 and 06:00-10:00 UTC; the pricing pages show these windows in your own time zone), Monday to Friday, except Chinese public holidays; every other hour, weekends and public holidays are off-peak, at half the peak rates. The tier is frozen when the relay accepts the request, so a long stream that crosses the boundary keeps the tier it was quoted. The usage-log row says which tier applied and the billing details show the lanes that were charged.

## Reservation and settlement

Each request first reserves an estimate at that tariff: prompt tokens plus your output cap (`max_tokens`, `max_completion_tokens` on Chat Completions, `max_output_tokens` on the Responses API; 8,192 when unset). Without a cap the model may still write up to its output limit; the reserve stays at 8,192 and settlement charges what it wrote. Image and video reserve the whole job: per-image fee times `n`, or per-second fee times duration. If balance or key quota cannot cover the estimate, the request is refused with HTTP 402 before forwarding:

```json
{
  "error": {
    "message": "Insufficient quota. Top up your balance and try again. (request id: ...)",
    "type": "insufficient_quota",
    "code": "insufficient_quota",
    "param": null
  }
}
```

On `/v1/messages` the body is `{"type":"error","error":{"type":"billing_error","message":"..."}}`.

At the end, actual usage is priced and the difference credited back, or the extra charged if usage exceeded the estimate. An abandoned reservation is refunded when its 5-minute lease expires.

An upstream failure releases the whole reservation and logs an error row with no charge; the relay retries once on another channel, charging only the final attempt. A stream that has already produced output is different: if it breaks off, or the provider sends an error partway through, the output produced so far is charged once, on the provider's reported usage or the counted text plus the estimated prompt, and the rest of the reservation is released ([what your client receives](common-error-responses.md)). Other exceptions: image, video and Jev (`/v1/systemone`) requests keep running up to 4 minutes after your client disconnects and are settled, not refunded, because the provider bills an accepted job. A video that fails, expires or comes back shorter is refunded afterwards (in full, or the missing seconds) as a **Refund** row. A request Grok rejects on its child-safety check is refunded, then charged a separate $0.05 fee in its own row marked **Violation Fee**, also when the rejection arrives partway through a stream.

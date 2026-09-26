# Image generation

> gpt-image-2.5-sunburst and -flare: the two endpoints, the 1K and 2K per-image prices, how the size tier is chosen, and where the image link comes from.

This page is also published at https://ai.topxea.com/docs/image-generation (English and Chinese).

Two image models are in the catalogue, both from OpenAI's GPT Image 2.5 family and both sold per image:

- `gpt-image-2.5-sunburst`: the highest-fidelity model for generation and editing.
- `gpt-image-2.5-flare`: the faster one, same endpoints and same prices.

`gpt-image-2` was retired on 2026-09-18 in favour of these two.

## Route and endpoints

Image models are sold on one route, shown on the **API keys** page as **OpenAI** with the line name **Image generation** (route id `image`). An **Auto route** key sends them there as well.

Two endpoints, both with `Authorization: Bearer <key>`:

- `POST /v1/images/generations` (JSON body)
- `POST /v1/images/edits` (multipart form with the source image)

`POST /v1/images/variations` is not implemented and answers 501 with "This API is not implemented".

```bash
curl https://ai.topxea.com/v1/images/generations \
  -H "content-type: application/json" \
  -H "Authorization: Bearer sk-xxxx" \
  -d '{"model":"gpt-image-2.5-flare","prompt":"A lighthouse at dawn, watercolour","size":"1024x1024","n":1}'
```

## Price and size tiers

Both models: $0.03 per 1K image, $0.05 per 2K image. The tier is chosen from the pixel count of the `size` you request, written as `WIDTHxHEIGHT` with a plain `x`:

- up to 1024x1024 pixels (1,048,576) is 1K;
- up to 2048x2048 pixels (4,194,304) is 2K;
- anything larger, or an edge above 4096, is refused before the request is forwarded.

An omitted `size` or `"size": "auto"` is pinned to `1024x1024` before pricing and forwarding, so the provider cannot render a larger image than the one you are billed for. If the provider still reports an output size of a higher tier, the fee is raised to that tier; a smaller output keeps the quoted fee. `quality` is validated but does not change the fee; only the `size` tier does.

`n` may be 1 to 128 and multiplies the fee. The full amount (fee times `n`) is reserved from your wallet before the request is forwarded, so a large `n` needs that balance up front. On settlement the count is taken from the number of images actually returned, with one exception: a `stream: true` request whose client disconnects before the stream ends is billed for the requested `n`, so dropping after the first completed image does not buy one image.

The priced fields `model`, `size`, `n` and `quality` are accepted once each, in their exact spelling; `Size` is refused, and a multipart form that repeats one of them is refused. The messages you will meet:

- `n must be an integer between 1 and 128`
- `field "Size" is not accepted; use "size"`
- `field "size" must be provided once`
- `unsupported image size "<size>"`
- `image size "<size>" exceeds the largest sold class (2K)`

A size written with the multiplication sign `×` is refused with a message asking for a plain `x`.

An accepted image request is settled even if your client disconnects while waiting, because the provider bills the job whatever the client does.

## Where the image link comes from

Every `url` in the response is replaced by a link on this relay:

```json
{
  "data": [{ "url": "https://ai.topxea.com/v1/images/content/<token>" }]
}
```

The token is an encrypted, signed claim that hides the supplier's storage address and credentials. You can put the link straight into an `<img>` tag: fetching it needs no [API key](create-an-api-key-and-choose-a-route.md). It expires one hour after the response was issued; after that the link answers 404 with the code `image_unavailable` and the message "Generated image is unavailable or the link has expired". Download the file within the hour if you need to keep it. Base64 payloads (`b64_json`) are passed through unchanged.

Three limits on fetching the link. The relay fetches at most 4 generated images at a time across the whole site; a fifth simultaneous fetch gets the same 404 `image_unavailable` and should be retried, which a page with many `<img>` tags can trigger. Only `image/png`, `image/jpeg`, `image/webp` and `image/gif` are served (sniffed from the bytes; anything else is a 404), with `Cache-Control: private, max-age=300`. A single fetched image is limited to 32 MiB.

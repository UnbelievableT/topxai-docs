# Video generation

> grok-imagine-video-1.5: submit a job, poll it, per-second prices by resolution, refunds on failure, and how forgotten jobs are refunded after 24 hours.

This page is also published at https://ai.topxea.com/docs/video-generation (English and Chinese).

`grok-imagine-video-1.5` is xAI's text-to-video and image-to-video model, the only video model in the catalogue. It is billed per second of video, by resolution.

## Route and endpoints

Sold only on the Grok official line, shown on the **API keys** page as **Grok**, line **official line** (route id `grok-official`). An **Auto route** key sends it there too. All calls use `Authorization: Bearer <key>`.

- `POST /v1/videos/generations` submits a job.
- `GET /v1/videos/{request_id}` returns the job's status.
- `GET /v1/videos/{request_id}/content` streams the finished clip.

Both GET endpoints go straight to the channel that accepted the job, so any valid key of the same account can poll; it need not be on the `grok-official` route.

## Submitting a job

```bash
curl https://ai.topxea.com/v1/videos/generations \
  -H "content-type: application/json" \
  -H "Authorization: Bearer sk-xxxx" \
  -d '{"model":"grok-imagine-video-1.5","prompt":"A paper boat drifting down a rain gutter","duration":8,"resolution":"720p"}'
```

`duration` is 1 to 15 seconds (default 8). `resolution` is `480p`, `720p` or `1080p` (default `480p`). `model`, `duration` and `resolution` decide the price, so each is accepted once, in that exact spelling, and the validated values are written into the forwarded body. Other fields (`image` and `reference_images` for image-to-video, `generate_audio`, `aspect_ratio`) pass through as sent; their shape is xAI's request schema.

A failed validation is a 400 with one of these messages:

- `duration must be between 1 and 15 seconds`
- `resolution must be one of 480p, 720p or 1080p`
- `field "Duration" is not accepted; use "duration"`
- `field "duration" must be provided once`

The reply carries the provider's `request_id` and the model name. Keep the id: both GET endpoints need it, and only the account that created the job can use it. An unknown id, or another account's id, answers 404 with "video job not found".

## Price

Per second of requested video:

- $0.05 at 480p
- $0.10 at 720p
- $0.20 at 1080p

The 8-second request above costs 8 x $0.10 = $0.80. The home page price list shows xAI's published $0.08 per second beside these in a row labelled **Provider list price**, with the difference per resolution.

The whole fee (requested seconds times the per-second price) is charged the moment the provider accepts the job. The provider bills an accepted job whether or not your client stays connected, so disconnecting does not cancel the charge. The charge appears on the **Usage logs** page with the resolution and the seconds.

## Polling and refunds

Poll `GET /v1/videos/{request_id}`. The status document comes back as the provider sent it. `pending`, `queued`, `processing`, `running` and `in_progress` mean keep polling; `done`, `failed` and `expired` are final. The relay reads `video.url` and `video.duration` from a `done` document when they are present.

The first poll that sees a final status settles the job; later polls do not settle it again:

- `failed` or `expired`: the whole fee is refunded.
- `done` with a `video.duration` shorter than requested: each whole undelivered second is refunded at the same per-second price. A fraction of a second counts as a full second, and a `done` document without `video.duration` is treated as fully delivered. The credit never exceeds the fee that was actually charged.

A refund is a row of type **Refund** on the **Usage logs** page, and the **Billing refunds** stat at the top sums them.

If you stop polling, a background reconciler checks pending jobs for you, from ten minutes after submission and at least five minutes apart. When the provider no longer knows a job (it answers 404) and the job is over 24 hours old, the reconciler refunds it as expired. A 404 that you meet while polling yourself only returns a normalized error and refunds nothing; leave that job to the reconciler instead of retrying.

Polls count like any other request against the request rate limit when one is enabled, so a tight loop can get 429 `rate_limited`. Leave a gap between polls.

## Fetching the clip

When the finished clip is served as a path under `/v1/videos`, fetch it through `GET /v1/videos/{request_id}/content` with your key. The relay fetches it from the channel that ran the job and forwards it to you, passes `Range` through, and returns the provider's 206 with its `Content-Range` and `Accept-Ranges`. The response carries `Content-Disposition: inline; filename="<request_id>.mp4"` and `Cache-Control: private, max-age=600`. One file is capped at 512 MB; a larger one answers 502 with "The video file is larger than this relay serves". It arrives as `video/mp4` unless the provider says otherwise. If the channel that took the job has been disabled, both GET endpoints answer 503 with "The channel that created this video job is unavailable".

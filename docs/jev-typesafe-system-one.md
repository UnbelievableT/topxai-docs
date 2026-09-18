# Jev (TypeSafe System One)

> What Jev returns, how to call POST /v1/systemone, the one-line setup under a TypeSafe official-line key, and what it costs.

This page is also published at https://ai.topxea.com/docs/jev-typesafe-system-one (English and Chinese).

Jev is TypeSafe's System One model. It does not write text: you send a `state` and a map of typed questions, it returns typed answers with probabilities. The catalogue id is `jev-1.13.0`; `jev-latest` and `jev-preview` are aliases, forwarded unchanged and billed as `jev-1.13.0`. The aliases move when TypeSafe releases a new version, so pin `jev-1.13.0` once you have tuned thresholds. The response's `model` field says which model answered.

## The three question types

- `noul`: a yes/no question. The answer is the probability of yes: near 1 yes, near 0 no, near 0.5 undecided. There is no separate confidence.
- `choice`: one option from a map you define, up to 255. The answer carries `choice`, `confidence` and `probabilities` over every option.
- `score`: a position on an ordered scale of 2 to 10 levels you describe in words; probability-weighted, so it can fall between levels. The answer carries `score`, `confidence`, `legend` and `probabilities`.

Questions in one request are independent and run in parallel, so put every question you might need into one call. The question id is never sent to the model; write the whole question in `instructions`.

## Request and response

```bash
curl -X POST https://ai.topxea.com/v1/systemone \
  -H "Authorization: Bearer sk-xxxx" \
  -H "Content-Type: application/json" \
  -d '{
    "state": "I have asked three times now. Can I please just talk to a real person?",
    "model": "jev-latest",
    "questions": {
      "is_human_escalation": {
        "type": "noul",
        "instructions": "Is the customer asking for a human agent?"
      }
    }
  }'
```

```json
{
  "model": "jev-latest",
  "answers": {
    "is_human_escalation": { "type": "noul", "noul": 0.99 }
  }
}
```

The response also carries `usage` (`input_tokens`, `output_tokens`). The body is identical to TypeSafe's own API; only the base URL and key are TopxAI's. `POST /v1/system_one` is accepted as a second spelling of the same endpoint and goes to the same upstream. Any other model on this endpoint gets a 400.

Before any quota is reserved, the relay checks the body itself: at most 1 MiB, with `model`, `state` and a non-empty `questions` object; anything else is a 400. If TypeSafe rejects the request with a 422, you get its validation detail as written and the reservation is released. A 429 is passed on with its `Retry-After`; back off and retry. A provider outage or a rejected upstream key comes back as a 503.

## One-line setup

Create a key on the **API keys** page. Under **Group**, pick **Official line** in the **TypeSafe** section (its note reads **Official key · 107% of list price**). An **Auto route** key can call Jev too, since Jev has only one line, but the setup command below is shown only for keys on the TypeSafe line. Open the full-key popover in the key's row, or the key detail drawer, and look for **One-command setup for Jev**:

```bash
curl -fsSL https://ai.topxea.com/install/typesafe.sh | sh -s -- --key sk-xxxx
```

The script installs the `typesafe-ai` agent skill, writes `TYPESAFE_BASE_URL=https://ai.topxea.com` and `TYPESAFE_API_KEY=<your key>` to `~/.config/topxai/typesafe.env`, adds a block to `~/.zshrc` and `~/.bashrc` (whichever exist) that sources that file, and merges the same two variables into the `env` of `~/.claude/settings.json` when that file exists. Then it sends one test request: a real, billed call to `jev-latest` with one noul question. A 401 means the key was rejected.

Leave out `--key` and the script takes `TOPXAI_API_KEY` from the environment, then the key saved by an earlier run, and only then asks for the key in the terminal without echo. With no key at all it still installs the skill and writes the config, and skips the test. `--no-skill` and `--no-verify` skip those two steps, `--base-url` points at another relay origin, `-h` prints the help. Running it again is safe: every file it touches is rewritten in place, and `settings.json` gets a timestamped `.bak` copy first.

The official SDKs (`pip install typesafe-sdk`, `npm install @typesafe-ai/sdk`) read `TYPESAFE_BASE_URL` and `TYPESAFE_API_KEY` and call `/v1/systemone` themselves; `TYPESAFE_DEFAULT_MODEL` picks the model.

## Price and limits

$0.04494 per 1M input tokens, 107% of TypeSafe's list price of $0.042. Output tokens are free. The charge is settled from the provider's `usage.input_tokens`; if a response carries no usage, the estimate reserved before the call is charged. Limits: a 64K context window, 64k tokens per request, 32k for `state` plus the longest question.

## Known weak spots

From TypeSafe's own docs:

- It answers the question you wrote, not the one you meant.
- It is not a calculator, and it reads dates as text.
- Double negatives, multi-hop questions and irrelevant state cost accuracy.
- Contradictory criteria make answers unreliable.
- It is not trained to generate text.
- Text only; CJK input is handled "but not equally well".
- Do not reuse a threshold across question types.

Questions? Use the help button at the bottom right of the site or write to support@topxea.com.

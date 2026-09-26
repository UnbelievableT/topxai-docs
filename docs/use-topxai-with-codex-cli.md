# Codex CLI with TopxAI: download, install and connect

> Install the Codex CLI through an npm mirror when GitHub and npm are out of reach, connect it to TopxAI with one command, and run gpt-6-sol or grok-4.7.

This page is also published at https://ai.topxea.com/docs/use-topxai-with-codex-cli (English and Chinese).

Codex CLI is OpenAI's coding agent for the terminal. It speaks the OpenAI Responses API, which TopxAI serves at `https://ai.topxea.com/v1/responses` for the GPT models and `grok-4.7`. This page covers the whole path: where to get Codex when GitHub and npm are out of reach, the one command that installs and connects it, what that command changes, and how to do the same by hand.

## Where to get Codex

Codex is published in three places: the [GitHub releases](https://github.com/openai/codex/releases) (one archive per system), npm (`npm install -g @openai/codex`) and Homebrew (`brew install codex`). When those are slow or blocked from your network, the [downloads page](https://ai.topxea.com/downloads) lists the same npm packages through the mirror run by Alibaba Cloud (registry.npmmirror.com): every file is the official package for one system, unchanged, with the integrity value npm records for it. Pick the row marked "for this computer", or check by hand:

- macOS: Apple menu, About This Mac. An Apple M-series chip means Apple silicon; "Intel" means Intel.
- Windows: Settings, System, About; "System type" names x64 or ARM64.
- Linux: `uname -m` prints `x86_64` or `aarch64`.

A package is a `.tgz` with the `codex` binary under `package/vendor/<target>/bin/` and its helper programs beside it. The installer below does the unpacking and the PATH work for you; with Node.js installed, `npm install -g @openai/codex --registry=https://registry.npmmirror.com` is the other way through the mirror.

## Install in one command

macOS and Linux, in a terminal:

```bash
curl -fsSL https://ai.topxea.com/install/codex.sh | sh -s -- --key sk-...
```

Windows, in PowerShell:

```powershell
$env:TOPXAI_API_KEY = "sk-..."; irm https://ai.topxea.com/install/codex.ps1 | iex
```

`sk-...` is a TopxAI key on the OpenAI, Grok or Auto route from the [API keys page](https://ai.topxea.com/keys). Leave the key out and the script asks for it without echo, so it never lands in your shell history. Signed in, the [downloads page](https://ai.topxea.com/downloads) fills the command with one of your own keys.

Then open a new terminal and run `codex`.

## What the script changes

The script only touches these places, and running it again is safe: it replaces the binary and rewrites only its own lines.

1. It downloads the current Codex package for your system through the npm mirror (the newest release the mirror has for that system) and checks npm's integrity value before anything is installed. `--version 0.155.1` picks another version.
2. It unpacks the package into `~/.local/lib/codex` and links `~/.local/bin/codex` to the binary, putting that folder on PATH through a marked block in `~/.zshrc` and `~/.bashrc` (Windows: the package goes to `%LOCALAPPDATA%\Programs\codex` and the folder holding `codex.exe` goes on the user PATH). Pass `--config-only` to keep a Codex you installed from npm or Homebrew and only write the configuration.
3. It writes `~/.codex/config.toml`: `model = "gpt-6-sol"`, `model_provider = "topxai"` and a `[model_providers.topxai]` table. Anything else already in the file is kept, and the previous file is saved as `config.toml.bak.<timestamp>`.
4. It stores the key in `~/.codex/topxai.env` (mode 0600), exported by the same shell block as `TOPXAI_API_KEY`; on Windows it becomes a user environment variable.
5. It calls `GET /v1/models` with the key and reports whether `gpt-6-sol` is on the key's route.

Options: `--model gpt-6-astra` for another default model, `--no-verify` to skip the last request, `--base-url` for a self-hosted relay, `--bin-dir` for another install folder. `sh -s -- --help` prints them all.

## Set up by hand

If Codex is already installed, the whole configuration is one provider block in `~/.codex/config.toml`. It must be the user-level file: Codex ignores `model_provider` in a project's `.codex/config.toml`.

```toml
model = "gpt-6-sol"
model_provider = "topxai"

[model_providers.topxai]
name = "TopxAI"
base_url = "https://ai.topxea.com/v1"
env_key = "TOPXAI_API_KEY"
wire_api = "responses"
```

Then export the key and start Codex:

```bash
export TOPXAI_API_KEY=sk-...   # a TopxAI key on the OpenAI, Grok or Auto route
codex
```

`wire_api = "responses"` is the default and the only value current Codex releases accept; it is written out so nobody wonders. `base_url` is the origin with `/v1`; Codex appends `/responses`. `env_key` names the environment variable Codex reads the key from, so the variable has to be set in the shell that starts Codex: put the `export` line in `~/.zshrc` or `~/.bashrc`, or on Windows set `TOPXAI_API_KEY` as a user environment variable. If Codex is started by an application that does not inherit your shell, Codex also accepts the key in the file itself as `experimental_bearer_token = "sk-..."` in the same table, instead of `env_key`.

The IDE extension for VS Code reads the same `~/.codex/config.toml`, so the provider applies there too as long as the editor sees the variable.

## Models

- `gpt-6-sol` and `gpt-6-astra`: the OpenAI line, on the [shared pool](shared-pool-official-line-and-auto-route.md) (50% of list) or the official line (90%).
- `grok-4.7`: the only non-OpenAI model on the Responses endpoint.
- Claude, GLM, Kimi, DeepSeek and [Jev](jev-typesafe-system-one.md) are not reachable through Codex, because Codex only speaks Responses.

Switch models with `codex -m gpt-6-astra` or by editing `model`. Reasoning effort is set with `model_reasoning_effort`; TopxAI forwards it unchanged.

## Update and uninstall

Run the install command again: it fetches the current package and keeps your configuration and key. To remove Codex, delete `~/.local/bin/codex` and `~/.local/lib/codex` (Windows: the `%LOCALAPPDATA%\Programs\codex` folder and its PATH entry), the block between `# >>> topxai codex >>>` and `# <<< topxai codex <<<` in your shell file, and `~/.codex` if you want the configuration and the key gone too.

## Long context

Once the input of a GPT-6 Sol request passes 272K tokens (cached tokens included), the whole request bills at the long-context rates: input and cache prices double and output rises by half. GPT-6 Astra has the same 272K tier. See the [model page](https://ai.topxea.com/pricing/gpt-6-sol) for both tiers. Codex compacts long sessions automatically.

## If it fails

- `codex: command not found` right after installing: the shell has not read the new PATH yet. Open a new terminal, or run `. ~/.zshrc` (or `. ~/.bashrc`).
- Codex says `TOPXAI_API_KEY` is not set: same cause, the new shell block has not been read; or the key was skipped. Run the install command again with `--key`.
- The download fails or the integrity value does not match: the connection dropped. Run the command again; each run starts the download over.
- 401: the key is wrong or was pasted with a space. 402: the balance is empty. 403: the model id is not sold here or is not on this key's route. See [Common error responses](common-error-responses.md).
- The model works in curl but not in the tool: [that page](the-model-works-in-curl-but-not-in-my-tool.md) lists the usual causes, one per tool.

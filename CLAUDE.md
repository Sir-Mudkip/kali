# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

This repo builds a **Kali Linux container image** (not application code) packed with offensive-security tooling for on-network and Active Directory work. It is rebuilt monthly and published to `ghcr.io/sir-mudkip/kali-base`. The container boots with a standard shell (`CMD /bin/bash`). It is meant to be run with `--privileged --network host` for raw network access and shell catching.

**No cloud tooling.** This image deliberately ships **no** cloud-pentest/cloud-audit tools (AWS/Azure/GCP/OCI CLIs, kubectl/krew, prowler, scoutsuite, pacu, cloudfox, kics, snotra_*, etc.). Cloud tooling is reserved for a separate fork — do not add it here.

## Commands

Uses `just` (see `Justfile`) and `podman` (not docker for the build itself):

- `just build` — build the image locally (`podman build`, tags `kali:latest`). Adds `SHA_HEAD_SHORT` build-arg only when the git tree is clean.
- `just lint` — `shellcheck` on all `*.sh`.
- `just format` — `shfmt --write` on all `*.sh`.

There is no test suite; "does it build" is the test. CI (`.github/workflows/build-image.yml`) does `podman build` → `podman push` → `cosign sign` on push/PR/schedule (PRs build but don't push/sign). Signing is **keyless cosign** via GitHub Actions OIDC (`id-token: write`); there is no managed key or committed public key.

## Build architecture

`Containerfile` is a **two-stage build**. A first `builder` stage runs `build/00-go-installs.sh` to compile the Go tools (`brutespray`, `gowitness`, `wpprobe`, `gobuster`, `nuclei`) and John the Ripper. The final stage then `COPY --from=builder` only the resulting binaries (`/usr/local/bin/*`, `/opt/john-the-ripper`), so the `golang` toolchain and build leftovers never ship. The builder uses the **same** `kali-rolling` base as the final image, so John links against identical runtime libraries.

The final stage copies `config/` into the image, copies `build/` to `/build`, then runs the four build scripts **in order**, each with `cache`/`tmpfs` mounts:

1. `build/10-tools.sh` — `apt` installs everything in the inline `PACKAGES=(...)` array.
2. `build/20-manual-installs.sh` — the bulk of the image: tools not in apt, installed from GitHub releases, `git clone`, `pip`, `gem`, etc. **Add new non-apt tools here.**
3. `build/30-config.sh` — locale, login, and readline tweaks; runs the neovim plugin install.
4. `build/40-wordlists.sh` — extra wordlists and seclists massaging.

`config/` (bashrc, bashrc.d/, tmux.conf, tmux/, nvim/, bash-color-prompt.sh) is vendored **inline in the repo** (no git submodule) and baked into `/root`. `config/bashrc.d/aliases` is copied to `/root/.bashrc.d/` and holds the nmap/util shell functions; `.bashrc` sources every file in `~/.bashrc.d/` — including the per-tool `.rc` files written during the build. `build/30-config.sh` runs `~/.config/nvim/install-plugins.sh` to clone the neovim plugins.

## Tool install conventions (follow these when adding tools in 20-manual-installs.sh)

**Python tools — which path depends on whether the tool is a pip-installable package** (ships a `setup.py`/`pyproject.toml` with console entry points):

- **Packaged tool → `pipx`.** Use `pipx install <pypi-name>` for PyPI packages, or `pipx install git+https://github.com/<owner>/<repo>` to track the latest from git (preferred when the old code did `git clone` + `pip install ./repo`). pipx puts each tool in its own isolated venv and exposes its commands in `~/.local/bin`, which `.bashrc` already has on PATH. Extra deps go in with `pipx inject <tool> <dep>`. Note pipx refuses packages that expose no console scripts of their own — install the package that actually ships the command. Do **not** create `/opt/<tool>/venv` for these. Examples on this path: `netexec`, `pre2k`, `pywhisker`, `bloodyAD`, `adidnsdump`, `powerhub`.
- **Run-as-script tool → `/opt/<tool>/venv` + alias.** Tools that only have a `requirements.txt` (no entry points) can't be pipx-installed. Keep the legacy pattern: `git clone` to `/opt/<tool>`, `python3 -m venv /opt/<tool>/venv`, `pip install -r requirements.txt`, then drop an alias: `echo "alias <name>=\"/opt/<tool>/venv/bin/python /opt/<tool>/<script>.py\"" > /root/.bashrc.d/<name>.rc`. The `.rc` files in `/root/.bashrc.d/` are auto-sourced by `.bashrc`. Examples on this path: `sccmhunter`, `eavesarp`, `dnscan`, `targetedKerberoast`, `privexchange`, `jwt_tool`, `PCredz`, `krbrelayx`, `sapito`, `sharefiltrator`.

`impacket` is `pipx install`ed; pipx automatically exposes its example scripts on PATH in `~/.local/bin` **keeping** the `.py` suffix (so you invoke `secretsdump.py`, `wmiexec.py`, etc. — making it obvious you're running the impacket python scripts). No symlink loop is needed.

Compiled tools (`brutespray`, `gowitness`, `wpprobe`, `gobuster`, `nuclei`, John) are built in the **builder stage** (`build/00-go-installs.sh`) and pulled in via `COPY --from=builder` — add new Go/compiled tools there, not in `20-manual-installs.sh`, so the toolchain stays out of the final image. When you move a tool here, remember to add the matching `COPY --from=builder` line in the Containerfile and drop any duplicate apt/release install from the final stage. Prebuilt release binaries: `wget`/`curl` to `/opt`, `install` into `/usr/local/bin`, then remove the download.

Keep cleanup inline (remove tarballs/zip/clone leftovers after install) since each build script runs as one cached layer.


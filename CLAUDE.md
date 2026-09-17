# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) and other
agents when working with code in this repository.

## What this is

This repo builds a **Kali Linux container image** (not application code)
packed with offensive-security tooling for on-network and Active Directory
work. It is rebuilt weekly and published to `ghcr.io/sir-mudkip/kali-base`.
The container boots with a standard shell (`CMD /bin/bash`) and is meant to
be run with `--privileged --network host`.

**No cloud tooling.** This image deliberately ships **no**
cloud-pentest/cloud-audit tools. Cloud tooling is reserved for the separate
`kali-cloud` fork — do not add it here.

## Read the docs before changing the build

Full reference documentation lives in [`docs/`](docs/). Read the relevant
doc before making changes — it exists so there is no ambiguity about how
this image is put together:

- **[docs/architecture.md](docs/architecture.md)** — the two-stage
  `Containerfile`, the ordered build-script pipeline (`10`/`20`/`30`/`40`),
  the builder stage (`00-go-installs.sh`), and how `config/` is baked in.
- **[docs/adding-tools.md](docs/adding-tools.md)** — the decision tree for
  adding a tool (apt / pipx / venv+alias / Go builder), and the `ghcurl`
  version-pinning helper. **Read this before adding any tool.**
- **[docs/ci-cd.md](docs/ci-cd.md)** — the build → rechunk → push → sign
  pipeline, image retention, and `just chunk`.

Local commands: `just build`, `just chunk`, `just lint`, `just format`.
There is no test suite — "does it build" is the test.

## Rules to follow

- **Leave the machine clean.** Treat the host like you're a guest, not the
  owner: track any scripts you create or tools/images you pull down, and
  remove them once you're done. The machine should end a session in the
  same state it started in. Container images you pull get removed; scratch
  files you create get cleaned up.
- **Never delete personal files.** Files outside this repo's working
  directory are off-limits for deletion unless you've been explicitly told
  to remove them.

# Obsidian Workspace Git Layout

This workspace is git-managed at the root to track config and orchestration files, while each vault is managed by its own repo. The goal is to keep note content and code repos separate and avoid cloud-sync issues.

Repos
-----
- Root (this directory): tracks plan files, configs, symlinks, docs for the workspace.
- knowledge-vault/: separate repo for the main Obsidian vault (ignored by root).
- research-vault/: separate repo for the research vault (ignored by root).

Symlinks
--------
- projects -> /Users/tennigo/dev/projects (code lives locally; cloudはリンクのみ)
- mcp-servers.json, package.json, pnpm-lock.yaml, pyproject.toml, uv.lock -> /Users/tennigo/dev/

Rules of thumb
--------------
- Do installs/builds in `/Users/tennigo/dev/projects/**`, not inside vaults.
- Keep heavy artifacts (`node_modules`, `.venv`, `env`, `dist`, `build`, `.cache`) out of the vaults.
- If adding a new vault, manage it as its own git repo and add it to the root `.gitignore`.

Refs
----
- /Users/tennigo/dev/plan.plan.md (reorg plan and log)
- /Users/tennigo/dev/README.md (placement rules for dev/projects)

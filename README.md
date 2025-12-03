# Obsidian Workspace Git Layout

This workspace is git-managed at the root to track config and orchestration files, while each vault is managed by its own repo. The goal is to keep note content and code repos separate and avoid OneDrive sync issues.

Repos
-----
- Root (this directory): tracks plan files, configs, symlinks, docs for the workspace.
- knowledge-vault/: separate repo for the main Obsidian vault (ignored by root).
- research-vault/: separate repo for the research vault (ignored by root).

Symlinks
--------
- projects -> /Users/tennigo/Projects/projects (code lives locally; OneDrive only syncs the link)
- mcp-servers.json, package.json, pnpm-lock.yaml, pyproject.toml -> /Users/tennigo/Projects/

Rules of thumb
--------------
- Do installs/builds in `/Users/tennigo/Projects/projects/**`, not inside OneDrive.
- Keep heavy artifacts (`node_modules`, `.venv`, `env`, `dist`, `build`, `.cache`) out of OneDrive.
- If adding a new vault, manage it as its own git repo and add it to the root `.gitignore`.

Refs
----
- /Users/tennigo/Projects/plan.plan.md (reorg plan and log)
- /Users/tennigo/Projects/README.md (placement rules for Projects/)

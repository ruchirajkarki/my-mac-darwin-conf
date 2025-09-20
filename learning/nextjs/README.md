# Next.js Development Guide (with Nix, Home Manager, and Zsh)

This guide documents a professional, batteries‑included setup for building Next.js projects using Nix, Home Manager, direnv, Corepack, Watchman, ESLint, Prettier, and a fast Zsh environment. It includes a catalog of ready‑to‑copy templates and a reference for the most useful tunables. Templates cover repo hygiene, CI, testing, Docker, HTTPS for local dev, and strict environment typing.

## Overview

- Reproducible toolchains via Nix + devShells.
- Automatic per‑project environment activation with direnv.
- Corepack shims for pinned `pnpm`/`yarn` from your `packageManager` field.
- Watchman for fast file watching on macOS (dev servers, Jest, monorepos).
- ESLint and Prettier preconfigured for Next.js + TypeScript.
- Productive Zsh shell: vi keybindings, autosuggestions, fzf‑powered completion.

## Prerequisites

- Nix installed and flakes enabled.
- Home Manager configured (already wired in this repo).
- direnv installed and shell hooked (this repo enables it).
- VS Code (optional) with ESLint and Prettier extensions.

## Templates Catalog

Copied files should generally be added at your Next.js project root.

- Direnv
  - `learning/templates/nextjs-envrc`: Flake‑aware Node environment with Corepack and `.env` loading.
  - `learning/templates/nextjs-envrc-node-only`: Simple Node environment without Nix flake.
  - `learning/templates/nextjs-envrc-https`: Adds `SSL_*` vars for mkcert local HTTPS (see notes inside).

- VS Code
  - `learning/templates/vscode-nextjs-settings.json`: Workspace settings (Prettier on save + ESLint fixes).
  - `learning/templates/nextjs/.vscode/extensions.json`: Recommended extensions list.
  - `learning/templates/nextjs/.vscode/settings.json`: Same as above but in `.vscode/` structure.

- Next.js Project Config
  - `learning/templates/nextjs/next.config.mjs`: Opinionated defaults with security headers, images, etc.
  - `learning/templates/nextjs/.eslintrc.cjs`: ESLint config tuned for Next.js + TypeScript + import order.
  - `learning/templates/nextjs/prettier.config.cjs`: Prettier defaults (optionally add Tailwind plugin).
  - `learning/templates/nextjs/tsconfig.json`: TypeScript strict config for Next.
  - `learning/templates/nextjs/.editorconfig`: Consistent editor defaults across tools.
  - `learning/templates/nextjs/.gitignore`: Node/Next.js ignore patterns.
  - `learning/templates/nextjs/package.json.example`: Scripts & fields you can merge into your project.
  - `learning/templates/nextjs/.env.example`: Example environment variables and documentation.
  - `learning/templates/nextjs/src/lib/env.ts`: Zod‑validated runtime env helper for type‑safe access.
  - Tailwind (optional): `tailwind.config.ts`, `postcss.config.js`, `src/styles/globals.css`.

- Quality Gates
  - `learning/templates/lint-staged.config.js`: lint‑staged routines for JS/TS and assets.
  - `learning/templates/husky-pre-commit.sh`: Husky hook invoking lint‑staged.
  - `learning/templates/nextjs/commitlint.config.cjs`: Conventional Commits enforcement (optional).
  - `learning/templates/nextjs/.husky/commit-msg` (template): commit message hook for commitlint.

- DevShell (Nix)
  - `learning/templates/nextjs-devshell-flake.nix`: devShell with Node LTS + Corepack + Watchman.

- Testing
  - `learning/templates/nextjs/vitest.config.ts`: Vitest + jsdom + RTL setup.
  - `learning/templates/nextjs/src/test/setup.ts`: React Testing Library and cleanup hooks.

- CI
  - `learning/templates/nextjs/.github/workflows/ci.yml`: Node + pnpm cache, lint, typecheck, test, build.

- Docker
  - `learning/templates/nextjs/Dockerfile`: Multi‑stage, `output: 'standalone'` ready image.
  - `learning/templates/nextjs/docker-compose.yml`: Local dev compose with bind mounts and env.
  - `learning/templates/nextjs/Caddyfile`: Local HTTPS reverse proxy via mkcert certs (optional).

## Quick Start

1) Copy templates you want into your Next.js repo.
2) If using `.envrc`, run `direnv allow` in the repo root.
3) If using Husky/lint‑staged:
   - `pnpm add -D husky lint-staged eslint prettier`
   - `pnpm dlx husky init` then place `husky-pre-commit.sh` into `.husky/pre-commit` (chmod +x).
4) For local HTTPS: `mkcert -install && mkcert localhost` then follow notes in `nextjs-envrc-https`.
5) Open with VS Code; accept extension recommendations and settings.

## Recommended Project Layout

src/
- app/ or pages/
- components/
- lib/
- styles/
- test/

Configuration files
- next.config.mjs, tsconfig.json, .eslintrc.cjs, prettier.config.cjs
- .env (never commit secrets), .env.local (ignored), .editorconfig, .gitignore
- package.json (scripts + packageManager), pnpm-lock.yaml (committed)
- .vscode/settings.json, .vscode/extensions.json (optional)

## Common Scripts (package.json)

- dev: `next dev` — start the dev server.
- build: `next build` — production build.
- start: `next start` — run built app.
- lint: `eslint . --ext .js,.jsx,.ts,.tsx`
- format: `prettier --write .`
- test: `vitest run` (if using vitest template)
- typecheck: `tsc -p tsconfig.json --noEmit`

## Security & Perf Defaults

- Security headers scaffold in `next.config.mjs` (add CSP before prod).
- React Strict Mode and SWC minify enabled.
- ESLint core web vitals + TypeScript rules.
- Prettier consistent formatting across contributors.

## Env Management

- Copy `.env.example` to `.env.local` and keep secrets out of Git.
- Use `src/lib/env.ts` to read env vars; it validates and throws helpful errors in development.
- Prefix public variables with `NEXT_PUBLIC_`.

## Testing

- Vitest + jsdom + React Testing Library template included. Run `pnpm add -D vitest @vitest/ui jsdom @testing-library/react @testing-library/jest-dom @testing-library/user-event` in your project, then add scripts.

## Tailwind CSS (optional)

- Copy `tailwind.config.ts`, `postcss.config.js`, and `src/styles/globals.css`.
- Install: `pnpm add -D tailwindcss postcss autoprefixer` then `pnpm dlx tailwindcss init -p` (or use the provided files).
- Import global styles in your `pages/_app.tsx` or `app/layout.tsx`: `import '@/styles/globals.css'`.

## CI

- GitHub Actions workflow template runs: setup node + pnpm cache, install, lint, typecheck, test, build. Adjust node version and matrix as needed.

## Docker

- The Dockerfile targets Next.js standalone output. Enable `output: 'standalone'` in `next.config.mjs`. Use docker‑compose for local dev with bind mounts.

## Shell Features (from this repo)

- Zsh vi keymap (`viins`) + zsh‑vi‑mode: Vim editing in the shell. `jk` exits insert mode.
- Autosuggestions and syntax highlighting: speed up typing and reduce mistakes.
- fzf‑tab and Ctrl‑T/Alt‑C with previews: fast navigation and file picking.
- Corepack shims and PNPM_HOME on PATH: `pnpm`/`yarn` follow project‑pinned versions.
- direnv + nix‑direnv: project environments load automatically on `cd`.

## Config Options Reference

### Zsh (Home Manager) Highlights

- `programs.zsh.enable`: enable Zsh management.
- `programs.zsh.enableCompletion`: enable completions (`compinit`).
- `programs.zsh.defaultKeymap`: one of `emacs`, `viins`, `vicmd`.
- `programs.zsh.history.{size,save,path,share,expireDuplicatesFirst}`: history tuning.
- `programs.zsh.setOptions`: enable quality‑of‑life flags like `AUTO_CD`, `EXTENDED_GLOB`.
- `programs.zsh.autosuggestion.enable`: zsh‑autosuggestions.
- `programs.zsh.syntaxHighlighting.enable`: zsh‑syntax‑highlighting.
- `programs.zsh.plugins`: non‑OMZ plugins (fzf‑tab, zsh‑vi‑mode, autopair, etc.).
- `programs.zsh."oh-my-zsh".{enable,theme,plugins}`: OMZ support (disabled in this repo).
- `programs.zsh.dotDir`: moved to XDG (`${config.xdg.configHome}/zsh`).

### direnv

- `programs.direnv.enable = true; programs.direnv.nix-direnv.enable = true;` auto‑loads `.envrc` and Nix shells.
- `.envrc` directives:
  - `use flake`: activate devShell if your repo provides one.
  - `layout node`: fallback Node layout if not using flakes.
  - `PATH_add node_modules/.bin`: expose local binaries.
  - `dotenv_if_exists .env`: load env vars from `.env` (no error if missing).

### Corepack / Package Managers

- Corepack shims are enabled to `~/.local/bin` so `pnpm`/`yarn` use the version pinned by your repo’s `packageManager` field.
- `PNPM_HOME` is set to `~/.local/share/pnpm` and is added to PATH.

### Next.js Project Settings (templates)

- ESLint: extends `next/core-web-vitals`, Typescript rules, `import/order` grouping.
- Prettier: single quotes, trailing commas, 100 char width (adjust to taste).
- TSConfig: `strict`, `noUncheckedIndexedAccess`, `noImplicitOverride`, incremental builds.
- next.config.mjs: `reactStrictMode`, `swcMinify`, security headers (CSP stub), image patterns, redirects/rewrites stubs, and `output: 'standalone'` hint.

## Tips

- Prefer project‑local ESLint/Prettier. Global tools are fine for quickfix; CI should use project versions.
- For monorepos, centralize ESLint/Prettier config and share TS base config.
- If you use Tailwind, add `prettier-plugin-tailwindcss` to Prettier plugins in the template.

---

If you want me to auto‑apply these templates to a specific project folder, say the path and which templates to include.

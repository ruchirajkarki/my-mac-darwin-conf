# Repository Guidelines

## Project Structure & Module Organization
- `flake.nix`: Entry point for the Nix flake; sets `hostname`, `username`, formatter, and modules.
- `modules/`: System-level nix-darwin config (`apps.nix`, `system.nix`, `host-users.nix`, `nix-core.nix`, optional `homebrew-mirror.nix`).
- `home/`: Home Manager user config (`default.nix`, `shell.nix`, `git.nix`, `starship.nix`, `fzf-bat.nix`).
- `rich-demo/`: A comprehensive example. Use for reference only; do not deploy as-is.
- `learning/`: Examples and notes (direnv, just, etc.).
- `Makefile`: Convenience `deploy` target.

## Build, Test, and Development Commands
- `make deploy`: Builds `.#darwinConfigurations.<hostname>.system` and switches via `darwin-rebuild`.
- `nix build .#darwinConfigurations.<hostname>.system --extra-experimental-features 'nix-command flakes'`: Build only.
- `./result/sw/bin/darwin-rebuild switch --flake .#<hostname>`: Apply the last build.
- `nix fmt`: Run the configured formatter (Alejandra) on Nix files.
- Optional sanity checks: `nix flake check` and `darwin-rebuild switch --flake .#<hostname> --dry-run`.

## Coding Style & Naming Conventions
- Nix formatting: use `nix fmt` (Alejandra). 2‑space indent, trailing commas, sorted attrs when practical.
- Filenames: kebab-case for `.nix` modules (e.g., `homebrew-mirror.nix`).
- Keep modules focused: system-level in `modules/`, user-level in `home/`.

## Testing Guidelines
- Prefer incremental changes; build locally before PRs.
- Validate evaluation with `nix build` and a `--dry-run` switch when possible.
- If modifying `home/git.nix`, note it removes `~/.gitconfig` during activation—test on a non-critical user first.

## Commit & Pull Request Guidelines
- Commit style: Conventional Commits seen in history (e.g., `feat: ...`, `fix: ...`, `add:`).
- Scope explicitly (e.g., `feat(home): add starship preset`).
- PRs should include: summary, affected files/modules, sample command outputs (build/switch), and any migration notes.
- Ensure `nix fmt` passes and builds succeed before requesting review.

## Security & Configuration Tips
- Avoid committing secrets. Prefer environment variables or separate, ignored files.
- Verify `hostname`, `username`, `useremail` in `flake.nix` before deploying.
- Homebrew apps require Homebrew installed; cask changes can affect system apps—document impacts in PRs.


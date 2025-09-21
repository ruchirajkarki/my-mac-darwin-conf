# Repository Guidelines

## Project Structure & Module Organization
Keep `flake.nix` as the single entrypoint; update `hostname`, `username`, and shared module lists there. Place system modules in `modules/` (e.g., `apps.nix`, `system.nix`), user-facing Home Manager modules under `home/` (`default.nix`, `shell.nix`, `git.nix`). Refer to `rich-demo/` only for examples, and treat `learning/` as scratch space for experiments. Use the `Makefile` `deploy` target when you want a single command that builds and switches.

## Build, Test, and Development Commands
Use `make deploy` for a full build and switch via `darwin-rebuild`. Run `nix build .#darwinConfigurations.<hostname>.system --extra-experimental-features 'nix-command flakes'` to confirm the system builds without applying it. After a successful build, apply it with `./result/sw/bin/darwin-rebuild switch --flake .#<hostname>`. Optional checks: `nix flake check` to validate the flake and `darwin-rebuild switch --flake .#<hostname> --dry-run` to preview changes.

## Coding Style & Naming Conventions
Format all Nix files with `nix fmt` (Alejandra). Maintain 2-space indentation, trailing commas, and sorted attributes when practical. Name Nix modules with kebab-case (`homebrew-mirror.nix`). Keep system logic in `modules/` and user-specific configuration in `home/` to avoid cross-contamination.

## Testing Guidelines
Before committing, ensure `nix build` succeeds for the relevant host. Run `nix flake check` to catch evaluation issues early. When touching Home Manager modules—especially `home/git.nix`—test on a non-critical account because activation replaces `~/.gitconfig`. Document any manual validation steps when opening a PR.

## Commit & Pull Request Guidelines
Follow Conventional Commits (`feat(home): add starship preset`, `fix(modules): correct brew casks`). For PRs, include a concise summary, list touched modules, and paste key command outputs (`nix build`, dry-run switch). Note any host-specific migrations or post-merge actions so downstream users can apply the change safely.

## Security & Configuration Tips
Never commit secrets; prefer environment variables or ignored files. Double-check `hostname`, `username`, and `useremail` in `flake.nix` before deploying. Document the impact of Homebrew changes, since casks can modify system apps, and ensure Homebrew is present on the target machine.

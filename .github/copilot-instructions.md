# AI Coding Agent Instructions for Nix Darwin Configuration

Welcome to the Nix Darwin Configuration repository! This document provides essential guidelines for AI coding agents to navigate and contribute effectively to this codebase.

---

## Big Picture Overview

This repository contains configurations for setting up a macOS system using Nix and nix-darwin. The structure is modular, with separate files for system-level and user-level configurations. Key components include:

- **`flake.nix` and `flake.lock`**: Entry points for the Nix Flake system.
- **`modules/`**: Contains system-level configurations, such as `apps.nix` for package management and `system.nix` for system settings.
- **`home/`**: Manages user-level configurations using Home Manager.
- **`rich-demo/`**: A more extensive demo configuration for reference.
- **`learning/`**: A learning environment with examples and best practices for tools like `direnv`, `just`, and `fzf`.

---

## Developer Workflows

### Building and Deploying Configurations
1. **Build the configuration**:
   ```bash
   nix build .#darwinConfigurations.<hostname>.system --extra-experimental-features 'nix-command flakes'
   ```
2. **Deploy the configuration**:
   ```bash
   ./result/sw/bin/darwin-rebuild switch --flake .#<hostname>
   ```
3. Alternatively, use the `Makefile`:
   ```bash
   make deploy
   ```

### Using `just` for Task Automation
- Run `just` to see available commands.
- Common tasks:
  - `just darwin`: Deploy the configuration.
  - `just clean`: Clean up the Nix store.
  - `just gc`: Garbage collect unused Nix packages.

### Debugging
- Use `direnv` for per-project environments. Example:
  ```sh
  echo 'use nix' > .envrc
  direnv allow
  ```
- Use `fzf` for fuzzy searching files and commands.
- Use `bat` for syntax-highlighted file previews.

---

## Project-Specific Conventions

- **Package Management**:
  - System-level packages are defined in `modules/apps.nix`.
  - User-level packages are managed in `home/core.nix`.
- **Homebrew Integration**:
  - GUI apps and some CLI tools are installed via Homebrew (`modules/apps.nix`).
  - Ensure Homebrew is installed manually before using this feature.
- **Environment Variables**:
  - Define in `modules/apps.nix` under `environment.variables`.

---

## Key Files and Directories

- **`modules/apps.nix`**: Defines system-level packages and Homebrew apps.
- **`home/`**: Contains user-level configurations for tools like `git`, `starship`, and `zsh`.
- **`rich-demo/`**: A comprehensive demo configuration. Use as a reference, not for direct deployment.
- **`learning/`**: Examples and best practices for tools like `direnv`, `just`, and `fzf`.

---

## External Dependencies

- **Nix**: Install from [Nix Official](https://nixos.org/download.html).
- **Homebrew**: Install from [brew.sh](https://brew.sh/).
- **direnv**: For per-project environments.
- **fzf**: For fuzzy finding.
- **bat**: For syntax-highlighted file previews.

---

## Examples

### Adding a New Package
To add a new system-level package, edit `modules/apps.nix`:
```nix
environment.systemPackages = with pkgs; [
  git
  lazygit
  <new-package>
];
```

### Adding a Homebrew App
To add a new Homebrew app, edit `modules/apps.nix`:
```nix
homebrew.casks = [
  "google-chrome"
  "<new-app>"
];
```

---

Feel free to reach out if any section is unclear or requires further elaboration!

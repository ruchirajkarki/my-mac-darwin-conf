# Developer Learning & Training: Nix, Home Manager, and CLI Tools

Welcome to your robust, hands-on learning environment! This README covers every tool, feature, and best practice added to your Nix configuration, with step-by-step usage, advanced tips, and troubleshooting.

---

## Table of Contents
1. [direnv & nix-direnv](#direnv--nix-direnv)
2. [just](#just)
3. [fzf](#fzf)
4. [bat](#bat)
5. [jq](#jq)
6. [ripgrep (rg)](#ripgrep-rg)
7. [git (Home Manager)](#git-home-manager)
8. [General Nix/Flake/Home Manager Tips](#general-nixflakehome-manager-tips)
9. [Troubleshooting](#troubleshooting)

---

## direnv & nix-direnv
- **Purpose:** Per-project, reproducible environments.
- **Setup:**
  - Add `use nix` to `.envrc` in your project.
  - Create a `shell.nix` for dependencies and env vars.
  - Run `direnv allow`.
- **Features:**
  - Loads/unloads env automatically on `cd`.
  - Use any Nix package, set env vars, run shell hooks.
- **Advanced:**
  - Use overlays, custom shells, secrets.
  - Debug with `direnv status` and `direnv reload`.
- **Example:**
  ```sh
  echo 'use nix' > .envrc
  echo '{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell { buildInputs = [ pkgs.jq ]; shellHook = "export DEMO=1"; }' > shell.nix
  direnv allow
  echo $DEMO
  ```

---

## just
- **Purpose:** Modern, user-friendly task runner.
- **Setup:**
  - Create a `Justfile` in your project.
  - Add recipes (commands/scripts).
- **Features:**
  - Arguments, default recipes, multi-line scripts, environment variables.
- **Advanced:**
  - Use `just --list` to see all recipes.
  - Use `just --summary` for a summary.
  - Recipes can depend on each other.
- **Example:**
  ```makefile
  build:
    echo "Building..."
  greet name:
    echo "Hello, {{name}}!"
  ```
  Run with `just build` or `just greet Ruchi`.

---

## fzf
- **Purpose:** Fuzzy finder for files, history, processes, etc.
- **Setup:**
  - Use as a filter: `ls | fzf`, `history | fzf`, `find . | fzf`.
- **Features:**
  - Interactive narrowing, preview window, multi-select.
- **Advanced:**
  - Integrate with shell for Ctrl+R history search.
  - Use `--preview` for file previews: `fzf --preview 'bat --style=numbers --color=always {} | head -100'`.
- **Example:**
  ```sh
  find . | fzf
  ```

---

## bat
- **Purpose:** Syntax-highlighted, line-numbered file viewer.
- **Setup:**
  - Use as a drop-in replacement for `cat`: `bat file.txt`.
- **Features:**
  - Git integration, themes, paging, file type detection.
- **Advanced:**
  - Use with fzf for previews.
  - Customize themes: `bat --list-themes`.
- **Example:**
  ```sh
  bat hello.js
  ```

---

## jq
- **Purpose:** Command-line JSON processor.
- **Setup:**
  - Parse JSON: `cat file.json | jq '.'`
- **Features:**
  - Extract, filter, and transform JSON data.
- **Advanced:**
  - Use with curl: `curl ... | jq`.
  - Write scripts for complex queries.
- **Example:**
  ```sh
  jq '.field' file.json
  ```

---

## ripgrep (rg)
- **Purpose:** Fast, recursive search (like grep, but better).
- **Setup:**
  - Search for text: `rg something`.
- **Features:**
  - Regex, ignore files, color output, file type filters.
- **Advanced:**
  - Use with fzf: `rg something | fzf`.
- **Example:**
  ```sh
  rg "main" .
  ```

---

## git (Home Manager)
- **Purpose:** Reproducible git config via Nix.
- **Setup:**
  - Edit `home/git.nix` for user, email, aliases, signing, etc.
- **Features:**
  - Automatically manages `~/.config/git/config`.
- **Advanced:**
  - Use includes for work/personal configs.
- **Example:**
  ```nix
  programs.git = {
    enable = true;
    userName = "ruchirajkarki";
    userEmail = "ruchirajkarki@gmail.com";
    extraConfig.init.defaultBranch = "main";
  };
  ```

---

## lazygit
- **Purpose:** Terminal UI for git, fast and intuitive.
- **Usage:**
  - Run `lazygit` in any git repo.
  - Stage, commit, push, pull, resolve conflicts visually.
- **Advanced:**
  - Custom keybindings, config in `~/.config/lazygit/config.yml`.

---

## gh (GitHub CLI)
- **Purpose:** Interact with GitHub from the terminal.
- **Usage:**
  - Authenticate: `gh auth login`
  - Create PRs: `gh pr create`
  - Clone repos: `gh repo clone <user>/<repo>`
- **Advanced:**
  - Scriptable, supports issues, gists, releases, and more.

---

## nodejs, yarn, pnpm
- **Purpose:** JavaScript/TypeScript development tools.
- **Usage:**
  - `node` to run JS, `yarn`/`pnpm` for package management.
- **Advanced:**
  - Use with Nix for reproducible JS environments.
  - Use `nodePackages.<pkg>` for global npm tools.

---

## turbo (Vercel TurboRepo CLI)
- **Purpose:** High-performance monorepo build system.
- **Usage:**
  - Run `turbo run <task>` in a monorepo.
- **Advanced:**
  - Configure with `turbo.json`.
  - Caching, remote builds, parallel tasks.

---

## Homebrew (macOS GUI Apps)
- **Purpose:** Install GUI and CLI apps not available or stable in Nixpkgs.
- **Usage:**
  - Add CLI apps to `brews = [ ... ];` in `apps.nix`.
  - Add GUI apps to `casks = [ ... ];` in `apps.nix`.
  - Add Mac App Store apps to `masApps = { ... };` in `apps.nix`.
- **Notes:**
  - Homebrew must be installed manually (see https://brew.sh).
  - Homebrew apps are not managed by Nix and are not reproducible.

---

## Managing Nix Apps & Flake
- **Add a package:**
  - Add to `environment.systemPackages` in `apps.nix`.
  - Run `sudo make deploy` to apply changes.
- **Remove a package:**
  - Remove from `apps.nix`, then `sudo make deploy`.
- **Update all packages:**
  - Run `nix flake update` then `sudo make deploy`.
- **Find a package:**
  - Run `nix search nixpkgs <name>`.
- **Pin or change Nixpkgs version:**
  - Edit `flake.nix` input for `nixpkgs-darwin`.

---

## General Nix/Flake/Home Manager Tips
- Always commit new files for flakes to see them.
- Use `sudo make deploy` for system changes.
- Use `nix flake update` to update all dependencies.
- Use `nix search nixpkgs <pkg>` to find packages.
- Use overlays for custom packages.
- Use Home Manager for dotfiles, fonts, and user programs.

---

## Troubleshooting
- **direnv not loading:** Check `eval "$(direnv hook zsh)"` in `~/.zshrc`.
- **Nix shell not loading:** Check `.envrc` and `shell.nix` syntax.
- **Flake errors:** Make sure all files are committed.
- **Deploy errors:** Read error message, check for breaking changes in nix-darwin/Home Manager.
- **Need more help?**
  - Official docs: https://nixos.org/manual/nix/stable/
  - Home Manager: https://nix-community.github.io/home-manager/
  - Nix Darwin: https://daiderd.com/nix-darwin/manual/index.html
  - Ask Copilot for more!

---

## Advanced Home Manager Features
- **Dotfile Management:**
  - Manage your `~/.zshrc`, `~/.vimrc`, `~/.gitconfig`, etc. declaratively in Nix.
  - Example:
    ```nix
    home.file.".vimrc".text = ''
      set number
      syntax on
    '';
    ```
- **Fonts:**
  - Install and manage fonts reproducibly:
    ```nix
    fonts.fontconfig.enable = true;
    home.packages = [ pkgs.fira-code pkgs.jetbrains-mono ];
    ```
- **Services:**
  - Start user-level services (e.g., syncthing, emacs, gpg-agent):
    ```nix
    services.syncthing.enable = true;
    services.gpg-agent.enable = true;
    ```
- **Shell Integration:**
  - Manage shell config, aliases, and environment variables:
    ```nix
    programs.zsh = {
      enable = true;
      shellAliases = { ll = "ls -l"; gs = "git status"; };
      initExtra = "export LANG=en_US.UTF-8";
    };
    ```
- **Module Usage:**
  - Split your config into multiple files/modules for organization.
  - Import modules in `home/default.nix`:
    ```nix
    imports = [ ./git.nix ./fzf-bat.nix ./shell.nix ];
    ```
- **User Packages:**
  - Add user-only packages (not system-wide):
    ```nix
    home.packages = [ pkgs.htop pkgs.fd pkgs.zoxide ];
    ```
- **Custom Scripts:**
  - Install scripts to `~/bin` or elsewhere:
    ```nix
    home.file."bin/myscript".source = ./myscript.sh;
    ```
- **XDG Integration:**
  - Manage XDG config directories for apps (e.g., `~/.config/nvim`):
    ```nix
    xdg.configFile."nvim/init.vim".text = ''
      set number
    '';
    ```
- **Home Manager Self-Management:**
  - Let Home Manager manage itself:
    ```nix
    programs.home-manager.enable = true;
    ```

---

Happy hacking! Your environment is now robust, reproducible, and ready for anything.

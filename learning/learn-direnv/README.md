# direnv & nix-direnv Demo

This folder demonstrates how to use direnv and nix-direnv for per-project environments.

## 1. What is direnv?
- direnv automatically loads and unloads environment variables when you `cd` into and out of directories.
- With nix-direnv, you can use Nix to define reproducible development environments per project.

## 2. How to use
1. Make sure direnv is enabled in your shell (should be automatic with Home Manager).
2. In this folder, create a `.envrc` file with:
   ```sh
   use nix
   ```
3. Create a `shell.nix` file to define your environment.
4. Run `direnv allow` in this directory.
5. When you `cd` into this folder, the environment will be loaded automatically!

## 3. Example
- See the provided `.envrc` and `shell.nix` files.
- Try running `echo $EXAMPLE_VAR` after entering the directory.

---

## Features
- Automatic environment loading/unloading
- Use any Nix package or custom shell setup
- Project-specific environment variables
- No need to pollute your global shell config

---

Try it out by following the steps above!

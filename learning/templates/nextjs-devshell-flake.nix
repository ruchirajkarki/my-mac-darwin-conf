{
  description = "Template: Next.js devShell with Node LTS + Corepack";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs = { self, nixpkgs }:
    let
      systems = [ "aarch64-darwin" "x86_64-darwin" "x86_64-linux" "aarch64-linux" ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system:
        let pkgs = import nixpkgs { inherit system; }; in f pkgs);
    in {
      devShells = forAllSystems (pkgs: {
        default = pkgs.mkShell {
          packages = with pkgs; [
            nodejs
            corepack
            watchman
          ];
          shellHook = ''
            export PNPM_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/pnpm"
            export PATH="$PNPM_HOME:$PATH"
            if command -v corepack >/dev/null 2>&1; then
              corepack enable --install-directory "$HOME/.local/bin" >/dev/null 2>&1 || true
            fi
            echo "DevShell: Node $(node -v), PNPM via Corepack, Watchman ready"
          '';
        };
      });
    };
}


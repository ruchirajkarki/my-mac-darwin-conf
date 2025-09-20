{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  buildInputs = [pkgs.jq pkgs.ripgrep];
  shellHook = ''
    export EXAMPLE_VAR="Hello from direnv and Nix!"
    echo "Loaded Nix shell with jq and ripgrep."
  '';
}

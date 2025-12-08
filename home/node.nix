{
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (config.xdg) dataHome;
  inherit (config.home) homeDirectory profileDirectory;

  nodejs = pkgs.nodejs;
  pnpmHome = "${dataHome}/pnpm";
  corepackHome = "${dataHome}/corepack";
  localBin = "${homeDirectory}/.local/bin";
in {
  home.packages = [
    nodejs # JavaScript runtime
  ];

  home.sessionVariables = {
    PNPM_HOME = pnpmHome;
    COREPACK_HOME = corepackHome;
  };

  home.sessionPath = [
    "${profileDirectory}/bin"
    localBin
    pnpmHome
  ];

  # Ensure Corepack shims are installed once during activation so `pnpm`
  # resolves the version pinned in project packageManager fields.
  home.activation."corepack-enable-pnpm" = lib.hm.dag.entryAfter ["writeBoundary"] ''
    mkdir -p ${pnpmHome} ${corepackHome} ${localBin}
    COREPACK_HOME=${corepackHome} ${nodejs}/bin/corepack enable pnpm \
      --install-directory ${localBin} >/dev/null 2>&1 || true
  '';
}

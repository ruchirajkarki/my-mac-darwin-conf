{ config, pkgs, home-manager, specialArgs, ... }:

{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = specialArgs;
    users.${config.username} = import ../home;
  };
}
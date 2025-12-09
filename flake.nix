{
  description = "Nix for macOS configuration";

  ##################################################################################################################
  #
  # Want to know Nix in details? Looking for a beginner-friendly tutorial?
  # Check out https://github.com/ryan4yin/nixos-and-flakes-book !
  #
  ##################################################################################################################

  # the nixConfig here only affects the flake itself, not the system configuration!
  nixConfig = {
    substituters = [
      "https://cache.nixos.org"
    ];
  };

  # This is the standard format for flake.nix. `inputs` are the dependencies of the flake,
  # Each item in `inputs` will be passed as a parameter to the `outputs` function after being pulled and built.
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    # nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-24.05-darwin";

    # Pinned nixpkgs for turbo (before Rust 2024 build issue)
    nixpkgs-turbo.url = "github:nixos/nixpkgs/nixos-24.05";

    # home-manager, used for managing user configuration
    home-manager = {
      # url = "github:nix-community/home-manager/release-24.05";
      url = "github:nix-community/home-manager/master";
      # The `follows` keyword in inputs is used for inheritance.
      # Here, `inputs.nixpkgs` of home-manager is kept consistent with the `inputs.nixpkgs` of the current flake,
      # to avoid problems caused by different versions of nixpkgs dependencies.
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Kickstart.nvim: use your personal fork
    # kickstart-nvim = {
    #   url = "github:ruchirajkarki/kickstart.nvim";
    #   flake = false; # fetch as a plain source tree
    # };

    nix-homebrew.url = "github:zhaofengli/nix-homebrew";

    config.url = "./modules/config.nix";
  };

  # The `outputs` function will return all the build results of the flake.
  # A flake can have many use cases and different types of outputs,
  # parameters in `outputs` are defined in `inputs` and can be referenced by their names.
  # However, `self` is an exception, this special parameter points to the `outputs` itself (self-reference)
  # The `@` syntax here is used to alias the attribute set of the inputs's parameter, making it convenient to use inside the function.
  outputs = inputs @ {
    self,
    nixpkgs,
    nixpkgs-turbo,
    darwin,
        home-manager,
        nix-homebrew,
        config,
        ...
      }: let
        # Get turbo from the pinned nixpkgs version
        pkgs-turbo = import nixpkgs-turbo {
          inherit config.system;
        };
    
        specialArgs = inputs // config // {inherit pkgs-turbo;};
      in {
        darwinConfigurations."${config.hostname}" = darwin.lib.darwinSystem {
          inherit config.system specialArgs;
          modules = [
            ./modules/nix-core.nix
        ./modules/system-core.nix # Core system configuration
        ./modules/macos-preferences.nix # macOS defaults and user preferences
        ./modules/apps.nix
        ./modules/homebrew-mirror.nix # comment this line if you don't need a homebrew mirror
        ./modules/host-users.nix


        # home manager
        home-manager.darwinModules.home-manager
        ./modules/home-manager-config.nix # new home-manager configuration
      ];
    };

    # nix code formatter
    formatter.${system} = nixpkgs.legacyPackages.${system}.alejandra;
  };
}

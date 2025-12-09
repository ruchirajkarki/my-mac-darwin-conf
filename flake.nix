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
        ...
      }: let
        # Import main configuration
        config = import ./modules/config.nix;

        # Get the standard pkgs for the system
        pkgs = import nixpkgs {
          system = config.system;
        };
    
        # Get turbo from the pinned nixpkgs version
        pkgs-turbo = import nixpkgs-turbo {
          system = config.system;
        };
    
        specialArgs = inputs // config // {inherit pkgs-turbo;};
      in {
        darwinConfigurations."${config.hostname}" = darwin.lib.darwinSystem {
          system = config.system;
          inherit specialArgs;
          modules = [
            (import ./modules/nix-core.nix { inherit pkgs config; lib = nixpkgs.lib; })
        (import ./modules/system-core.nix { inherit pkgs config; }) # Core system configuration
        (import ./modules/macos-preferences.nix { inherit config; }) # macOS defaults and user preferences
        (import ./modules/apps.nix { inherit pkgs pkgs-turbo config; })
        ./modules/homebrew-mirror.nix # comment this line if you don't need a homebrew mirror
        (import ./modules/host-users.nix { inherit pkgs config; hostname = config.hostname; username = config.username; })

        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            enable = true;
            user = config.username;
            autoMigrate = true;
          };
        }



        # home manager
        home-manager.darwinModules.home-manager
        (import ./modules/home-manager-config.nix { inherit config pkgs home-manager specialArgs; lib = nixpkgs.lib; }) # new home-manager configuration
      ];
    };

    # nix code formatter
    formatter.${config.system} = nixpkgs.legacyPackages.${config.system}.alejandra;
  };
}

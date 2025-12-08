{
  pkgs,
  pkgs-turbo,
  ...
}: {
  ##########################################################################
  #
  #  Install all apps and packages here.
  #
  # TODO Fell free to modify this file to fit your needs.
  #
  ##########################################################################

  # Install packages from nix's official package repository.
  #
  # The packages installed here are available to all users, and are reproducible across machines, and are rollbackable.
  # But on macOS, it's less stable than homebrew.
  #
  # Related Discussion: https://discourse.nixos.org/t/darwin-again/29331
  environment.systemPackages = with pkgs; [
    neovim
    git
    lazygit
    # just # use Justfile to simplify nix-darwin's commands
    # rar
    gh
    nodejs
    nil
    # yarn
    #nodejs_18
    #(yarn.override { nodejs = nodejs_18; })
    direnv
    # nix-direnv
    jq
    ripgrep
    just
    fzf
    bat
    fd
    nixfmt-classic
    # docker
    # docker-compose
    spicetify-cli
    # For Expo
    nodePackages.eas-cli

    pkgs-turbo.turbo # Vercel TurboRepo CLI (pinned to working version)
    # tmux # terminal multiplexer for managing terminal sessions
    postman
    # flutter
    # android-tools
    # codex # Outdated in nixpkgs (0.58.0), install via npm: npm install -g codex-cli
  ];
  environment.variables.EDITOR = "nvim";

  # TODO To make this work, homebrew need to be installed manually, see https://brew.sh
  #
  # The apps installed by homebrew are not managed by nix, and not reproducible!
  # But on macOS, homebrew has a much larger selection of apps than nixpkgs, especially for GUI apps!
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true; # Fetch the newest stable branch of Homebrew's git repo
      upgrade = true; # Upgrade outdated casks, formulae, and App Store apps
      # 'zap': uninstalls all formulae(and related files) not listed in the generated Brewfile
      cleanup = "zap";
    };

    # Applications to install from Mac App Store using mas.
    # You need to install all these Apps manually first so that your apple account have records for them.
    # otherwise Apple Store will refuse to install them.
    # For details, see https://github.com/mas-cli/mas
    masApps = {
      # TODO Feel free to add your favorite apps here.
      # "DevCleaner for Xcode" = 1388020431; # Xcode cache cleaner
      "uBlock origin lite" = 6745342698;

      # Xcode = 497799835;
      # Wechat = 836500024;
      # NeteaseCloudMusic = 944848654;
      # QQ = 451108668;
      # WeCom = 1189898970;  # Wechat for Work
      # TecentMetting = 1484048379;
      # QQMusic = 595615424;
    };

    taps = [
      # "homebrew/services"
    ];

    # `brew install`
    # TODO Feel free to add your favorite apps here.
    brews = [
      "wget" # download tool
      "curl" # no not install curl via nixpkgs, it's not working well on macOS!
      "biome"
      # "aria2" # download tool
      # "httpie" # http client
      "cloudflared"
      # "mariadb"
      # "php"
      # "composer"
      # "go"
      # "fastlane"
      # "minikube"
      # "skaffold"
      # "rbenv"
      "libpq"
      "shellcheck" # shell script static analysis tool
      "openjdk@21"
      # "container"
      # "spicetify-cli" # Spotify customizer
      # "scrcpy"
      # "cocoapods" # CocoaPods CLI for iOS development

      ##### FOR DOPPLER ######
      # Prerequisite. gnupg is required for binary signature verification
      "gnupg"
      # Next, install using brew (use `doppler update` for subsequent updates)
      "dopplerhq/cli/doppler"
      ########################
    ];

    # `brew install --cask`
    # TODO Feel free to add your favorite apps here.
    casks = [
      # "xcodes"
      "firefox"
      "spotify"
      # "claude-code"
      "localsend"
      "google-chrome"
      "ghostty"
      "appcleaner"
      "pearcleaner"
      # "cloudflare-warp"
      # "cursor"
      "mac-mouse-fix"
      # "android-studio"
      # "reactotron"
      # "ollama-app"
      # "expo-orbit"
      "obsidian"
      "cursor"
      "codex" # OpenAI Codex CLI
      # "rar"
      # "visual-studio-code"
      # "utm"
      # "arc"
      # "sublime-text"
      "dbeaver-community"
      # IM & audio & remote desktop & meeting
      # "telegram"
      # "discord"
      "brainfm"

      # "anki"
      "iina" # video player
      "raycast" # (HotKey: alt/option + space)search, caculate and run scripts(with many plugins)
      "stats" # beautiful system monitor
      # "eudic" # 欧路词典

      # Development
      # "insomnia" # REST client
      # "postman"
      # "wireshark" # network analyzer
      # "soulseek"
      "docker-desktop"
      "visual-studio-code" # signed build; nix package fails codesign on macOS
    ];
  };
}

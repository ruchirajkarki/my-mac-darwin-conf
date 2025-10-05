{pkgs, ...}: {
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
    # yarn
    #nodejs_18
    #(yarn.override { nodejs = nodejs_18; })
    pnpm
    direnv
    # nix-direnv
    jq
    ripgrep
    just
    fzf
    bat
    fd
    docker
    # vscode

    # For Expo
    nodePackages.eas-cli

    # For NestJS
    # nodePackages."@nestjs/cli"
    turbo # Vercel TurboRepo CLI
    # tmux # terminal multiplexer for managing terminal sessions
    postman
    android-tools
    codex

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
      # "aria2" # download tool
      # "httpie" # http client
      # "mariadb"
      # "php"
      # "composer"
      # "go"
      # "fastlane"
      # "minikube"
      # "skaffold"
      # "rbenv"
      "openjdk@21"
      # "scrcpy"
      # "cocoapods" # CocoaPods CLI for iOS development
    ];

    # `brew install --cask`
    # TODO Feel free to add your favorite apps here.
    casks = [
      # "xcodes"
      "firefox"
      # "claude-code"
      "localsend"
      "google-chrome"
      "ghostty"
      # "cloudflare-warp"
      # "cursor"
      "mac-mouse-fix"
      # "android-studio"
      "visual-studio-code"
      # "reactotron"
      "ollama-app"
      # "expo-orbit"
      "obsidian"
      # "rar"
      # "visual-studio-code"
      # "utm"
      # "arc"
      # "sublime-text"
      # "dbeaver-community"
      # IM & audio & remote desktop & meeting
      # "telegram"
      # "discord"
      # "brainfm"

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
    ];
  };
}

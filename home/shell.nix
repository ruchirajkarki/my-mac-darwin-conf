{pkgs, ...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion = {
      enable = true;
    };
    syntaxHighlighting = {
      enable = true;
    };
    "oh-my-zsh" = {
      enable = false;
      theme = "agnoster";
      plugins = [
        "git"
        "npm"
        "node"
        "yarn"
        "docker"
        "docker-compose"
        "kubectl"
        "helm"
      ];
    };
    # Prefer XDG layout for Zsh configs
    dotDir = ".config/zsh";

    # Improve history behavior
    history = {
      size = 10000;
      save = 10000;
      path = "$HOME/.local/state/zsh/history";
      share = true;
      expireDuplicatesFirst = true;
    };

    # Helpful, low-risk Zsh options
    setOptions = [
      "AUTO_CD" # cd by typing directory name
      "INTERACTIVE_COMMENTS" # allow # comments in interactive shell
      "EXTENDED_GLOB" # richer globbing
      "HIST_IGNORE_DUPS" # ignore consecutive duplicates
      "HIST_VERIFY" # edit before executing from history
    ];

    # Lightweight plugins (non-OMZ)
    plugins = [
      {
        name = "fzf-tab";
        src = pkgs.zsh-fzf-tab;
        file = "share/fzf-tab/fzf-tab.plugin.zsh";
      }
      {
        name = "zsh-autopair";
        src = pkgs.zsh-autopair;
        file = "share/zsh-autopair/autopair.zsh";
      }
    ];
    initContent = ''
      # General paths
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"

      # Java (Homebrew OpenJDK)
      export PATH="/opt/homebrew/opt/openjdk@21/bin:$PATH"
      export CPPFLAGS="-I/opt/homebrew/opt/openjdk@21/include"

      # Android SDK
      export ANDROID_HOME="$HOME/Library/Android/sdk"
      export PATH="$PATH:$ANDROID_HOME/platform-tools"
      export PATH="$PATH:$ANDROID_HOME/tools/bin"
      export PATH="$PATH:$ANDROID_HOME/emulator"
    '';
  };

  home.shellAliases = {
    t = "turbo";
    dd = "cd ~/nix-conf && make deploy";
    pd = "pnpm dev";
    pi = "pnpm install";

    code_bot = "cd ~/work/istem/dynamic/bot_frontend && code . && turbo dev";
    code_bid = "cd ~/work/istem/dynamic/bid-my-trip && code . && turbo dev";
    code_land = "cd ~/work/istem/dynamic/landscape_frontend && code . && pnpm dev";

    urldecode = "python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'";
    urlencode = "python3 -c 'import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))'";
  };
}

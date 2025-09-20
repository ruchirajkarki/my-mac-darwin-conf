{
  pkgs,
  config,
  ...
}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    defaultKeymap = "viins";
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
    # Prefer XDG layout for Zsh configs (silence deprecation warning)
    dotDir = "${config.xdg.configHome}/zsh";

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
        name = "zsh-vi-mode";
        src = pkgs.zsh-vi-mode;
        file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
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

      # PNPM home (works well with Corepack)
      export PNPM_HOME="''${XDG_DATA_HOME:-$HOME/.local/share}/pnpm"
      export PATH="$PNPM_HOME:$PATH"

      # Corepack shims for Yarn/Pnpm pinned by packageManager
      if command -v corepack >/dev/null 2>&1; then
        COREPACK_HOME="''${XDG_DATA_HOME:-$HOME/.local/share}/corepack"
        export COREPACK_HOME
        corepack enable --install-directory "$HOME/.local/bin" >/dev/null 2>&1 || true
      fi

      # fzf previews and nicer defaults
      export FZF_DEFAULT_OPTS="--height=40% --layout=reverse --border"
      export FZF_CTRL_T_OPTS='--preview "bat --style=numbers --color=always {} | head -500"'
      export FZF_ALT_C_OPTS='--preview "eza -lah --group-directories-first --icons {} | head -200"'

      # Autosuggestions: async + history strategy; use array-safe assignments
      typeset -ga ZSH_AUTOSUGGEST_STRATEGY
      ZSH_AUTOSUGGEST_STRATEGY=(history)
      typeset -g ZSH_AUTOSUGGEST_USE_ASYNC=1
      typeset -g ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=50
      if typeset -f autosuggest-accept >/dev/null; then
        bindkey -M viins '^f' autosuggest-accept
      fi

      # Vi-mode ergonomics: jk to escape; cursors per mode
      export KEYTIMEOUT=20
      function zle-keymap-select {
        if [[ $KEYMAP == vicmd ]]; then
          print -n '\e[1 q'   # block cursor
        else
          print -n '\e[5 q'   # beam cursor
        fi
      }
      function zle-line-init { zle -K viins; print -n '\e[5 q'; }
      zle -N zle-keymap-select
      zle -N zle-line-init
      bindkey -M viins 'jk' vi-cmd-mode
    '';
  };

  home.shellAliases = {
    t = "turbo";
    dd = "cd ~/nix-conf && make deploy";
    pd = "pnpm dev";
    pi = "pnpm install";

    # Next.js / pnpm dev aliases
    nd = "pnpm dev";
    nb = "pnpm build";
    nl = "pnpm lint";
    nt = "pnpm test";
    nxd = "next dev";

    code_bot = "cd ~/work/istem/dynamic/bot_frontend && code . && turbo dev";
    code_bid = "cd ~/work/istem/dynamic/bid-my-trip && code . && turbo dev";
    code_land = "cd ~/work/istem/dynamic/landscape_frontend && code . && pnpm dev";

    urldecode = "python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'";
    urlencode = "python3 -c 'import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))'";
  };
}

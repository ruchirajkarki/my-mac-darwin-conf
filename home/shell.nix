{...}: {
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

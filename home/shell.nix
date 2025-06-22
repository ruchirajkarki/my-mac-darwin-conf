{...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
     initExtra = ''
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
    k = "kubectl";
    cj = "pnpm install && pnpm dev";
    ccj = "rm -rf node_modules pnpm-lock.yaml && pnpm install && pnpm dev";

    urldecode = "python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'";
    urlencode = "python3 -c 'import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))'";

    red = "adb connect 192.168.1.143";
    sam = "adb connect 192.168.1.112";
    nab = "adb connect 192.168.1.113";
    nir = "php artisan serve --host 0.0.0.0 --port 8000";
  };
}

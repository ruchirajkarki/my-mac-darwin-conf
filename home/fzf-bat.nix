{...}: {
  programs.fzf = {
    # enables and configures fzf (fuzzy finder)
    enable = true;
    enableZshIntegration = true;
    defaultCommand = "fd --type f --hidden --follow --exclude .git";
    defaultOptions = ["--height=40%" "--layout=reverse" "--border"];
    fileWidgetCommand = "fd --type f --hidden --follow --exclude .git";
    changeDirWidgetCommand = "fd --type d --hidden --follow --exclude .git";
  };
  programs.bat = {
    # enables bat (cat clone with syntax highlighting)
    enable = true;
  };
}

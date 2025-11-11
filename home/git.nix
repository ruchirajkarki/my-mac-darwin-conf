{
  lib,
  username,
  useremail,
  ...
}: {
  # `programs.git` will generate the config file: ~/.config/git/config
  # to make git use this config file, `~/.gitconfig` should not exist!
  #
  #    https://git-scm.com/docs/git-config#Documentation/git-config.txt---global
  home.activation.removeExistingGitconfig = lib.hm.dag.entryBefore ["checkLinkTargets"] ''
    rm -f ~/.gitconfig
  '';

  programs.git = {
    enable = true;
    lfs.enable = true;

    # TODO replace with your own name & email
    userName = "ruchirajkarki";
    userEmail = "ruchirajkarki@gmail.com";

    includes = [
      {
        # use diffrent email & name for work
        path = "~/work/.gitconfig";
        # condition = "gitdir:~/work/";
        condition = "gitdir:/Users/ruchirajkarki/work/**";
      }
    ];

    extraConfig = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      pull.rebase = true;
    };

    # signing = {
    #   key = "xxx";
    #   signByDefault = true;
    # };

    # delta = {
    #   enable = true;
    #   options = {
    #     features = "side-by-side";
    #   };
    # };
    delta = {
    enable = true;
    options = {
      "true-color" = "always";
      "line-numbers" = true;
      navigate     = true;
      light        = false;

      interactive = {
        "keep-plus-minus-markers" = false;
      };

      decorations = {
        "commit-decoration-style"        = "blue ol";
        "commit-style"                   = "raw";
        "file-style"                     = "omit";
        "hunk-header-decoration-style"   = "blue box";
        "hunk-header-file-style"         = "red";
        "hunk-header-line-number-style"  = "#067a00";
        "hunk-header-style"              = "file line-number syntax";
      };
    };
  };

    aliases = {
      # common aliases
      br = "branch";
      co = "checkout";
      st = "status";
      ls = "log --pretty=format:\"%C(yellow)%h%Cred%d\\\\ %Creset%s%Cblue\\\\ [%cn]\" --decorate";
      ll = "log --pretty=format:\"%C(yellow)%h%Cred%d\\\\ %Creset%s%Cblue\\\\ [%cn]\" --decorate --numstat";
      cm = "commit -m";
      ca = "commit -am";
      dc = "diff --cached";
      amend = "commit --amend -m";

      # aliases for submodule
      update = "submodule update --init --recursive";
      foreach = "submodule foreach";
    };
  };
}

# `git` scm

{ pkgs, user, ... }:

{
  programs.git = {
    enable = true;
    package = pkgs.gitMinimal;
    userName = user.git.name;
    userEmail = user.email;

    extraConfig = {
      # default branch `main`
      init.defaultBranch = "main";
      # auto remote
      push.autoSetupRemote = true;
    };

    # `git lfs`
    lfs.enable = true;

    # syntax highlighting for diffs
    delta.enable = true;
  };
}

{
  imports = [
    ./utils.nix
  ];

  # set up nushell
  programs.nushell = {
    enable = true;

    # todo: starship
    # todo: carapace

    shellAliases = {
      cat = "bat";
      cd = "z";
      cloc = "tokei";
      dig = "dog";
      find = "fd";
      fuck = "f";
      grep = "rg";
      hex = "hexyl";
      ls = "eza";
      ping = "gping";
      ps = "procs";
      scc = "tokei";
      sed = "sd";
    };
  };

  # automatically set up remotes for git repositories
  programs.git.extraConfig = {
    push.autoSetupRemote = true;
  };
}

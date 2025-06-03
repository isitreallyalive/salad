{ pkgs, ... }:

{
  imports = [
    # todo: carapace
    ./nushell.nix
    ./starship.nix
    ./utils.nix
  ];

  # `git`
  programs.git = {
    enable = true;
    package = pkgs.gitMinimal;
    extraConfig = {
      init.defaultBranch = "main"; # default branch `main`
      push.autoSetupRemote = true; # auto remote
    };
  };
}

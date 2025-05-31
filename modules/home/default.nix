{ pkgs, ... }:

{
  imports = [
    ../generic

    ./home.nix # home-manager
    ./shell.nix # shell configuration
  ];

  programs.git = {
    enable = true;
    package = pkgs.gitMinimal;
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  # todo: replace with librewolf
  programs.firefox.enable = true;
}

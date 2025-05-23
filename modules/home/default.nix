{ pkgs, ... }:

{
  imports = [
    ./home.nix # home-manager
  ];

  programs.git = {
    enable = true;
    package = pkgs.gitMinimal;
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  programs.autorandr.enable = true;
}
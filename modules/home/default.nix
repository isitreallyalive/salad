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

  # todo: replace with librewolf
  programs.firefox.enable = true;
}

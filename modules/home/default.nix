{
  imports = [
    ../generic

    ./shell
    ./programs

    ./home.nix # home-manager
  ];

  # todo: replace with librewolf
  programs.firefox.enable = true;
}

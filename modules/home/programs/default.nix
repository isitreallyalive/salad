# Global programs managed by `home-manager`.

{
  imports = [
    ./kitty.nix
  ];

  # todo: replace with librewolf
  programs.firefox.enable = true;
}

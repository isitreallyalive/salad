{
  pkgs,
  ...
}:

{
  programs.nushell.shellAliases = {
    cowsay = "kittysay";
    neofetch = "fastfetch";
  };

  # audio visualization
  programs.cava = {
    enable = true;
    catppuccin.enable = true;
  };

  # `neofetch` alternative
  programs.fastfetch.enable = true;

  salad.packages = {
    inherit (pkgs)
      kittysay # `cowsay` but with a cute kitty
      onefetch # `neofetch` for git repositories
      ;
  };
}

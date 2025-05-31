{
  pkgs,
  ...
}:

{
  programs.nushell.shellAliases = {
    cowsay = "kittysay";
    neofetch = "fastfetch";
  };

  salad.packages = {
    inherit (pkgs)
      fastfetch # `neofetch` replacement
      kittysay # `cowsay` but with a cute kitty
      onefetch # `neofetch` for git repositories
      ;
  };
}

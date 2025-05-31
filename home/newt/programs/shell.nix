{ pkgs, ... }:

{
  # git user configuration
  # todo: manage through config.salad.users.git
  programs.git = {
    userName = "newt";
    userEmail = "hi@newty.dev";
  };

  programs.nushell.shellAliases = {
    cowsay = "kittysay";
  };

  salad.packages = {
    inherit (pkgs)
      kittysay # `cowsay` but with a cute kitty
      onefetch # neofetch for git repositories
      ;
  };
}

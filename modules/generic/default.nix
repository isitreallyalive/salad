{ lib, ... }:

let
  profiles = [
    "server"
    "graphical"
  ];
in
{
  imports = [
    ./packages.nix # system packages
    ./users.nix # user configuration
  ];

  # system profiles
  options.salad.profiles = lib.genAttrs profiles (
    profile: lib.mkEnableOption "the ${profile} profile"
  );
}

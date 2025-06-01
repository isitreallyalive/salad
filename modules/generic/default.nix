{ lib, ... }:

let
  profiles = [
    "graphical"
    "server"
    "workstation"
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

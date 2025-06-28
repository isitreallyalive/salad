/*
  Entry point for the `generic` salad module.

  Defines options that should exist in all modules.
*/
{ lib, ... }:

let
  inherit (lib) mkEnableOption;

  profiles = [
    "graphical"
    "server"
    "workstation"
    "gaming"
  ];
in
{
  imports = [
    ./packages.nix # system packages
    ./users.nix # user configuration
  ];

  # system profiles
  options.salad.profiles = lib.genAttrs profiles (profile: mkEnableOption "the ${profile} profile");

  # remote builds
  options.salad.deploy.remote = mkEnableOption "build on remote machine when deploying" // {
    default = true;
  };
}

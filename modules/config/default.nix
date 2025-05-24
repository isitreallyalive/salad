{ lib, ... }:

let
  inherit (lib) mkOption types;

  profiles = [
    "server"
    "graphical"
  ];
in
{
  imports = [
    ./display.nix # display settings
    ./users.nix # user configuration
  ];

  # system profiles
  options.salad.profiles = lib.genAttrs profiles (
    profile: lib.mkEnableOption "the ${profile} profile"
  );

  # system state version
  options.salad.stateVersion = mkOption {
    type = types.str;
    default = "25.05";
    description = ''
      This value determines the NixOS release from which the default
      settings for stateful data, like file locations and database versions
      on your system were taken'';
  };
}

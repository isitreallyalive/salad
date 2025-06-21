/*
  Entry point for salad specific configuration.

  The difference between this and `generic` is that these options
  should only exist when in a class module.
*/

{ lib, ... }:

let
  inherit (lib) mkOption types;
in
{
  imports = [
    ../../generic # generic configuration

    ./display.nix # display settings
    ./domains.nix # domains for acme client
  ];

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

{ lib, ... }:

let
  inherit (lib) mkOption types;
in
{
  imports = [
    ./display.nix # display settings
    ./users.nix # user configuration
  ];

  options.salad.stateVersion = mkOption {
    type = types.str;
    default = "25.05";
    description = ''
      This value determines the NixOS release from which the default
      settings for stateful data, like file locations and database versions
      on your system were taken'';
  };
}

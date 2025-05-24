{ config, ... }:

{
  imports = [
    ../../home # home-manager
    ../config # salad options

    ./nix.nix # nix
  ];

  system.stateVersion = config.salad.stateVersion;
}

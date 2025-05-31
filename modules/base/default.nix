{ config, ... }:

{
  imports = [
    ../../home # home-manager

    ./config # salad options

    ./nix.nix # nix configuration
    ./users.nix # user generation
  ];

  system.stateVersion = config.salad.stateVersion;
}

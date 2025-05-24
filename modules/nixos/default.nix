{ inputs, pkgs, ... }:

{
  imports = [
    ../base

    # this is the configuration.nix that cherry generated on install.
    # todo: refactor into the module
    ./old-configuration.nix

    ./plasma # plasma6 de

    inputs.home-manager.nixosModules.home-manager
  ];

  environment.systemPackages = with pkgs; [
    # temp dev tools
    # todo: remove
    firefox    # firefox
  ];
}

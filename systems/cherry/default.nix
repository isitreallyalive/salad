# Laptop.

{ pkgs, ... }:

{
  imports = [
    ./old-hardware.nix
  ];

  # kanidm client to test lychee
  services.kanidm = {
    package = pkgs.kanidm_1_6;
    enableClient = true;
    clientSettings.uri = "https://auth.redstone.observer";
  };

  salad = {
    stateVersion = "24.11";

    displays = [
      {
        name = "eDP-1";
        width = 1920;
        height = 1080;
        refreshRate = 144;
      }
    ];

    profiles = {
      gaming = true;
      graphical = true;
      workstation = true;
    };
  };
}

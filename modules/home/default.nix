/*
  Entry point for `home-manager` configuration shared by every
  user.
*/
{ lib, osConfig, ... }:

{
  imports = [
    ../generic

    ./plasma # plasma 6 de
    ./shell # shell configuration
    ./programs
  ];

  home.stateVersion = osConfig.salad.stateVersion;

  # reload system units when changing configs
  systemd.user.startServices = lib.mkDefault "sd-switch"; # or "legacy" if "sd-switch" breaks again

  # let home-manager manage itself when in standalone mode
  programs.home-manager.enable = true;
}

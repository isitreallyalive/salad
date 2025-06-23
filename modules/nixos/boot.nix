# Bootloader (`systemd-boot`) configuration.

# todo: add lanzaboote
# https://github.com/nix-community/lanzaboote/blob/master/docs/QUICK_START.md

{ config, ... }:

let
  inherit (builtins) toString;
in
{
  boot.loader = {
    systemd-boot = {
      enable = true;
      consoleMode = "2";
    };

    # allow EFI variables to be set
    efi.canTouchEfiVariables = true;
  };

  # set display resolutions
  # see: https://wiki.archlinux.org/title/Kernel_mode_setting
  boot.kernelParams = builtins.map (
    display:
    "video=${display.name}:${toString display.width}x${toString display.height}@${toString display.refreshRate}"
  ) config.salad.displays;
}

# Bootloader (`systemd-boot`) and kernel configuration.

# todo: add lanzaboote
# https://github.com/nix-community/lanzaboote/blob/master/docs/QUICK_START.md

{ config, pkgs, ... }:

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

  # use cachyos-kernel
  boot.kernelPackages =
    with pkgs;
    if config.salad.profiles.server then linuxPackages_hardened else linuxPackages_cachyos;

  # set display resolutions
  # see: https://wiki.archlinux.org/title/Kernel_mode_setting
  boot.kernelParams = builtins.map (
    display:
    "video=${display.name}:${toString display.width}x${toString display.height}@${toString display.refreshRate}"
  ) config.salad.displays;
}

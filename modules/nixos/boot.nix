# todo: add lanzaboote
# https://github.com/nix-community/lanzaboote/blob/master/docs/QUICK_START.md

{ config, ... }:

let
  inherit (builtins) toString;
in
{
  boot.loader = {
    # enable systemd-booy
    systemd-boot.enable = true;

    # allow EFI variables to be set
    efi.canTouchEfiVariables = true;
  };

  # set display resolutions
  # see: https://wiki.archlinux.org/title/Kernel_mode_setting
  # todo: test outside of hyperv
  boot.kernelParams = builtins.map (
    display:
    "video=${display.name}:${toString display.width}x${toString display.height}@${toString display.refreshRate}"
  ) config.salad.displays;
}

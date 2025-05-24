{ config, pkgs, ... }:

let
  inherit (builtins) toString;

  kscreen = pkgs.libsForQt5.libkscreen;
  kscreenCommands = builtins.map (display: 
    "output.${display.name}.mode.${toString display.width}x${toString display.height}@${toString display.refreshRate}"
  ) config.salad.displays;
in
{
  services = {
    desktopManager.plasma6.enable = true;
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
  };

  # automatically configure displays with kscreen
  environment.systemPackages = [ kscreen ];
  systemd.user.services.kscreen-setup = {
    description = "Configure displays with kscreen";
    wantedBy = [ "plasma-workspace.target" ];
    after = [ "plasma-workspace.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${kscreen}/bin/kscreen-doctor ${builtins.concatStringsSep " " kscreenCommands}";
    };
  };

  # todo: exclude other bloat
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    kate
  ];
}
{
  pkgs,
  config,
  self,
  ...
}:

let
  dpi = percent: 96 * (percent / 100);
in
{
  imports = [
    ./fonts.nix
  ];

  config = self.lib.mkIfProfile config "graphical" {
    services = {
      desktopManager.plasma6.enable = true;
      displayManager.sddm = {
        enable = true;
        wayland.enable = true;
      };
      xserver.dpi = dpi 125;
    };

    # todo: exclude other bloat
    environment.plasma6.excludePackages = with pkgs.kdePackages; [
      kate
      konsole
    ];
  };
}

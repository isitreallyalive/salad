{
  pkgs,
  config,
  self,
  ...
}:

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
    };

    # todo: exclude other bloat
    environment.plasma6.excludePackages = with pkgs.kdePackages; [
      kate
      konsole
    ];
  };
}

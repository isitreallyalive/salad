# Enable and configure the Plasma 6 desktop environment.

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

  config = self.lib.profile.mkIf config "graphical" {
    services = {
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

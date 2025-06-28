# Simple Desktop Display Manager (SDDM) configuration

{
  pkgs,
  self,
  config,
  ...
}:

let
  sddm-astronaut =
    (pkgs.sddm-astronaut.overrideAttrs (old: {
      installPhase =
        let
          basePath = "$out/share/sddm/themes/sddm-astronaut-theme";
        in
        ''
          mkdir -p ${basePath}/Backgrounds
          install -m 644 ${./bert.gif} ${basePath}/Backgrounds/bert.gif
          ${old.installPhase}
        '';
    })).override
      {
        embeddedTheme = "bert";
        themeConfig = builtins.fromTOML (builtins.readFile ./bert.conf);
      };
in
{
  services = self.lib.profile.mkIf config [ "graphical" ] {
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;

      # set the theme
      extraPackages = [ sddm-astronaut ];
      theme = "sddm-astronaut-theme";
      settings = {
        Theme = {
          Current = "sddm-astronaut-theme";
        };
      };
    };
    desktopManager.plasma6.enable = true;
  };

  salad.packages = {
    inherit sddm-astronaut;
  };
}

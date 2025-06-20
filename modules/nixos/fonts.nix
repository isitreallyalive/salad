# Font configuration.
# todo: refine

{
  pkgs,
  config,
  self,
  ...
}:

{
  config = self.lib.profile.mkIf config "graphical" {
    # install fonts
    fonts.packages = with pkgs; [
      cascadia-code
      corefonts
      vistafonts
    ];

    # default fonts
    fonts.fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [
          "Times New Roman"
          "Liberation Serif"
        ];
        sansSerif = [
          "Arial"
          "Liberation Sans"
        ];
        monospace = [
          "Consolas"
          "Liberation Mono"
        ];
      };
    };
  };
}

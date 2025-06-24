# spicetify
# todo: extensions and theme

{ pkgs, inputs, ... }:

{
  programs.spicetify = with inputs.spicetify.legacyPackages.${pkgs.stdenv.system}; {
    enable = true;
    theme = themes.catppuccin;
    colorScheme = "mocha";

    # enabledExtensions = with extensions; [

    # ];

    enabledCustomApps = with apps; [
      lyricsPlus
    ];
  };
}

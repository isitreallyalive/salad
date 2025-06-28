{
  self,
  osConfig,
  pkgs,
  ...
}:

let
  inherit (self.lib) profile;
in
{
  imports =
    profile.importIf osConfig
      [ "graphical" ]
      [
        ./librewolf.nix
        ./spotify.nix
        ./vesktop.nix
        ./vscode.nix
      ];

  salad.packages = profile.mkIf osConfig [ "graphical" ] {
    inherit (pkgs) bitwarden-desktop;
  };
}

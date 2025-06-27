{
  self,
  osConfig,
  ...
}:

{
  imports = self.lib.profile.importIf osConfig "graphical" [
    ./librewolf.nix
    ./spotify.nix
    ./vesktop.nix
    ./vscode.nix
  ];
}

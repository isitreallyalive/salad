{
  self,
  osConfig,
  ...
}:

{
  imports = self.lib.profile.importIf osConfig "graphical" [
    ./spotify.nix
    ./vscode.nix
  ];
}

{
  pkgs,
  self,
  osConfig,
  ...
}:

{
  salad.packages = self.lib.profile.mkIf osConfig [ "gaming" ] {
    inherit (pkgs) prismlauncher;
  };
}

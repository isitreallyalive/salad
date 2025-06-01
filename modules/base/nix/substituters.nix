let
  # substituter: public key
  substituters = {
    # nix-community
    "https://nix-community.cachix.org" =
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=";
    # catppuccin ports
    "https://catppuccin.cachix.org" =
      "catppuccin.cachix.org-1:noG/4HkbhJb+lUAdKrph6LaozJvAeEEZj4N732IysmU=";
  };
in
{
  nix.settings = {
    substituters = builtins.attrNames substituters;
    trusted-public-keys = builtins.attrValues substituters;
  };
}

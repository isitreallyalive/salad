# `nix`/`nixpkgs` settings.
{ config, inputs, ... }:

let
  # substituter: public key
  substituters = {
    # nix-community cachix
    "https://nix-community.cachix.org" =
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=";
    # catppuccin ports cachix
    "https://catppuccin.cachix.org" =
      "catppuccin.cachix.org-1:noG/4HkbhJb+lUAdKrph6LaozJvAeEEZj4N732IysmU=";
  };
in
{
  nix.settings = {
    experimental-features = [
      # enable flakes
      "nix-command"
      "flakes"
    ];

    # substituters
    substituters = builtins.attrNames substituters;
    trusted-public-keys = builtins.attrValues substituters;

    auto-optimise-store = true;
    trusted-users = [
      "root"
      config.salad.users.main.name
    ];
  };

  # garbage collector
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 5d";
  };

  nixpkgs = {
    # allow propritetary software - it's near impossible to avoid!
    config.allowUnfree = true;
    overlays = [ inputs.vscode.overlays.default ];
  };
}

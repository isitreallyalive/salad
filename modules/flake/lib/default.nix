# Custom library for the salad flake.

{
  lib,
  inputs,
  ...
}:

{
  flake.lib = {
    profile = import ./profile.nix { inherit lib; };
    secrets = import ./secrets.nix { inherit inputs; };
    system = import ./system.nix { inherit lib; };
  };
}

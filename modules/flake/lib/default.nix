{ lib, _class, ... }:

{
  flake.lib = lib.fixedPoints.makeExtensible (final: {
    config = import ./config.nix { inherit lib _class; };

    inherit (final.config) mkIfProfile;
  });
}

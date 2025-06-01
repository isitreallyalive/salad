{
  lib,
  inputs,
  _class,
  ...
}:

{
  flake.lib = lib.fixedPoints.makeExtensible (final: {
    config = import ./config.nix { inherit lib _class; };
    secrets = import ./secrets.nix { inherit inputs; };

    inherit (final.config) mkIfProfile;
    inherit (final.secrets) mkUserSecret;
  });
}

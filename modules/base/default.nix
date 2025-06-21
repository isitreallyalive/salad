/*
  Entry point for the `base` module.

  The `base` module is to be imported at the beginning
  of any class module (e.g. `nixos`).
*/

{ self, config, ... }:

{
  imports = [
    ../../home # `home-manager`

    ./config # `salad` options

    ./acme.nix # acme client
    ./nix.nix # `nix` config
    ./users.nix # generate users
  ];

  system.stateVersion = config.salad.stateVersion;
  system.configurationRevision = self.shortRev or self.dirtyShortRev or "dirty";
}

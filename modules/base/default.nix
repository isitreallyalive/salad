{ self, config, ... }:

{
  imports = [
    ../../home # home-manager

    ./config # salad options

    ./nix.nix # nix configuration
    ./users.nix # user generation
  ];

  system.stateVersion = config.salad.stateVersion;
  system.configurationRevision = self.shortRev or self.dirtyShortRev or "dirty";
}

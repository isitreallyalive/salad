# Globally available programs on NixOS.

{
  self,
  config,
  pkgs,
  ...
}:

let
  inherit (self.lib) profile;
in
{
  imports = [
    ./alien.nix # `nix-alien`
    ./qemu.nix # `qemu`
  ];

  # kanidm client on workstations
  services.kanidm = {
    package = pkgs.kanidm_1_6;
    enableClient = profile.enabled config "workstation";
    clientSettings = profile.mkIf config "workstation" {
      uri = "https://lychee"; # `lychee` hosts kanidm
    };
  };
}

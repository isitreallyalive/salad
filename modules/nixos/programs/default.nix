# Globally available programs on NixOS.
{
  self,
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./alien.nix # `nix-alien`
    ./oci.nix # `docker` and `podman`
    ./qemu.nix # `qemu`
  ];

  salad.packages =
    let
      mkIf = profiles: self.lib.profile.mkIf config profiles;
      # install jdks when gaming (for minecraft) or on workstations
      jdks = mkIf [ "gaming" "workstation" ] {
        # minecraft requires:
        # - jdk 21 (1.20+)
        # - jdk 17 (1.18+)
        # - jdk 8 (older versions)
        inherit (pkgs) temurin-bin-21 temurin-bin-17 temurin-bin-8;
      };
      # install jetbrains when on workstations
      jetbrains = mkIf [ "workstation" ] (
        let
          ide = ide: ids: inputs.jetbrains.lib.${pkgs.system}.buildIdeWithPlugins pkgs.jetbrains ide ids;
        in
        {
          idea-ultimate = ide "idea-ultimate" [ ];
        }
      );
    in
    jdks // jetbrains;
}

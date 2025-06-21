# Globally available programs on NixOS.

{
  imports = [
    ./alien.nix # `nix-alien`
    ./qemu.nix # `qemu`
  ];
}

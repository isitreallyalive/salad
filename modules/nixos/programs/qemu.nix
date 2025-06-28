# Install `qemu`.

{ pkgs, ... }:

{
  salad.packages = {
    inherit (pkgs) qemu quickemu quickgui;
  };

  # uefi firmware support
  systemd.tmpfiles.rules = [ "L+ /var/lib/qemu/firmware - - - - ${pkgs.qemu}/share/qemu/firmware" ];
}

{ pkgs, inputs, ... }:

{
  salad.packages = {
    inherit (inputs.alien.packages.${pkgs.system}) nix-alien;
  };

  # `nix-alien-ld`
  programs.nix-ld.enable = true;
}

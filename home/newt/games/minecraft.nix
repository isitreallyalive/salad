{ pkgs, ... }:

let
  prism =
    with pkgs;
    prismlauncher.override {
      # other programs to add to PATH
      # additionalPrograms = [ ];

      jdks = [
        temurin-bin-21 # 1.20+
        temurin-bin-17 # 1.18+
        temurin-bin-8 # older versions
      ];
    };
in
{
  salad.packages = {
    inherit prism;
  };
}

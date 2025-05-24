{ inputs, ... }:

{
  imports = [ inputs.treefmt.flakeModule ];

  perSystem =
    { pkgs, config, ... }:
    {
      formatter = config.treefmt.build.wrapper;
      treefmt = {
        projectRootFile = "flake.nix";

        programs.nixfmt = {
          enable = true;
          package = pkgs.nixfmt-rfc-style;
        };
      };
    };
}

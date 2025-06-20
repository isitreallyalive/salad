# `nix develop` configuration.

{
  perSystem =
    {
      pkgs,
      self',
      config,
      ...
    }:
    {
      devShells.default = pkgs.mkShellNoCC {
        packages =
          (with pkgs; [
            gitMinimal # `git`
            just # task runner
            mkpasswd # password generator
            nix-output-monitor # clean diff between generations
            deploy-rs # deployment tool
          ])
          ++ [ self'.formatter ];

        inputsFrom = [ config.treefmt.build.devShell ];
      };
    };
}

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
        name = "dotfiles";
        meta.description = "Development shell for this configuration";

        packages =
          (with pkgs; [
            gitMinimal # git
            just # task runner
            mkpasswd # password generator
            nix-output-monitor # clean diff between generations
            deploy-rs
          ])
          ++ [ self'.formatter ];

        inputsFrom = [ config.treefmt.build.devShell ];
      };
    };
}

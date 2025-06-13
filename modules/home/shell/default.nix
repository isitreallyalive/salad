{ pkgs, ... }:

{
  imports = [
    # todo: carapace
    ./nushell.nix
    ./starship.nix
    ./utils.nix
  ];

  # `bash`
  programs.bash = {
    enable = true;
    bashrcExtra = ''
      if [ -t 1 ] && [ -z "$INSIDE_NUSHELL" ]; then
        export INSIDE_NUSHELL=1
        exec nu
      fi
    '';
  };

  # `git`
  programs.git = {
    enable = true;
    package = pkgs.gitMinimal;
    extraConfig = {
      init.defaultBranch = "main"; # default branch `main`
      push.autoSetupRemote = true; # auto remote
    };
  };
}

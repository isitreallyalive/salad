# Global shell configuration.

{ pkgs, ... }:

{
  imports = [
    # todo: carapace
    ./nushell.nix # `nu`shell
    ./starship.nix # pretty prompts
    ./utils.nix # util commands
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
    lfs.enable = true;
    extraConfig = {
      init.defaultBranch = "main"; # default branch `main`
      push.autoSetupRemote = true; # auto remote
    };
  };

  # `ssh-agent`
  services.ssh-agent.enable = true;
}

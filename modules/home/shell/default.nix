# Global shell configuration.

{
  imports = [
    # todo: carapace
    ./git.nix # `git` scm
    ./nushell.nix # `nu`shell
    ./ssh.nix # `ssh`
    ./starship.nix # pretty prompts
    ./utils.nix # util commands
  ];
}

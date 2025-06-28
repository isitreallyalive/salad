# Command line utilities.

{ pkgs, ... }:

let
  enable = {
    enable = true;
  };
  bash = {
    enableBashIntegration = true;
  };
  nushell = {
    enableNushellIntegration = true;
  };
  shells = bash // nushell;
in
{
  # direnv
  programs.direnv =
    enable
    // shells
    // {
      silent = true;
      nix-direnv.enable = true;
    };

  # fuzzy finder
  #
  # nushell integration may come soon
  # see: https://github.com/junegunn/fzf/issues/4122
  programs.fzf = enable // bash;

  # `vim`-like editor
  programs.helix = {
    enable = true;
    defaultEditor = true;
  };

  # command suggestions
  programs.pay-respects = enable // shells;

  # tldr `man` pages
  programs.tealdeer.enable = true;

  # replacements
  programs.bat.enable = true; # `cat`
  programs.eza = enable // shells; # `ls`
  programs.fd.enable = true; # `find`
  programs.ripgrep.enable = true; # `grep`
  programs.zoxide = enable // shells; # `cd`

  # others
  # todo: submit to nixpkgs?
  salad.packages = {
    inherit (pkgs)
      dogdns # `dig` replacement
      gping # `ping` but with a graph
      hexyl # hex viewer
      hyperfine # command line benchmarking tool
      oha # http benchmarking tool
      pastel # color manipulation
      procs # `ps` replacement
      sd # `sed` replacement
      tokei # cloc, scc, etc. replacement
      uutils-coreutils # rust rewrite of coreutils
      xh # `curl` replacement
      ;
  };
}

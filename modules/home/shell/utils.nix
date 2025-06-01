# todo: checkout
# - denisidoro/navi

{ pkgs, ... }:

let shellIntegration = {
  enable = true;
  enableBashIntegration = true;
  enableNushellIntegration = true;
}; in
{
  # syntax highlighting for diffs
  programs.git.delta.enable = true;

  # fuzzy finder
  programs.fzf = shellIntegration;

  # `vim`-like editor
  programs.helix = {
    enable = true;
    defaultEditor = true;
  };

  # command suggestions
  programs.pay-respects = shellIntegration;

  # tldr `man` pages
  programs.tealdeer.enable = true;

  # replacements
  programs.bat.enable = true; # `cat`
  programs.eza = shellIntegration; # `ls`
  programs.fd.enable = true; # `find`
  programs.ripgrep.enable = true; # `grep`
  programs.zoxide = shellIntegration; # `cd`

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
      uutils-coreutils-noprefix # rust rewrite of coreutils
      xh # `curl` replacement
      ;
  };
}

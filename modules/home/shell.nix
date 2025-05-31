{ pkgs, ... }:

{
  # set up nushell
  programs.nushell = {
    enable = true;

    # todo: carapace
    # todo: starship

    shellAliases = {
      cat = "bat";
      cd = "z";
      cloc = "tokei";
      dig = "dog";
      find = "fd";
      fuck = "f";
      grep = "rg";
      hex = "hexyl";
      ls = "eza";
      ping = "gping";
      ps = "procs";
      scc = "tokei";
      sed = "sd";
      v = "hx";
      vi = "hx";
    };
  };

  # useful command line utils
  # todo: checkout:
  # - denisidoro/navi
  salad.packages = {
    inherit (pkgs)
      bat # `cat` with syntax highlighting
      delta # syntax highlighting for diffs
      dogdns # `dig` replacement
      eza # `ls` replacement
      fd # `find` replacement
      fzf # fuzzy finder
      gping # `ping` but with a graph
      helix # `vim`-like editor
      hexyl # hex viewer
      hyperfine # command line benchmarking tool
      oha # http benchmarking tool
      pastel # color manipulation
      pay-respects # command suggestions
      procs # `ps` replacement
      ripgrep # `grep` replacement
      sd # `sed` replacement
      tealdeer # `tldr` replacement
      tokei # cloc, scc, etc. replacement
      uutils-coreutils-noprefix # rust rewrite of coreutils
      xh # `curl` replacement
      zoxide # `cd` replacement
      ;
  };
}

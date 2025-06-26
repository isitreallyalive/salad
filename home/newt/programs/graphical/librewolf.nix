{ pkgs, ... }:

{
  programs.librewolf.profiles.newt.extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
    # catppuccin theming
    catppuccin-mocha-mauve
    catppuccin-web-file-icons

    # cookie manager
    cookie-quick-manager
    # count lines of code on github
    gloc
    # quicker videos by skipping silence
    jump-cutter
    # notice lovely forks on github
    lovely-forks
    # react dev tools
    react-devtools
    # tetr.io+
    tetrio-plus
  ];

  # todo: custom engines
  # - nixpkgs
  # - extranix home-manager opts
  # - docs.rs
  # - crates.io
}

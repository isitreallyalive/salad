{
  nix.settings.experimental-features = [
    # flakes
    "nix-command"
    "flakes"

    # ragenix
    "recursive-nix"
  ];

  nixpkgs.config.allowUnfree = true;
}

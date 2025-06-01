{
  imports = [
    ./substituters.nix
  ];

  nix.settings.experimental-features = [
    # flakes
    "nix-command"
    "flakes"

    # agenix
    "recursive-nix"
  ];

  nixpkgs.config.allowUnfree = true;
}

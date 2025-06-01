{
  imports = [
    ./old-hardware.nix
  ];

  salad = {
    stateVersion = "25.11";

    profiles = {
      server = true;
    };
  };
}

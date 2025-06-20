# Home server. Runs media services.

{
  imports = [
    ./old-hardware.nix
  ];

  salad = {
    stateVersion = "25.11";

    profiles = {
      server = true;
    };

    deploy.remote = true;
  };
}

/*
  Oracle Cloud VM. Runs Caddy and Kanidm, and forwards
  traffic to the home server over the tailnet.
*/

{
  imports = [
    ./old-hardware.nix

    ./kanidm.nix
  ];

  salad = {
    stateVersion = "25.11";

    profiles = {
      server = true;
    };
  };
}

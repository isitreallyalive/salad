/*
  Oracle Cloud VM. Runs Caddy and Kanidm, and forwards
  traffic to the home server over the tailnet.
*/

{
  imports = [
    ./old-hardware.nix

    ./nginx.nix
    ./kanidm.nix
  ];

  users.groups.auth.members = [
    "nginx"
    "kanidm"
  ];

  salad = {
    stateVersion = "25.11";

    profiles = {
      server = true;
    };

    domains = {
      "auth.redstone.observer".group = "auth";
    };
  };
}

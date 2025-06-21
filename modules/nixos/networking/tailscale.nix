/*
  `tailscale` configuration.

  Automatically enrolls the machine into the tailnet using an auth key.
  The auth key is stored in an age-encrypted file, which is generated
  using the `agenix` tool.
*/

{
  pkgs,
  config,
  self,
  ...
}:

{
  # tailscale service
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "both";
    openFirewall = true;
    authKeyFile = config.age.secrets.tailscale.path;
  };

  age.secrets = {
    tailscale = self.lib.secrets.mkSecret "tailscale";
  };

  # cli
  salad.packages = {
    inherit (pkgs) tailscale;
  };

  # firewall
  networking.firewall.trustedInterfaces = [ "tailscale0" ];
}

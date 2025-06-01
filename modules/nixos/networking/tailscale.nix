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
    tailscale = self.lib.mkUserSecret "tailscale";
  };

  # cli
  salad.packages = {
    inherit (pkgs) tailscale;
  };

  # firewall
  networking.firewall.trustedInterfaces = [ "tailscale0" ];
}

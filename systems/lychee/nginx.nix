# todo: replace with sozu

{
  services.nginx =
    let
      auth = "auth.redstone.observer";
    in
    {
      enable = true;
      virtualHosts.${auth} = {
        addSSL = true;
        useACMEHost = auth;
        locations."/".proxyPass = "https://localhost:8443";
      };
    };
}

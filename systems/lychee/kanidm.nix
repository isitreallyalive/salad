{ self, config, ... }:

let
  rootDomain = "redstone.observer";
  domain = "auth.${rootDomain}";
in
self.lib.acme.mkCert config domain "cf/${rootDomain}" "kanidm"
// {
  services.kanidm = {
    enableServer = true;
    serverSettings =
      let
        cert = "/var/lib/acme/${domain}";
      in
      {
        inherit domain;
        origin = "https://${domain}";
        tls_key = "${cert}/key.pem";
        tls_chain = "${cert}/fullchain.pem";
      };
  };
}

{
  pkgs,
  config,
  self,
  ...
}:

{
  services.kanidm = {
    # server
    enableServer = true;
    serverSettings =
      let
        domain = "auth.redstone.observer";
        cert = "/var/lib/acme/${domain}";
      in
      {
        inherit domain;
        origin = "https://${domain}";
        tls_key = "${cert}/key.pem";
        tls_chain = "${cert}/fullchain.pem";
      };

    # local client
    enableClient = true;
    clientSettings.uri = "https://localhost:8443";

    # provisioning
    package = pkgs.kanidmWithSecretProvisioning;
    provision =
      let
        inherit (config.age) secrets;
      in
      {
        enable = true;
        adminPasswordFile = secrets."kanidm/admin".path;
        idmAdminPasswordFile = secrets."kanidm/idm-admin".path;
      };
  };

  age.secrets =
    let
      config = {
        owner = "kanidm";
      };
    in
    self.lib.secrets {
      "kanidm/admin" = config;
      "kanidm/idm-admin" = config;
    };
}

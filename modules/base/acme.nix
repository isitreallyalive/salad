## Configures the ACME client for obtaining SSL certificates
# todo: migrate away from cloudflare

{
  config,
  lib,
  self,
  ...
}:

let
  inherit (config.salad) domains;
  inherit (self.lib) secrets;

  # helper function to get the root domain from a full domain name
  getRootDomain =
    domain:
    let
      parts = lib.splitString "." domain;
    in
    if (builtins.length parts) > 2 then lib.concatStringsSep "." (lib.tail parts) else domain;
in
{
  # acme configuration
  security.acme = {
    acceptTerms = true;
    defaults.email = config.salad.users.main.email;

    certs = builtins.mapAttrs (domain: data: {
      inherit (data) group;
      dnsProvider = "cloudflare";
      credentialFiles =
        let
          inherit (config.age) secrets;
        in
        {
          CF_ZONE_API_TOKEN_FILE = secrets.cf-zone.path;
          CF_DNS_API_TOKEN_FILE = secrets."cf-${domain}".path;
        };
    }) domains;
  };

  # cloudflare tokens
  age.secrets =
    (lib.mkIf ((builtins.length (builtins.attrNames domains)) > 0) {
      cf-zone = secrets.mkSecret "cf/zone";
    })
    // lib.mapAttrs' (domain: _: {
      name = "cf-${domain}";
      value = secrets.mkSecret "cf/${getRootDomain domain}";
    }) domains;
}

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

  # helper function to get the root domain from a full domain name
  getRootDomain =
    domain:
    let
      parts = lib.splitString "." domain;
    in
    if (builtins.length parts) > 2 then lib.concatStringsSep "." (lib.tail parts) else domain;

  # get unique root domains
  rootDomains = lib.unique (lib.mapAttrsToList (domain: _: getRootDomain domain) domains);
in
{
  # cloudflare tokens
  age.secrets =
    let
      inherit (self.lib) secrets;
    in
    # only include zone token if there are domains
    (lib.mkIf ((builtins.length rootDomains) > 0) {
      cf-zone = secrets.mkSecret "cf/zone";
    })
    # add domain-specific tokens
    // builtins.listToAttrs (
      map (root: {
        name = "cf-${root}";
        value = secrets.mkSecret "cf/${root}";
      }) rootDomains
    );

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
          CF_DNS_API_TOKEN_FILE = secrets."cf-${getRootDomain domain}".path;
        };
    }) domains;
  };
}

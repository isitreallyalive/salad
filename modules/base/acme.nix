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
      # only include zone token if there are domains
      domainsExist = (builtins.length rootDomains) > 0;
      zoneToken = lib.optionalAttrs domainsExist {
        "cf/zone" = { };
      };
      # add domain-specific tokens
      domainTokens = builtins.listToAttrs (
        map (root: {
          name = "cf/${root}";
          value = { };
        }) rootDomains
      );
      tokens = zoneToken // domainTokens;
    in
    self.lib.secrets tokens;

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
          CF_ZONE_API_TOKEN_FILE = secrets."cf/zone".path;
          CF_DNS_API_TOKEN_FILE = secrets."cf-${getRootDomain domain}".path;
        };
    }) domains;
  };
}

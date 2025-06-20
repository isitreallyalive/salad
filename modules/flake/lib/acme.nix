{ secrets }:

{
  /**
    Configure ACME certificate issuance for a domain managed by Cloudflare.

    # Type

    ```
    mkCert :: AttrSet -> String -> String -> String -> AttrSet
    ```

    # Arguments

    config
    : The NixOS configuration attribute set.

    domain
    : The domain for which to issue the certificate.

    secret
    : The secret identifier or path for the Cloudflare API token.

    group
    : The group under which the ACME certificate will be managed.

    # Returns

    An attribute set containing the configuration for the ACME certificate issuance.
  */
  mkCert = config: domain: secret: group: {
    # load the secrets
    age.secrets.cf-zone = secrets.mkUser "cf/zone";
    age.secrets."cf-${domain}" = secrets.mkUser secret;

    # define the certificate configuration
    security.acme.certs.${domain} = {
      inherit group;
      dnsProvider = "cloudflare";
      credentialFiles = {
        CF_ZONE_API_TOKEN_FILE = config.age.secrets.cf-zone.path;
        CF_DNS_API_TOKEN_FILE = config.age.secrets."cf-${domain}".path;
      };
    };
  };
}

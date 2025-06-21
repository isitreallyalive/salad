{ lib, ... }:

let
  inherit (lib) mkOption types;
in
{
  options.salad.domains = mkOption {
    type = types.attrsOf (
      types.submodule {
        options = {
          group = mkOption {
            type = types.str;
            description = "Group to which the certificate belongs.";
          };
        };
      }
    );
    default = { };
    description = "Domains to be managed by the ACME client.";
  };
}

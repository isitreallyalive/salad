{ lib, config, _class }:

let
  inherit (builtins) attrValues;
  inherit (lib) optionalAttrs types;
in
{
  options.salad.packages = lib.mkOption {
    type = types.attrsOf types.package;
    default = { };
    description = "Packages to be installed in the system profile.";
  };

  config = lib.mergeAttrsList [
    (optionalAttrs (_class == "nixos") {
      environment.systemPackages = attrValues config.salad.packages;
    })

    (optionalAttrs (_class == "home") {
      home.packages = attrValues config.salad.packages;
    })
  ];
}
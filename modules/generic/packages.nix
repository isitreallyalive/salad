# Install packages in the system or home profile.

{
  lib,
  config,
  _class,
  ...
}:

let
  inherit (builtins) attrValues;
  inherit (lib) optionalAttrs types;
in
{
  # define the option
  options.salad.packages = lib.mkOption {
    type = types.attrsOf types.package;
    default = { };
    description = "Packages to be installed in the system profile.";
  };

  # add the packages to the system or home profile
  config = lib.mergeAttrsList [
    (optionalAttrs (_class == "nixos") {
      environment.systemPackages = attrValues config.salad.packages;
    })

    (optionalAttrs (_class == "homeManager") {
      home.packages = attrValues config.salad.packages;
    })
  ];
}

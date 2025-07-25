# `deploy-rs` configuration.

{
  lib,
  self,
  inputs,
  config,
  ...
}:

let
  inherit (lib.attrsets) filterAttrs;

  # all of the deployable systems
  deployableSystems = builtins.attrNames (
    filterAttrs (_: attrs: attrs.deployable) config.easy-hosts.hosts
  );

  # get the `easy-hosts` from the `nixosConfigurations` that are deployable
  easyHostsFromDeployableSystems = filterAttrs (
    name: _: builtins.elem name deployableSystems
  ) self.nixosConfigurations;
in
{
  flake.deploy = {
    autoRollback = true;
    magicRollback = true;

    # create a list of nodes that we want to deploy that we
    # can pass to the deploy configuration
    nodes = builtins.mapAttrs (name: node: {
      hostname = name;
      profiles.system = {
        user = "root";
        sshUser = "root";
        remoteBuild = node.config.salad.deploy.remote;
        path = inputs.deploy-rs.lib.${config.easy-hosts.hosts.${name}.system}.activate.nixos node;
      };
    }) easyHostsFromDeployableSystems;
  };
}

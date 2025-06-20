# `agenix` configuration.

let
  # users permitted to access secrets and their public keys
  users = {
    newt = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIENpe82Cp9F0/faLQu5sl8u76JCTMuOinY455jaIuPsY";
  };

  # hosts and their public keys
  # the `owner` field determines which user can access the host's secrets
  # when configuring
  hosts = {
    blueberry = {
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE/H968SrIhfBGk7R1HFHBjWQkQc4SQXjdO+NQQL/+Jn";
      owner = "newt";
    };
    cherry = {
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHyG81iNDCrBoU0BOFC4koSpr2LZPuE87dJnKg7kicQ9";
      owner = "newt";
    };
    lychee = {
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOJLT1ohqkTC5PNDUswaFkXO64afdlXCRIKX350sZBvg";
      owner = "newt";
    };
  };

  # define host types. mirrors that inside the main flake.
  types = with hosts; {
    workstations = [
      cherry
    ];
    servers = [
      blueberry
      lychee
    ];
  };

  # helper function to define access policies for secrets
  access =
    hosts: urs:
    let
      listcombined = hosts;
      filtered = builtins.filter (host: builtins.any (x: host.owner == x) urs) listcombined;
      keys = builtins.map (host: host.key) filtered;
    in
    {
      publicKeys = keys ++ map (user: users.${user}) urs;
    };

  # common case: all hosts for given types, for user "newt"
  accessNewt = hosts: access hosts [ "newt" ];
in
{
  # git ssh keys
  "keys/gh.age" = accessNewt (types.workstations ++ types.servers);
  "keys/gh-pub.age" = accessNewt (types.workstations ++ types.servers);

  # tailscale auth key
  # expires: 30/08/2025
  "tailscale.age" = accessNewt (builtins.attrValues hosts);

  ## cloudflare API tokens
  "cf/zone.age" = accessNewt types.servers;
  "cf/redstone.observer.age" = accessNewt [ hosts.lychee ];
}

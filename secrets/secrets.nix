let
  users = {
    newt = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIENpe82Cp9F0/faLQu5sl8u76JCTMuOinY455jaIuPsY";
  };

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

  types = with hosts; {
    workstations = [
      cherry
    ];
    servers = [
      blueberry
      lychee
    ];
  };

  defAccess =
    hostType: urs:
    let
      listcombined = hostType;
      filtered = builtins.filter (host: builtins.any (x: host.owner == x) urs) listcombined;
      keys = builtins.map (host: host.key) filtered;
    in
    {
      publicKeys = keys ++ map (user: users.${user}) urs;
    };

  defAccessNewt = hostType: defAccess hostType [ "newt" ];
in
{
  # git ssh keys
  "keys/gh.age" = defAccessNewt (types.workstations ++ types.servers);
  "keys/gh-pub.age" = defAccessNewt (types.workstations ++ types.servers);

  # tailscale auth key
  # expires: 30/08/2025
  "tailscale.age" = defAccessNewt (builtins.attrValues hosts);
}

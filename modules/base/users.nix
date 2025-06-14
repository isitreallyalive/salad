{
  pkgs,
  lib,
  config,
  ...
}:

{
  users.mutableUsers = false;

  users.users =
    let
      inherit (config.salad.users) rootPassword main others;

      configureUser = user: {
        isNormalUser = true;
        description = user.name;
        extraGroups = user.groups ++ [ "networkmanager" ] ++ (lib.optional user.sudo "wheel");
        hashedPassword = user.password;
      };
    in
    {
      root.hashedPassword = rootPassword;
      ${main.name} = configureUser main;
    }
    // (lib.listToAttrs (
      map (user: {
        name = user.name;
        value = configureUser user;
      }) others
    ));
}

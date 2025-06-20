# Generate all configured users for the system.

{
  lib,
  config,
  ...
}:

{
  # don't allow users to be modified by anything other than this module
  users.mutableUsers = false;

  users.users =
    let
      inherit (config.salad.users) rootPassword main others;

      configureUser = user: {
        isNormalUser = true;
        description = user.name;
        # every user should have network access, so they need the
        # `networkmanager` group.
        extraGroups = user.groups ++ [ "networkmanager" ] ++ (lib.optional user.sudo "wheel");
        hashedPassword = user.password;
      };
    in
    {
      root.hashedPassword = rootPassword; # set the root password
      ${main.name} = configureUser main; # configure the main user
    }
    # configure the rest of the users
    // (lib.listToAttrs (
      map (user: {
        name = user.name;
        value = configureUser user;
      }) others
    ));
}

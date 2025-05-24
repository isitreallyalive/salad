{ lib, config, ... }:

let
  inherit (lib) mkOption types;

  user = types.submodule {
    options = {
      name = mkOption {
        type = types.str;
        description = "The user's username.";
      };
      password = mkOption {
        type = types.str;
        description = "A hashed copy of the user's password";
      };
      groups = mkOption {
        type = types.listOf types.str;
        default = [ ];
        description = ''
          The groups that the user belongs to. The following are automatically assigned to every user:
            - `networkmanager`;
        '';
      };
      sudo = mkOption {
        type = types.bool;
        default = false;
        description = "Whether the user should be able to use sudo.";
      };
    };
  };

  newtPassword = "$y$j9T$liz5fmnsRjJ6dFJDjcNm./$nVR5wvUUHlakTdXZQXZcGCzNcJ8hZ9xVGJuoz8pNFW5";
in
{
  options.salad.users = {
    rootPassword = mkOption {
      type = types.str;
      default = newtPassword;
      description = "The root user's password.";
    };
    main = mkOption {
      type = user;
      default = {
        name = "newt";
        password = newtPassword;
      };
      description = "The primary user on the system.";
    };
    others = mkOption {
      type = types.listOf user;
      default = [ ];
      description = "Secondary users on the system.";
    };
  };

  config = {
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
  };
}

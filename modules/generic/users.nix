# Describe attributes about users to be used when configuring in the `base` module.

{
  lib,
  ...
}:

let
  inherit (lib) mkOption types;

  sshHost = types.submodule {
    options = {
      hostname = mkOption {
        type = types.str;
        description = "The hostname of the SSH host.";
      };
      user = mkOption {
        type = types.str;
        description = "The username to use when connecting to the SSH host.";
        default = "root";
      };
      secret = mkOption {
        type = types.str;
        description = "The name of the secret containing the SSH key in the `age.secrets` configuration.";
      };
      pass = mkOption {
        type = types.bool;
        default = false;
        description = "Whether the SSH key has a passphrase.";
      };
    };
  };

  user = types.submodule {
    options = {
      name = mkOption {
        type = types.str;
        description = "The user's username.";
      };
      email = mkOption {
        type = types.str;
        description = "The user's primary email address. Used for git and ACME.";
      };
      password = mkOption {
        type = types.str;
        description = "A hashed copy of the user's password";
      };
      sudo = mkOption {
        type = types.bool;
        default = false;
        description = "Whether the user should be able to use sudo.";
      };
      groups = mkOption {
        type = types.listOf types.str;
        default = [ ];
        description = ''
          The groups that the user belongs to. The following are automatically assigned to every user:
            - `networkmanager`;
        '';
      };

      git.name = mkOption {
        type = types.str;
        description = "The user's git username.";
      };
      ssh.hosts = mkOption {
        type = types.listOf sshHost;
        default = [ ];
      };
    };
  };

  newt = {
    name = "newt";
    email = "hi@newty.dev";
    password = "$y$j9T$liz5fmnsRjJ6dFJDjcNm./$nVR5wvUUHlakTdXZQXZcGCzNcJ8hZ9xVGJuoz8pNFW5";
    sudo = true;

    git.name = "newt";
    ssh.hosts = [
      {
        hostname = "github.com";
        user = "git";
        secret = "gh";
        pass = true;
      }
    ];
  };
in
{
  options.salad.users = {
    rootPassword = mkOption {
      type = types.str;
      default = newt.password;
      description = "The root user's password.";
    };
    main = mkOption {
      type = user;
      default = newt;
      description = "The primary user on the system.";
    };
    others = mkOption {
      type = types.listOf user;
      default = [ ];
      description = "Secondary users on the system.";
    };
  };
}

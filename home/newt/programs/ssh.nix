{ config, ... }:

let
  inherit (config.age) secrets;
in
{
  programs.ssh = {
    enable = true;

    hashKnownHosts = true;
    compression = true;

    matchBlocks = {
      # git clients
      "github.com" = {
        user = "git";
        hostname = "github.com";
        identityFile = secrets.keys-gh.path;
      };
    };
  };
}

{ config, ... }:

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
        identityFile = config.age.secrets.keys-gh.path;
      };
    };
  };
}

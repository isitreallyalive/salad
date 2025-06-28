{ config, self, ... }:

{
  # `ssh`
  programs.ssh = {
    enable = true;
    hashKnownHosts = true;
    compression = true;

    matchBlocks = {
      "github.com" = {
        user = "git";
        hostname = "github.com";
        identityFile = config.age.secrets."ssh/gh".path;
      };
    };
  };

  age.secrets = self.lib.secrets {
    "ssh/gh" = { };
  };
}

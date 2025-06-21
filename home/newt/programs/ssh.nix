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
        identityFile = config.age.secrets.keys.gh.path;
      };
    };
  };

  age.secrets = {
    keys.gh = self.lib.secrets.mkSecret "gh";
  };
}

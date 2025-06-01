{ self, ... }:

let
  inherit (self.lib) mkUserSecret;
in
{
  age.secrets = {
    # git ssh keys
    keys-gh = mkUserSecret "keys/gh";
    keys-gh-pub = mkUserSecret "keys/gh-pub";
  };
}

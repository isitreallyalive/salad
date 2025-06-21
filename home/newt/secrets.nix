{ self, ... }:

let
  inherit (self.lib) secrets;
in
{
  age.secrets = {
    # git ssh keys
    keys-gh = secrets.mkSecret "keys/gh";
    keys-gh-pub = secrets.mkSecret "keys/gh-pub";
  };
}

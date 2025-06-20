{ self, ... }:

let
  inherit (self.lib) secrets;
in
{
  age.secrets = {
    # git ssh keys
    keys-gh = secrets.mkUser "keys/gh";
    keys-gh-pub = secrets.mkUser "keys/gh-pub";
  };
}

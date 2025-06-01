{ inputs }:

let
  inherit (inputs) self;
in
{
  /**
    * Create a user secret to use with `ragenix`.
    *
    * @param file - the age file to use for the secret
  */
  mkUserSecret = file: {
    file = "${self}/secrets/${file}.age";
    mode = "400";
  };
}

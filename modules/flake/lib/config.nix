{ lib, ... }:

{
  /**
    * Constructs a value if a specific profile is enabled.
    *
    * @param config - The Nix configuration.
    * @param profile - The profile to check.
    * @param value - The value to construct if the profile is enabled.
    *
    * @returns - A value that is only present if the specified profile is enabled.
  */
  mkIfProfile =
    config: profile: value:
    lib.mkIf config.salad.profiles.${profile} value;
}

{ lib, ... }:

rec {
  /**
    Whether the specified profile is enabled.

    # Type

    ```
    enabled :: AttrSet -> String -> Bool
    ```

    # Arguments

    config
    : The NixOS configuration attribute set.

    profile
    : The name of the profile to check.
  */
  enabled = config: profile: config.salad.profiles.${profile} or false;

  /**
    Set a value if the specified profile is enabled.

    # Type

    ```
    mkIf :: AttrSet -> String -> a
    ```

    # Arguments

    config
    : The NixOS configuration attribute set.

    profile
    : The name of the profile to check.

    value
    : The value to set if the profile is enabled.
    ```
  */
  mkIf =
    config: profile: value:
    lib.mkIf (enabled config profile) value;
}

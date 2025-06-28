{ lib, ... }:

let
  inherit (lib) any;
in
rec {
  /**
    Check if any of the specified profiles are enabled.

    # Type

    ```
    enabled :: AttrSet -> [String] -> Bool
    ```

    # Arguments

    config
    : The NixOS configuration attribute set.

    profiles
    : A list of profile names to check.
  */
  enabled = config: profiles: any (profile: config.salad.profiles.${profile} or false) profiles;

  /**
    Set a value if any of the specified profiles are enabled.

    # Type

    ```
    mkIf :: AttrSet -> [String] -> a -> a
    ```

    # Arguments

    config
    : The NixOS configuration attribute set.

    profiles
    : A list of profile names to check.

    value
    : The value to set if the profile is enabled.
  */
  mkIf =
    config: profiles: value:
    lib.mkIf (enabled config profiles) value;

  /**
    Import a set of modules if any of the specified profiles are enabled.

    # Type

    ```
    importIf :: AttrSet -> [String] -> [Module] -> [Module]
    ```

    # Arguments

    config
    : The NixOS configuration attribute set.

    profiles
    : A list of profile names to check.

    imports
    : A list of modules to import if the profile is enabled.
  */
  importIf =
    config: profiles: imports:
    lib.optionals (enabled config profiles) imports;
}

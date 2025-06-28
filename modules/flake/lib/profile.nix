{ lib, ... }:

let
  inherit (lib) any;
in
rec {
  /**
    Check if the specified profile is enabled.

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
    Check if any of the specified profiles are enabled.

    # Type

    ```
    anyEnabled :: AttrSet -> [String] -> Bool
    ```

    # Arguments

    config
    : The NixOS configuration attribute set.

    profiles
    : A list of profile names to check.
  */
  anyEnabled = config: profiles: any (profile: enabled config profile) profiles;

  /**
    Set a value if any of the specified profiles are enabled.

    # Type

    ```
    mkIf :: AttrSet -> [String] -> a
    ```

    # Arguments

    config
    : The NixOS configuration attribute set.

    profiles
    : A list of profile names to check.

    value
    : The value to set if the profile is enabled.
    ```
  */
  mkIf =
    config: profiles: value:
    lib.mkIf (anyEnabled config profiles) value;

  /**
    Import a set of modules if any of the specified profiles are enabled.

    # Type

    ```
    importIf :: AttrSet -> [String] -> [Module]
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
    lib.optionals (anyEnabled config profiles) imports;
}

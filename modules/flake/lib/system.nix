{ lib, ... }:

rec {
  /**
    Whether the given system is being built.

    # Type

    ```
    oneOf :: AttrSet -> [String] -> Bool
    ```

    # Arguments

    config
    : The NixOS configuration attribute set.

    systems
    : A list of prospective hostnames to check against.
  */
  oneOf = config: systems: builtins.elem config.networking.hostName systems;

  /**
    Set a value if the specified system is being built.

    # Type

    ```
    mkIf :: AttrSet -> [String] -> a -> a
    ```

    # Arguments

    config
    : The NixOS configuration attribute set.

    systems
    : A list of prospective hostnames to check against.

    value
    : The value to set if the system is being built.
  */
  mkIf =
    config: systems: value:
    lib.mkIf (oneOf config systems) value;
}

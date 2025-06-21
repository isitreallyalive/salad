{ inputs }:

rec {
  /**
    Make a user secret with `agenix`.

    # Type

    ```
    mkUser :: String -> AttrSet
    ```

    # Arguments

    file
    : The name of the file in the `secrets` directory, without the `.age` extension.

    # Returns

    An attribute set that can be used in a NixOS configuration to create a secret file.
  */
  mkSecret = file: {
    file = "${inputs.self}/secrets/${file}.age";
    mode = "400";
  };

  /**
    Make a user secret with `agenix`, with a custom owner.

    # Type

    ```
    mkCustom :: String -> String -> AttrSet
    ```

    # Arguments

    file
    : The name of the file in the `secrets` directory, without the `.age` extension.

    user
    : The user that should own the secret file.

    # Returns

    An attribute set that can be used in a NixOS configuration to create a secret file with a custom owner.
  */
  mkCustom =
    file: user:
    (mkSecret file)
    // {
      owner = user;
      group = user;
    };
}

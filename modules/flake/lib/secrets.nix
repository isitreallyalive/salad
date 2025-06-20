{ inputs }:

{
  /**
    Make a user secret with `agenix`.

    # Type

    ```
    mkUser :: String -> AttrSet
    ```

    # Arguments

    file
    : The name of the file in the `secrets` directory, without the `.age` extension.
  */
  mkUser = file: {
    file = "${inputs.self}/secrets/${file}.age";
    mode = "400";
  };
}

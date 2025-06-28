# Custom library for the salad flake.

{
  lib,
  inputs,
  ...
}:

{
  flake.lib = {
    profile = import ./profile.nix { inherit lib; };

    /**
      Transform secrets configuration into agenix-compatible format.

      # Type

      ```
      secrets :: AttrSet -> AttrSet
      ```

      # Arguments

      secrets
      : An attribute set where keys are secret file names and values are configuration objects.

      # Configuration object attributes

      - `name` (optional): Override the secret name (defaults to the file name)
      - `mode` (optional): File permissions mode (defaults to "400")
      - `owner` (optional): File owner (when set, also sets group to the same value)

      # Example

      ```nix
      secrets {
        "database-password" = {
          name = "db_pass";
          mode = "600";
          owner = "postgres";
        };
        "api-key" = {}; # uses defaults
      }
      ```
    */
    secrets =
      secrets:
      lib.mapAttrs' (file: data: {
        name = data.name or file;
        value =
          {
            mode = data.mode or "400";
            file = "${inputs.self}/secrets/${file}.age";
          }
          // lib.optionalAttrs (data ? owner) {
            inherit (data) owner;
            group = data.owner;
          };
      }) secrets;
  };
}

{ lib, ... }:

let
  inherit (lib) mkOption types;
in
{
  options.salad.displays = mkOption {
    type = types.listOf (
      types.submodule {
        options = {
          name = mkOption {
            type = types.str;
            description = "Name of the display.";
          };
          width = mkOption {
            type = types.int;
            default = 1920;
            description = "Width of the display in pixels.";
          };
          height = mkOption {
            type = types.int;
            default = 1080;
            description = "Height of the display in pixels.";
          };
          refreshRate = mkOption {
            type = types.int;
            default = 60;
            description = "Refresh rate of the display in Hz.";
          };
        };
      }
    );

    default = [ ];
    description = "List of displays to configure.";
  };
}

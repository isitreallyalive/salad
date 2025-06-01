{ self, inputs, ... }:

{
  imports = [ inputs.easy-hosts.flakeModule ];

  easy-hosts = {
    perClass = class: {
      # import the class module. this contains common configurations between all systems.
      modules = [ "${self}/modules/${class}/default.nix" ];
    };

    # defaults:
    #  arch = "x86_64";
    #  class = "nixos";
    #  deployable = false;
    #  modules = [ ];
    #  specialArgs = { };
    hosts = {
      # todo: apple
      # todo: blueberry
      cherry = { };

      lychee = {
        arch = "aarch64";
        deployable = true;
      };
    };
  };
}

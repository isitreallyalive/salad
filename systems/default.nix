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
    #  modules = [ ];
    #  specialArgs = { };
    hosts = {
      # todo: apple
      # todo: blueberry
      cherry = { };
    };
  };
}

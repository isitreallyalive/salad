{ lib, self, self', config, inputs, inputs', ... }:

{
  home-manager = {
    verbose = true;
    useUserPackages = true;
    useGlobalPkgs = true;
    backupFileExtension = "bak";

    # todo: user-specific configuration
    users = { newt = { }; };

    extraSpecialArgs = {
      inherit self self' inputs inputs';
    };

    # common home-manager configuration
    sharedModules = [ (self + /modules/home/default.nix) ];
  };
}
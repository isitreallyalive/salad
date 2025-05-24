{
  self,
  self',
  inputs,
  inputs',
  ...
}:

{
  home-manager = {
    verbose = true;
    useUserPackages = true;
    useGlobalPkgs = true;
    backupFileExtension = "bak";

    # todo: generate automatically for all users
    users.newt = {
      imports = [ ./newt ];
    };

    extraSpecialArgs = {
      inherit
        self
        self'
        inputs
        inputs'
        ;
    };

    # common home-manager configuration
    sharedModules = [
      (self + /modules/home/default.nix)
      inputs.catppuccin.homeModules.catppuccin
    ];
  };
}

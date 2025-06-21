{
  lib,
  config,
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

    # user specific configuration
    users =
      let
        inherit (config.salad.users) main others;
        allUsers = [ main ] ++ others;
        userConfigs = lib.listToAttrs (
          map (user: {
            name = user.name;
            value = {
              # allow for the user not to have home-manager configuration
              imports = lib.optional (builtins.pathExists ./${user.name}) ./${user.name};

              # git user configuration
              programs.git = {
                userName = user.gitName;
                userEmail = user.email;
              };
            };
          }) allUsers
        );
      in
      userConfigs;

    extraSpecialArgs = {
      inherit
        self
        self'
        inputs
        inputs'
        ;
    };

    # common home-manager configuration
    sharedModules =
      [
        (self + /modules/home/default.nix)
      ]
      ++ (with inputs; [
        agenix.homeManagerModules.default
        catppuccin.homeModules.catppuccin
        plasma-manager.homeManagerModules.plasma-manager
      ]);
  };
}

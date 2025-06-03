{ config, ... }:

{
  imports = [
    ./substituters.nix
  ];

  nix.settings = {
    experimental-features = [
    "nix-command"
    "flakes"
  ];

  trusted-users = [
    "root"
    config.salad.users.main.name
  ];
  
  };

  nixpkgs.config.allowUnfree = true;

}

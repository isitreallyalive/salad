{
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/London";

  users.users.newt = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  environment.systemPackages = with pkgs; [
    curl
    git
  ];

  services.openssh.enable = true;
  users.users.root.openssh.authorizedKeys.keys = [
    "<ssh key>"
  ];

  system.stateVersion = "25.11";
}

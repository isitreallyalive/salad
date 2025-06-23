{
  pkgs,
  inputs,
  config,
  ...
}:

{
  imports =
    [
      ../base

      ./networking
      ./programs
      ./sddm # sddm config

      ./boot.nix # boot config
      ./fonts.nix # fonts
    ]
    ++ (with inputs; [
      lix.nixosModules.default
      agenix.nixosModules.default
      catppuccin.nixosModules.catppuccin
      home-manager.nixosModules.home-manager
    ]);

  # configuration.nix
  # todo: sort
  networking.networkmanager.enable = true;
  time.timeZone = if config.salad.profiles.server then "UTC" else "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };
  services.xserver.xkb = {
    layout = "gb";
    variant = "";
  };
  console.keyMap = "uk";

  salad.packages = {
    # agenix cli
    inherit (inputs.agenix.packages.${pkgs.system}) default;
    # make sure nushell is accessible in the bashrc
    inherit (pkgs) nushell;
  };

  # catppuccin config
  catppuccin.flavor = "mocha";
  catppuccin.accent = "mauve";
}

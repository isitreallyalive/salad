# Laptop.

{
  imports = [
    ./old-hardware.nix
  ];

  salad = {
    stateVersion = "24.11";

    displays = [
      {
        name = "eDP-1";
        width = 1920;
        height = 1080;
        refreshRate = 144;
      }
    ];

    profiles = {
      graphical = true;
      workstation = true;
    };
  };
}

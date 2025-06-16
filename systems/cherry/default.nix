{
  imports = [
    ./old-hardware.nix
  ];

  salad = {
    stateVersion = "24.11";

    displays = [
      {
        # todo: update once deployed to real machine
        name = "Virtual-1";
        width = 1920;
        height = 1080;
        refreshRate = 60;
      }
    ];

    profiles = {
      graphical = true;
      workstation = true;
    };
  };
}

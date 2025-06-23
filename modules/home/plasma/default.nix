{
  programs.plasma = {
    enable = true;

    # make scrolling normal!
    # todo: modularise
    input.touchpads = [
      {
        naturalScroll = true;
        vendorId = "093a";
        # Bus=0018 Vendor=093a Product=2003 Version=0100
        productId = "2003";
        name = "ASUP1205:00 093A:2003 Touchpad";
      }
    ];

    # don't require a password to unlock the screen
    kscreenlocker.passwordRequired = false;
  };
}

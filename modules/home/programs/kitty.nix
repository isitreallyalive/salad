# `kitty` terminal emualator.

{
  programs.kitty = {
    enable = true;
    enableGitIntegration = true;
    shellIntegration.enableBashIntegration = true;
    font.name = "Cascadia Code NF";
  };
}

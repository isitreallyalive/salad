# nushell configuration.

{
  programs.nushell = {
    enable = true;

    settings = {
      show_banner = false;
      shell_integration = {
        # abbreviate path in home directory, set tab/window title, show running command
        osc2 = true;
        # communicate current path to terminal for spawning new tabs in same directory
        osc7 = true;
        # show clickable links in ls output if terminal supports it
        osc8 = true;
        # ConEmu path communication (similar to osc7, limited support)
        osc9_9 = false;
        # final Term escapes for prompt/command/output boundaries
        # enables terminals to distinguish prompt, command, and output sections
        osc133 = true;
        # vs code shell integration features (similar to osc133)
        # supports shell integration and run recent menu in VS Code
        osc633 = true;
        # reset application mode escape sequence for better SSH compatibility
        reset_application_mode = true;
      };
    };

    shellAliases = {
      cat = "bat";
      cd = "z";
      cloc = "tokei";
      dig = "dog";
      find = "fd";
      fuck = "f";
      grep = "rg";
      hex = "hexyl";
      ls = "eza";
      ping = "gping";
      ps = "procs";
      scc = "tokei";
      sed = "sd";
    };
  };
}

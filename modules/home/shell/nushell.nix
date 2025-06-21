# `nu`shell configuration.

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

      hooks = {
        env_change = {
          PWD = [
            # direnv compat
            # see: https://github.com/nushell/nu_scripts/blob/main/nu-hooks/nu-hooks/direnv/config.nu
            ''
              $env.config.hooks.pre_prompt = (
                $env.config.hooks.pre_prompt | append (
                  http get "https://raw.githubusercontent.com/nushell/nu_scripts/refs/heads/main/nu-hooks/nu-hooks/direnv/config.nu"
                )
              )
            ''
          ];
        };

        pre_prompt = [
          # load ssh agent
          ''
            def --env ensure-ssh-agent [] {
              let ssh_agent_file = (
                  $nu.temp-path | path join $"ssh-agent-($env.USER? | default $env.USER).nuon"
              )

              if ($ssh_agent_file | path exists) {
                  let ssh_agent_env = open ($ssh_agent_file)
                  if ($"/proc/($ssh_agent_env.SSH_AGENT_PID)" | path exists) {
                      load-env $ssh_agent_env
                      return
                  } else {
                      rm $ssh_agent_file
                  }
              }

              let ssh_agent_env = ^ssh-agent -c
                  | lines
                  | first 2
                  | parse "setenv {name} {value};"
                  | transpose --header-row
                  | into record
              load-env $ssh_agent_env
              $ssh_agent_env | save --force $ssh_agent_file
            }
            ensure-ssh-agent
          ''
        ];
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

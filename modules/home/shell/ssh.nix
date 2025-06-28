{
  lib,
  user,
  pkgs,
  config,
  self,
  ...
}:

let
  inherit (user.ssh) hosts;

  # convert list of hosts to attribute set for SSH match blocks
  # using hostname as the key
  matchBlocks = lib.listToAttrs (
    map (hostConfig: {
      name = hostConfig.hostname;
      value = {
        hostname = hostConfig.hostname;
        inherit (hostConfig) user;
        identityFile = config.age.secrets."ssh/${hostConfig.secret}".path;
      };
    }) hosts
  );

  # a script to add SSH keys to the agent
  addKeysScript = pkgs.writeShellScript "add-ssh-keys" ''
    ${lib.concatStringsSep "\n" (
      map (
        hostConfig:
        let
          inherit (config.age) secrets;
          inherit (hostConfig) secret;
          keyPath = secrets."ssh/${secret}".path;
          passPath = secrets."ssh/${secret}.pass".path;
          askPass = pkgs.writeShellScript "ssh-askpass-${secret}" ''
            cat "${passPath}"
          '';
        in
        if hostConfig.pass then
          ''
            if ! ssh-add -l &>/dev/null || ! ssh-keygen -l -f "${keyPath}" &>/dev/null || ! ssh-add -l | grep -q "$(ssh-keygen -l -f "${keyPath}" | awk '{print $2}')"; then
              if [[ -f "${passPath}" ]]; then
                SSH_ASKPASS="${askPass}" SSH_ASKPASS_REQUIRE=force ssh-add "${keyPath}"
              else
                echo "Warning: Password file ${passPath} not found, trying without password"
                ssh-add "${keyPath}"
              fi
            fi
          ''
        else
          ''
            if ! ssh-add -l &>/dev/null || ! ssh-keygen -l -f "${keyPath}" &>/dev/null || ! ssh-add -l | grep -q "$(ssh-keygen -l -f "${keyPath}" | awk '{print $2}')"; then
              ssh-add "${keyPath}"
            fi
          ''
      ) hosts
    )}
  '';

  # generate age secrets configuration
  secrets = lib.listToAttrs (
    lib.flatten (
      map (
        hostConfig:
        [
          {
            name = "ssh/${hostConfig.secret}";
            value = { };
          }
        ]
        ++ lib.optionals hostConfig.pass [
          {
            name = "ssh/${hostConfig.secret}.pass";
            value = { };
          }
        ]
      ) hosts
    )
  );
in
{
  # `ssh`
  programs.ssh = {
    enable = true;
    hashKnownHosts = true;
    compression = true;
    addKeysToAgent = "yes";
    inherit matchBlocks;
  };

  # enable the SSH agent
  services.ssh-agent.enable = true;

  # allow nushell to access the SSH agent
  programs.nushell.environmentVariables = {
    SSH_AUTH_SOCK = lib.hm.nushell.mkNushellInline "$\"($env.XDG_RUNTIME_DIR)/ssh-agent\"";
  };

  # automatically load keys into the SSH agent
  programs.bash.initExtra = ''
    ${addKeysScript}
  '';
  programs.nushell.extraConfig = ''
    ^${addKeysScript}
  '';

  # ssh keys
  age.secrets = self.lib.secrets secrets;
}

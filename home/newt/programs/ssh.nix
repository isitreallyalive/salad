# {
#   lib,
#   pkgs,
#   config,
#   self,
#   ...
# }:

# let
#   hosts = {
#     "github.com" = {
#       user = "git";
#       secret = "gh";
#       pass = true;
#     };
#   };

#   inherit (lib) mapAttrs;

#   # generate askpass scripts for each host that needs one
#   askPass = mapAttrs (
#     name: hostConfig:
#     if hostConfig.pass or false then
#       pkgs.writeShellScript "ssh-askpass-${name}" ''
#         cat ${config.age.secrets."ssh/${hostConfig.secret}".path}
#       ''
#     else
#       null
#   ) hosts;

#   # generate match blocks for each host
#   matchBlocks = mapAttrs (hostname: hostConfig: {
#     inherit hostname;
#     inherit (hostConfig) user;
#     identityFile = config.age.secrets."ssh/${hostConfig.secret}".path;
#   }) hosts;

#   # a script to add SSH keys to the agent
#   addKeysScript = pkgs.writeShellScript "add-ssh-keys" ''
#     ${lib.concatStringsSep "\n" (
#       lib.mapAttrsToList (
#         name: hostConfig:
#         let
#           inherit (config.age) secrets;
#           inherit (hostConfig) secret;
#           inherit (pkgs) openssh;
#           keyPath = secrets."ssh/${secret}".path;
#           passPath = secrets."ssh/${secret}.pass".path;
#         in
#         if hostConfig.pass or false then
#           ''
#             if ! ssh-add -l 2>/dev/null | grep -q "${keyPath}"; then
#               SSH_ASKPASS="${pkgs.writeShellScript "askpass-${name}" "cat ${passPath}"}" \
#               SSH_ASKPASS_REQUIRE=force \
#                 ${openssh}/bin/ssh-add "${keyPath}" < /dev/null
#             fi
#           ''
#         else
#           ''
#             if ! ssh-add -l 2>/dev/null | grep -q "${keyPath}"; then
#               ${openssh}/bin/ssh-add "${keyPath}"
#             fi
#           ''
#       ) hosts
#     )}
#   '';

#   # generate age secrets configuration
#   secrets = lib.listToAttrs (
#     lib.flatten (
#       lib.mapAttrsToList (
#         name: hostConfig:
#         [
#           {
#             name = "ssh/${hostConfig.secret}";
#             value = { };
#           }
#         ]
#         ++ lib.optionals (hostConfig.hasPassphrase or false) [
#           {
#             name = "ssh/${hostConfig.secret}.pass";
#             value = { };
#           }
#         ]
#       ) hosts
#     )
#   );
# in
# {
#   # `ssh`
#   programs.ssh = {
#     enable = true;
#     hashKnownHosts = true;
#     compression = true;
#     addKeysToAgent = "yes";
#     inherit matchBlocks;
#   };

#   programs.nushell.initExtra = ''
#     ${addKeysScript}
#   '';

#   age.secrets = self.lib.secrets secrets;
# }
{ }

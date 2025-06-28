# docker and podman
{
  self,
  config,
  pkgs,
  ...
}:

{
  config = self.lib.profile.mkIf config [ "workstation" ] {
    virtualisation = {
      containers.enable = true;
      docker.rootless = {
        enable = true;
        setSocketVariable = true;
      };
      podman = {
        autoPrune.enable = true;
        defaultNetwork.settings.dns_enabled = true;
      };
    };

    salad.packages = {
      inherit (pkgs)
        dive
        # install podman here instead of enabling so that we can have rootless only
        podman
        podman-tui
        docker-compose
        virtiofsd
        ;
    };
  };
}

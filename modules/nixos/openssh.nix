{ self, config, ... }:

{
  services.openssh = self.lib.mkIfProfile config "server" {
    enable = true;

    # todo: remove this, it is a security risk in production
    settings = {
      PermitRootLogin = "yes";
      PasswordAuthentication = true;
    };

    # todo: authorised keys
  };
}

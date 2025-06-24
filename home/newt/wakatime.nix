# write wakatime api key to file

{
  lib,
  config,
  self,
  ...
}:

{
  home.activation.writeWakatimeCfg = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    cat > "$HOME/.wakatime.cfg" <<EOF
    [settings]
    api_key = $(cat ${config.age.secrets.wakatime.path})
    EOF
  '';

  age.secrets = {
    wakatime = self.lib.secrets.mkSecret "wakatime";
  };
}

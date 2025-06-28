# write wakatime api key to file

{
  lib,
  config,
  self,
  ...
}:

{
  # don't write the secret if it doesn't exist
  home.activation.writeWakatimeCfg = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [ ! -s "${config.age.secrets.wakatime.path}" ]; then
      echo "ERROR: Wakatime API key secret is missing or empty!" >&2
      exit 1
    fi
    cat > "$HOME/.wakatime.cfg" <<EOF
    [settings]
    api_key = $(cat ${config.age.secrets.wakatime.path})
    EOF
  '';

  age.secrets = self.lib.secrets {
    wakatime = { };
  };
}

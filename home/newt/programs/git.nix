{
  # `git` ssh signing
  programs.git = {
    signing = {
      signByDefault = true;
      format = "ssh";
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN86DZx/7XaYPvvm2VA6xD0fqPDWaN6kzKcJ5m9ozwL7";
    };
  };
}

rebuild system="cherry":
  @git add .
  sudo nixos-rebuild switch --flake .#{{system}}

rollback:
  sudo nixos-rebuild switch --rollback
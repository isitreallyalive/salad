rebuild system="cherry":
  @treefmt -q
  @git add .
  sudo nixos-rebuild switch --flake .#{{system}}

rollback:
  sudo nixos-rebuild switch --rollback
rebuild system="cherry" *args:
  @treefmt -q
  @git add .
  sudo nixos-rebuild switch --flake .#{{system}} {{args}}

clean:
  sudo nix-collect-garbage -d
  sudo nix-store --optimize

rollback:
  sudo nixos-rebuild switch --rollback
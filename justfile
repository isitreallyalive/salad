@rebuild *args:
  treefmt -q
  git add .
  sudo nixos-rebuild switch --flake .#$(hostname) {{args}}

@deploy target *args:
  treefmt -q
  git add .
  deploy --targets .#{{target}} {{args}}
  just shell {{target}}

@shell target:
  ssh newt@{{target}}

@key name:
  ssh-keygen -t ed25519 -f secrets/keys/{{name}}.key
  cd secrets && cat keys/{{name}}.key | agenix -e keys/{{name}}.age

@secret path:
  cd secrets && agenix -e {{path}}.age

clean:
  sudo nix-collect-garbage -d
  sudo nix-store --optimize

@rollback:
  sudo nixos-rebuild switch --rollback

@rekey:
  cd secrets && agenix -r

@book +args:
  cd book && mdbook {{args}}

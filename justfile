[group("deploy")]
@rebuild *args:
  treefmt -q
  git add .
  sudo nixos-rebuild switch --flake .#$(hostname) {{args}}

[group("deploy")]
@deploy target *args:
  treefmt -q
  git add .
  deploy --targets .#{{target}} {{args}}

[group("deploy")]
@rollback:
  sudo nixos-rebuild switch --rollback

[group("secrets")]
@key name:
  ssh-keygen -t ed25519 -f secrets/keys/{{name}}.key
  cd secrets && cat keys/{{name}}.key | agenix -e keys/{{name}}.age

[group("secrets")]
@secret path:
  cd secrets && agenix -e {{path}}.age

[group("secrets")]
@rekey:
  cd secrets && agenix -r

[group("admin")]
@shell target:
  ssh newt@{{target}}

[group("admin")]
clean:
  sudo nix-collect-garbage -d
  sudo nix-store --optimize


@book +args:
  cd book && mdbook {{args}}

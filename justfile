[group("deploy")]
@rebuild *args:
  treefmt -q
  git add .
  sudo nixos-rebuild switch --flake .#$(hostname) {{args}}

[group("deploy")]
@deploy target *args:
  treefmt -q
  git add .
  deploy -s --targets .#{{target}} {{args}}

[group("deploy")]
@rollback:
  sudo nixos-rebuild switch --rollback

[group("secrets")]
@key name:
  ssh-keygen -t ed25519 -f secrets/{{name}}.key
  cd secrets && cat {{name}}.key | agenix -e {{name}}.age
  shopt -s nullglob; shred -u secrets/*.key secrets/*.key.pub

[group("secrets")]
@secret path:
  cd secrets && agenix -e {{path}}.age

[group("secrets")]
@rekey:
  cd secrets && agenix -r

[group("utils")]
@shell target:
  ssh newt@{{target}}

[group("utils")]
@locate pkg:
  nix eval --raw nixpkgs#{{pkg}}

[group("utils")]
@cloc:
  tokei book/src home modules systems templates flake.nix

[group("utils")]
[doc("Prune old generations")]
@prune keep="5":
  sudo nixos-collect-garbage --delete-older-than +{{keep}}

@gc:
  sudo nix-collect-garbage -d
  sudo nix-store --optimize

@book +args:
  cd book && mdbook {{args}}
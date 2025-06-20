/*
  Entry point for the salad flake.

  Configures:
    - `deploy-rs`
    - `treefmt`
    - `nix develop`
    - `easy-hosts`
*/
{ inputs, ... }:

{
  imports = [
    ../../systems

    ./lib # salad lib

    ./deploy.nix # `deploy-rs`
    ./dev.nix # `nix develop`
    ./treefmt.nix # `treefmt`
  ];

  # `flake-parts` debug mode is required for `nixd`
  debug = true;

  # set the output systems for this flake
  systems = import inputs.systems;
}

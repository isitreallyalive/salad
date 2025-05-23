{ inputs, ... }:

{
  imports = [
    ../../systems
  ];

  # set the output systems for this flake
  systems = import inputs.systems;
}

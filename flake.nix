{
  description = "A very basic flake";

  outputs =
    inputs:
    inputs.parts.lib.mkFlake { inherit inputs; } { imports = [ ./modules/flake ]; }
    // {
      templates = rec {
        default = empty;

        empty = {
          path = ./templates/empty;
          description = "An empty flake template that can be adapted to your environment";
        };
      };
    };

  inputs = {
    # we can save 15mb by using the channel tarball
    # see: https://deer.social/profile/did:plc:mojgntlezho4qt7uvcfkdndg/post/3loogwsoqok2w
    nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.xz";

    # delicious implementation of nix
    lix = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.93.0.tar.gz";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "utils";
      };
    };

    # manage userspace
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # manage plasma
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };

    # secret management
    agenix = {
      url = "github:ryantm/agenix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
        systems.follows = "systems";
      };
    };

    ### flake management
    # bring everything together
    parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    # multi-host configuration
    easy-hosts.url = "github:tgirlcloud/easy-hosts";

    # deploy to remote
    deploy-rs = {
      url = "github:serokell/deploy-rs";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-compat.follows = "";
        utils.follows = "utils";
      };
    };

    # flake utility functions
    utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };

    ### additional
    # run foreign executables
    alien = {
      url = "github:thiagokokada/nix-alien";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # format all the things
    treefmt = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # catppuccin theme
    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ### meta
    # all possible systems
    systems.url = "github:nix-systems/default";
  };
}

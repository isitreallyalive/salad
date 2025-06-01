{
  description = "A very basic flake";

  outputs =
    inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } { imports = [ ./modules/flake ]; };

  inputs = {
    # we can save 15mb by using the channel tarball
    # see: https://deer.social/profile/did:plc:mojgntlezho4qt7uvcfkdndg/post/3loogwsoqok2w
    nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.xz";

    # manage userspace
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # secret management
    ragenix.url = "github:yaxitech/ragenix";

    ### flake management
    # bring everything together
    flake-parts = {
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
      };
    };

    ### additional
    # format all the things
    treefmt = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # catppuccin theme
    catppuccin.url = "github:catppuccin/nix";

    ### meta
    # all possible systems
    systems.url = "github:nix-systems/default";
  };
}

{
  description = "Rust development flake";

  outputs =
    {
      nixpkgs,
      utils,
      rust-overlay,
      crane,
      advisory-db,
      ...
    }:
    utils.lib.eachDefaultSystem (
      system:
      let
        # required targets
        targets = [ "x86_64-unknown-linux-musl" ];

        # build dependencies
        buildDependencies = with pkgs; [
          pkg-config
          openssl
        ];

        # nixpkgs + rust-overlay
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ rust-overlay.overlays.default ];
        };

        craneLib = crane.mkLib pkgs;
        src = craneLib.cleanCargoSource ./.;
        craneArgs = {
          inherit src;
          strictDeps = true;
          buildInputs = buildDependencies;
        };

        # build the crate
        cargoArtifacts = craneLib.buildDepsOnly craneArgs;
        crate = craneLib.buildPackage (craneArgs // { inherit cargoArtifacts; });
      in
      rec {
        checks = {
          # build the crate as a part of `nix flake check` for convenience
          inherit crate;

          # run clippy (and deny all warnings)
          clippy = craneLib.cargoClippy (
            craneArgs
            // {
              inherit cargoArtifacts;
              cargoClippyExtraArgs = "--all-targets -- --deny warnings";
            }
          );

          # check formatting
          rust-fmt = craneLib.cargoFmt { inherit src; };
          toml-fmt = craneLib.taploFmt {
            src = pkgs.lib.sources.sourceFilesBySuffices src [ ".toml" ];
          };

          # audit dependencies
          audit = craneLib.cargoAudit {
            inherit src advisory-db;
          };

          # run tests with cargo-nextest
          test = craneLib.cargoNextest (
            craneArgs
            // {
              inherit cargoArtifacts;
              partitions = 1;
              partitionType = "count";
              cargoNextestPartitionsExtraArgs = "--no-tests=pass";
            }
          );
        };

        devShells.default = pkgs.mkShell {
          buildInputs =
            with pkgs;
            [
              # rust
              (rust-bin.stable.latest.default.override {
                inherit targets;
              })
              cargo
              rust-analyzer
              
              # other tools
              taplo
            ]
            ++ buildDependencies;
        };
      }
    );

  inputs = {
    # we can save 15mb by using the channel tarball
    # see: https://deer.social/profile/did:plc:mojgntlezho4qt7uvcfkdndg/post/3loogwsoqok2w
    nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.xz";

    # flake management
    utils.url = "github:numtide/flake-utils";

    # rust toolchain
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # incremental builds
    crane.url = "github:ipetkov/crane";

    # rust advisories
    advisory-db = {
      url = "github:rustsec/advisory-db";
      flake = false;
    };
  };
}

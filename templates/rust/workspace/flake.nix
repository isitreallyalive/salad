{
  description = "Rust workspace development flake";

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
        # nixpkgs + rust-overlay
        inherit (pkgs) lib;
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ rust-overlay.overlays.default ];
        };

        craneLib = crane.mkLib pkgs;
        src = craneLib.cleanCargoSource ./.;
        commonArgs = {
          inherit src;
          strictDeps = true;
          # build dependencies
          buildInputs = with pkgs; [
            pkg-config
            openssl
          ];
        };

        # workspace crates
        cargoArtifacts = craneLib.buildDepsOnly commonArgs;
        individualCrateArgs = commonArgs // {
          inherit cargoArtifacts;
          inherit (craneLib.crateNameFromCargoToml { inherit src; }) version;
          doCheck = false;
        };
        buildCrate =
          crate:
          craneLib.buildPackage (
            individualCrateArgs
            // {
              pname = crate;
              cargoExtraArgs = "-p ${crate}";
              src = lib.fileset.toSource {
                root = ./.;
                fileset = lib.fileset.unions [
                  ./Cargo.toml
                  ./Cargo.lock
                  (craneLib.fileset.commonCargoSources ./crates/${crate})
                ];
              };
            }
          );

        crate-a = buildCrate "crate-a";
        crate-b = buildCrate "crate-b";
      in
      rec {
        checks = {
          # build the crates as a part of `nix flake check` for convenience
          inherit crate-a crate-b;

          # run clippy (and deny all warnings)
          clippy = craneLib.cargoClippy (
            commonArgs
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
            commonArgs
            // {
              inherit cargoArtifacts;
              partitions = 1;
              partitionType = "count";
              cargoNextestPartitionsExtraArgs = "--no-tests=pass";
            }
          );
        };

        packages = {
          inherit crate-a crate-b;
        };
        apps.default =
          let
            mkApp = drv: utils.lib.mkApp { inherit drv; };
          in
          {
            crate-a = mkApp crate-a;
            crate-b = mkApp crate-b;
          };

        devShells.default = craneLib.devShell {
          inherit checks;
          buildInputs = with pkgs; [
            # dev tools
            cargo-autoinherit
            taplo
            rust-analyzer
          ];
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

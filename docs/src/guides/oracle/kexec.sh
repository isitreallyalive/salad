#!/bin/bash

ARCH=$(uname -m)

echo "Detected architecture: $ARCH"

case $ARCH in
    aarch64)
        INSTALLER="https://github.com/nix-community/nixos-images/releases/download/nixos-unstable/nixos-kexec-installer-noninteractive-aarch64-linux.tar.gz"
        ;;
    x86_64)
        INSTALLER="https://github.com/nix-community/nixos-images/releases/download/nixos-unstable/nixos-kexec-installer-noninteractive-x86_64-linux.tar.gz"
        ;;
esac

sudo bash -c "
    curl -L '$INSTALLER' | tar -xzf- -C /root
    /root/kexec/run
"
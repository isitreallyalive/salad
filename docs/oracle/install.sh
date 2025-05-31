#!/bin/bash

# --- partition ---

# see: https://mdleom.com/blog/2021/03/09/nixos-oracle/
# uses 1G swap by default
fdisk /dev/sda << EOF
g
n
1

+512M
n
2

-1G
n
3


t
1
uefi
p
w
EOF

fdisk -l /dev/sda

# --- format ---
mkfs.fat -F 32 -n boot /dev/sda1
mkfs.ext4 -L nixos /dev/sda2
mkswap -L swap /dev/sda3

# --- mount ---
mkdir -p /mnt
mount /dev/disk/by-label/nixos /mnt
mkdir -p /mnt/boot
mount /dev/disk/by-label/boot /mnt/boot
swapon /dev/sda3

# --- configuration ---
nix-channel --add https://nixos.org/channels/nixos-unstable nixpkgs
nix-channel --update
nixos-generate-config --root /mnt
curl -L https://raw.githubusercontent.com/isitreallyalive/salad/refs/heads/main/docs/oracle/configuration.nix -o /mnt/etc/nixos/configuration.nix

# --- installation ---
nixos-install
reboot
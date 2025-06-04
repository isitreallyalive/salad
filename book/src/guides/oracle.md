# installing nixos on oracle free tier

don't care about the writeup? skip to the [installation instructions](#installation)

## always free

at the time of writing this [oracle cloud](https://www.oracle.com/cloud) offers a suprisingly generous *always free* tier. you get:

- AMD: 2 VMs with 1/8 OCPU and 1GB RAM each
- Arm (Ampere A1): 24GB RAM and 4 OCPU, which can be split across 1-4 VMs

in total that is 26GB of RAM and 4.25 OCPUs - completely free! (assuming you can get a spot. as you might expect, this offering is extremely popular.)

## that's awesome - what's the catch?

there's no real catch - but one major limitation is that nixos isn't available as a default image.

not to worry though - i've written a few simple scripts that lets you install nixos from just about any other os that has a bash shell.

## installation

### step 1

ssh into your vm and run the following command:

```sh
curl -sSL https://salad.newty.dev/guides/oracle/kexec.sh | sudo bash
```

this will download and run a script that installs a nixos installation environment matching your vm's architecture, then reboots into it using [kexec](https://wiki.archlinux.org/title/Kexec).

> [!WARNING]  
> you'll be disconnected from ssh once the system reboots.

### step 2

ssh back into your machine, this time as the `root` user. run the following commands:

```sh
curl -sSL https://salad.newty.dev/guides/oracle/install.sh -o install.sh
bash install.sh "<ssh key>" "<swap size>"
```

replace `<ssh key>` with your public ssh key and `<swap size>` with the swap size you'd like (e.g. `1G` or `512M`).

this script will:
- partition and format the disk
- configure and install a minimal nixos system
- setup networking and ssh access
- enable your specified ssh key
- reboot into your fresh nixos installation

## conclusion

once you've followed the steps above, you'll have a fully functional nixos installation running on oracle cloud.

from here, you can configure it just like any other nixos system.
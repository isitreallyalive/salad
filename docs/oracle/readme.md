# installing nixos on oracle cloud

## booting

we need to use `kexec` to install the operating system.

```sh
curl -sSL https://raw.githubusercontent.com/isitreallyalive/salad/main/docs/oracle/kexec.sh | sudo bash
```

and then reconnect to ssh as the root user.

## installation

*thanks to [Ming Di Leom](https://mdleom.com/blog/2021/03/09/nixos-oracle/)*

```sh
curl -sSL https://raw.githubusercontent.com/isitreallyalive/salad/main/docs/oracle/install.sh | sudo bash
```

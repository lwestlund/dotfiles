[![NixOS Unstable](https://img.shields.io/badge/NixOS-unstable-blue.svg?style=flat-square&logo=NixOS&logoColor=white)](https://nixos.org)

# My dotfiles.
_Now with Nix configuration!_

## Installation

1. Get the latest NixOS (20.09+) iso.
2. Flash it to a bootable USB, or use [ventoy](https://github.com/ventoy/Ventoy) to create a multi-iso USB!
3. Create all your partitions and mount at least the partitions for `/` and `/boot` to `/mnt` and `/mnt/boot`.
4. Install the dotfiles!
    - `sudo su`
    - `nix-shell -p git nixFlakes`
    - `git clone https://github.com/lovewestlundgotby/dotfiles /mnt/etc/nixos`
    - `nixos-install --root /mnt --flake /mnt/etc/nixos#<host>`, this is where you choose which
      `<host>` you are installing.
    - Enter a root password as prompted.
    - Optionally, do `nixos-enter --root /mnt` and then `passwd <your user>` to setup the password for your user.
5. Reboot!
    - If you are having issues with X when using i3 and it's complaining about there being no config file,
      login to a tty and run `sudo nixos-rebuild switch`. This will redo things with correct paths.
6. Profit!

Thank you [hlissner](https://github.com/hlissner) senpai for teaching me the way.

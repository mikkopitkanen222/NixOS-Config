# NixOS-Config
This repository contains my NixOS configuration flake.
The configs have three interchangeable components: host, system, and users.
Each type of component resides in a separate sub-directory of this repo:

- [Host configs](hosts) are specific to each physical (or virtual) machine.
They configure options depending on the installed hardware, such as host platforms (e.g. x86_64-linux), file system mount options, and video drivers.
Host configs also set host specific options not dependent on installed hardware, such as kernel versions, boot loaders, and host names.
Only one host config can be enabled per built NixOS config.

- [System configs](systems) are specific to each workflow.
They configure options depending on the use case, such as the desktop environment, programs, services, and settings.
System configs are shared by all users of the machine.
Only one system config can be enabled per built NixOS config.

- [User configs](users) are specific to each user.
They configure options depending on the user, such as programs, services, and settings.
User configs modify settings and install software only in the user's own profile.
Multiple user configs can be enabled per built NixOS config.


# Usage
Build the configs with [`nixos-rebuild`](https://nixos.org/manual/nixos/stable/#sec-changing-config). Remember to use `sudo` with `nixos-rebuild` operations `boot` and `switch`.
```sh
# sudo nixos-rebuild switch --flake <PATH>#<CFG>
# <PATH> is path to flake; <CFG> is config name in flake.nix:
sudo nixos-rebuild switch --flake .#desknix
# Config name defaults to current hostname:
sudo nixos-rebuild switch --flake .#
```

Create a symlink `/etc/nixos/flake.nix` targeting the `flake.nix` file in this repository and you can omit the `--flake` option:
```sh
# Same as above, when on host "desknix":
sudo nixos-rebuild switch
```

Home Manager is used as a NixOS module, rather than the standalone tool, allowing the user profiles to be built together with the system. See the [manual](https://nix-community.github.io/home-manager/index.xhtml#ch-nix-flakes) for more info.


# Note
Don't use this flake as is on your own machine. At least some modifications must be made first, such as:
- Host configurations should be generated with [`nixos-generate-config`](https://nixos.org/manual/nixos/stable/#sec-installation-manual-installing). Some hand edits may be needed to fit in the rest of the configs.
- Pick your own host/config names.
- Change user names and emails.
- Don't install my ssh keys or I will be able to log in on your machine.

<b>You should craft your own flake for the best results.</b>

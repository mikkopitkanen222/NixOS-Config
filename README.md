# NixOS-Config
This repository contains my NixOS configurations flake.
Each config consists of three components: host, system, and users.
Each component is implemented in a separate sub-directory of this repo.

## Hosts
[Host](hosts) configs define the disks, filesystems, boot loaders, kernel versions, device drivers, etc., specific to each machine.
Only one host config can be enabled per built NixOS config.

## Systems
[System](systems) configs define the desktop environment, programs, services, settings, etc., shared by all users.
Only one system config can be enabled per built NixOS config.

## Users
[User](users) configs define the programs, services, settings, etc., specific to each user.
Multiple user configs can be enabled per built NixOS config.

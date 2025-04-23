# Hosts
This directory contains all [host modules](modules) and host configurations.

## Host modules
Host modules install drivers and packages, and enable services.
Host module options are set in each host's configuration in attribute set
`build.host`, e.g. `build.host = { cpu.amd.enable = true; };`.

## Host configurations
Host configurations define host specific hardware, kernel version, and filesystems.
A host configuration is enabled by specifying the host name in the flake in attribute
`build.hostName`, e.g. `build.hostName = "myDesktop";`.

# Hosts
This directory contains all host configurations.

Host configurations define host specific hardware, kernel version, and filesystems.
A host configuration is enabled by specifying the host name in the flake in attribute
`build.hostName`, e.g. `build.hostName = "myDesktop";`.

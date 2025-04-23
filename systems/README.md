# Systems
This directory contains all [system modules](modules) and system configurations.

## System modules
System modules implement features, install packages, and enable services.
System module effects are shared by all users, unlike [user modules](/users).
System module options are set in each system's configuration in attribute set
`build.system`, e.g. `build.system = { plasma.enable = true; };`.

## System configurations
System configurations define use case specific sets of programs and services.
A system configuration is enabled by specifying the system name in the flake in attribute
`build.systemName`, e.g. `build.systemName = "work";`.

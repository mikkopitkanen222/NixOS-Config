# Modules
This directory contains all modules.

## [Host modules](host)
Host modules install drivers and packages, and enable services.
Host module options are set in each host's configuration in attribute set
`build.host`, e.g. `build.host = { cpu.amd.enable = true; };`.

## [System modules](system)
System modules implement features, install packages, and enable services.
System module effects are shared by all users, unlike [user modules](user).
System module options are set in each system's configuration in attribute set
`build.system`, e.g. `build.system = { plasma.enable = true; };`.

## [User modules](user)
User modules implement features, install packages, and enable services.
User module effects are separate for each user, unlike [system modules](system).
User module options are set in each user's configuration in attribute set
`build.user.<username>`, e.g. `build.user.bob = { bash.enable = true; };`.
User modules are mostly based on Home Manager.

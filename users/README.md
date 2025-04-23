# Users
This directory contains all [user modules](modules) and user configurations.
User modules and configurations are mostly based on Home Manager.

## User modules
User modules implement features, install packages, and enable services.
User module effects are separate for each user, unlike [system modules](/systems).
User module options are set in each user's configuration in attribute set
`build.user.<username>`, e.g. `build.user.bob = { bash.enable = true; };`.

## User configurations
User configurations define user accounts for use on the system.
User configurations are enabled by listing their user names in the flake in attribute
`build.userNames`, e.g. `build.userNames = [ "alice" "bob" ];`.

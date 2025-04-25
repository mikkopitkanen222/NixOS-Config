# Users
This directory contains all user configurations.

User configurations define user accounts and their home directories.
User configurations are enabled by listing their user names in the flake in attribute
`build.userNames`, e.g. `build.userNames = [ "alice" "bob" ];`.
User configurations are mostly based on Home Manager.

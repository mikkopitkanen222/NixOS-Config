# Import system configurations.
{ config, lib, ... }:
let
  cfg = config.system;
in
{
  imports = [
    ./main.nix
    ./wsl.nix
  ];

  options.system = {
    # Imported systems merge their systemNames into this list.
    allSystemNames = lib.mkOption {
      description = "List of allowed systemNames";
      type = lib.types.listOf lib.types.str;
    };

    # Set this in flake.nix.
    systemName = lib.mkOption {
      description = "Name of the system configuration to build";
      type = lib.types.enum cfg.allSystemNames;
    };
  };
}

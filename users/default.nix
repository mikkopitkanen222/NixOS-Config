# Import user configurations.
{ config, lib, ... }:
let
  cfg = config.system;
in
{
  imports = [
    ./mp
    ./wsl
  ];

  options.system = {
    # Imported users merge their userNames into this list.
    allUserNames = lib.mkOption {
      description = "List of allowed userNames";
      type = lib.types.listOf lib.types.str;
    };

    # Set these in flake.nix.
    userNames = lib.mkOption {
      description = "List of names of user configurations to build";
      type = lib.types.listOf (lib.types.enum cfg.allUserNames);
    };
  };
}

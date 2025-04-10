# Import host configurations.
{
  config,
  lib,
  modulesPath,
  ...
}:
let
  cfg = config.system;
in
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ./desknix.nix
    ./lapnix.nix
    ./previousnix.nix
    ./wsl.nix
  ];

  options.system = {
    # Imported hosts merge their hostNames into this list.
    allHostNames = lib.mkOption {
      description = "List of allowed hostNames";
      type = lib.types.listOf lib.types.str;
    };

    # Set this in flake.nix.
    hostName = lib.mkOption {
      description = "Name of the host configuration to build";
      type = lib.types.enum cfg.allHostNames;
    };
  };
}

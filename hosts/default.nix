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
    ./modules
    ./desknix.nix
    ./lapnix.nix
    ./wsl.nix
  ];

  options.system = {
    hostNames' = lib.mkOption {
      description = "List of allowed hostNames";
      type = lib.types.listOf lib.types.str;
    };

    hostName = lib.mkOption {
      description = "Name of the hardware configuration to build";
      type = lib.types.enum cfg.hostNames';
    };
  };
}

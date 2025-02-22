# Import system configurations.
{
  config,
  lib,
  ...
}:
let
  cfg = config.system;
in
{
  imports = [
    ./modules
    ./main.nix
    ./wsl.nix
  ];

  options.system = {
    systemNames' = lib.mkOption {
      description = "List of allowed systemNames";
      type = lib.types.listOf lib.types.str;
    };

    systemName = lib.mkOption {
      description = "Name of the system configuration to build";
      type = lib.types.enum cfg.systemNames';
    };
  };
}

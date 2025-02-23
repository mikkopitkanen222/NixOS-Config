# Import user configurations.
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
    ./mp
    ./wsl
  ];

  options.system = {
    userNames' = lib.mkOption {
      description = "List of allowed userNames";
      type = lib.types.listOf lib.types.str;
    };

    userNames = lib.mkOption {
      description = "List of names of user configurations to build";
      type = lib.types.listOf (lib.types.enum cfg.userNames');
    };
  };
}

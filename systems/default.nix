# Import system configurations.
{ lib, ... }:
{
  imports = [
    ./modules
    ./main.nix
    ./wsl.nix
  ];

  options.build = {
    systemName = lib.mkOption {
      description = "Name of the system configuration to build.";
      type = lib.types.enum [ ];
      example = "work";
    };
  };
}

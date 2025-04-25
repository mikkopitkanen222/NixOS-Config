# Import host configurations.
{ lib, modulesPath, ... }:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ./desknix.nix
    ./lapnix.nix
    ./previousnix.nix
    ./wsl.nix
  ];

  options = {
    build = {
      hostName = lib.mkOption {
        description = "Name of the host configuration to build.";
        type = lib.types.enum [ ];
        example = "myDesktop";
      };
    };
  };
}

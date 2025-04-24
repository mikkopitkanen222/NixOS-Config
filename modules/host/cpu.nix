# Configuration for host module "cpu".
{ lib, ... }:
{
  options = {
    build.host.cpu = {
      maker = lib.mkOption {
        description = "Manufacturer of the installed CPU.";
        type = lib.types.nullOr (lib.types.enum [ ]);
        example = "amd";
      };

      platform = lib.mkOption {
        description = "Host platform of the installed CPU.";
        type = lib.types.str;
        default = "x86_64-linux";
      };

      updateMicrocode = lib.mkEnableOption "CPU microcode updates";

      modules = lib.mkOption {
        description = "List of CPU related kernel modules to be loaded on boot.";
        type = lib.types.nullOr (lib.types.listOf lib.types.str);
        default = null;
        example = [ "kvm-amd" ];
      };
    };
  };
}

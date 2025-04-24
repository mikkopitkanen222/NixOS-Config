# Configuration for host module "gpu".
{ lib, ... }:
{
  options = {
    build.host.gpu = {
      maker = lib.mkOption {
        description = "Manufacturer of the installed GPU.";
        type = lib.types.nullOr (lib.types.enum [ ]);
        example = "amd";
      };
    };
  };
}

# Enable fingerprint reader.
{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.build.hardware.fprint;
in
{
  options.build.hardware.fprint = {
    enable = lib.mkOption {
      description = "Enable fingerprint reader";
      type = lib.types.bool;
      default = false;
    };

    package = lib.mkOption {
      description = "Fingerprint reader driver";
      type = lib.types.package;
      default = pkgs.libfprint-2-tod1-elan;
    };
  };

  config = lib.mkIf cfg.enable {
    unfree.allowedPackages = [ (lib.getName cfg.package) ];

    services.fprintd = {
      enable = true;
      tod = {
        enable = true;
        driver = cfg.package;
      };
    };
  };
}

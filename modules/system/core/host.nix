{ inputs, lib, ... }: {
  imports = [ inputs.sops-nix.nixosModules.sops ];

  options.mp222.host = {
    isLaptop = lib.mkEnableOption "laptop-specific tweaks";

    cpuTempSensor = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      example = "k10temp/Tctl";
      description = "The CPU temperature sensor, as shown in btop.";
    };

    amdGpuName = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      example = "RX 9070 XT";
      description = ''
        The GPU label to show in btop.
        If not `null`, enables btop's rocm-support.
      '';
    };
  };
}

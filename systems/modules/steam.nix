# Enable Steam.
{
  config,
  lib,
  ...
}:
let
  cfg = config.system.software.steam;
in
{
  imports = [
    ../../modules/unfree.nix
  ];

  options.system.software.steam = {
    enable = lib.mkOption {
      description = "Enable Steam";
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg.enable {
    unfree.allowedPackages = [
      "steam"
      "steam-unwrapped"
    ];

    programs.steam.enable = true;
  };
}

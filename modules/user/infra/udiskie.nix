# https://github.com/coldfix/udiskie
{
  config,
  lib,
  osConfig,
  ...
}:
let
  cfg = config.mp222.udiskie;
in
{
  options.mp222.udiskie = {
    enable = lib.mkEnableOption "automounting removable media";
  };

  config = lib.mkIf cfg.enable {
    assertions = [
      {
        assertion = osConfig.services.udisks2.enable;
        message = "udiskie needs udisks on the host: set mp222.udisks.enable.";
      }
    ];

    services.udiskie = {
      enable = true;
      tray = "auto";
      settings = {
        program_options = {
          udisks_version = 2;
          automount = true;
          notify = true;
          password_cache = 5;
          password_prompt = "builtin:tty";
        };
      };
    };
  };
}

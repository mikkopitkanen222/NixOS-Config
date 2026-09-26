{ config, lib, ... }:
let
  cfg = config.mp222.i18n;
in
{
  options.mp222.i18n = {
    timezone = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      description = "Force a timezone. Null to detect timezone automatically.";
      default = null;
      example = "Europe/Helsinki";
    };
  };

  config = lib.mkMerge [
    (
      if cfg.timezone == null then
        { services.automatic-timezoned.enable = true; }
      else
        { time.timeZone = cfg.timezone; }
    )
    {
      i18n = {
        defaultLocale = "fi_FI.UTF-8";
        extraLocaleSettings = {
          LC_MESSAGES = "en_US.UTF-8";
          LC_NUMERIC = "en_US.UTF-8";
        };
      };

      console.keyMap = "fi";
      # Keyboard layout config in Hyprland (user specific).
    }
  ];
}

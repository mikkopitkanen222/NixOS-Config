# Enable default localization settings: time, languages, keyboard layout.
{
  config,
  lib,
  ...
}:
let
  cfg = config.system.software.locale;
in
{
  options.system.software.locale = {
    enable = lib.mkOption {
      description = "Enable default locale";
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg.enable {
    time.timeZone = "Europe/Helsinki";

    i18n = {
      defaultLocale = "fi_FI.UTF-8";
      extraLocaleSettings = {
        LANGUAGE = "en_US:en:C.UTF-8";
        LC_MESSAGES = "en_US.UTF-8";
        LC_NUMERIC = "en_US.UTF-8";
      };
    };

    services.xserver.xkb = {
      layout = "fi";
      variant = "winkeys";
    };
    console.useXkbConfig = true;
  };
}

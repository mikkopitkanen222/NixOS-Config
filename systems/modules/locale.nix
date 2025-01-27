# Localization settings: time, languages, keyboard layout.
{ ... }:
{
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
}

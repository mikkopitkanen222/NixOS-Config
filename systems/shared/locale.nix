# Configure location, language, and keymap settings.
#
# This module can be imported by all system configs.
{ ... }:
{
  time.timeZone = "Europe/Helsinki";
  i18n = {
    defaultLocale = "fi_FI.UTF-8";
    extraLocaleSettings = {
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

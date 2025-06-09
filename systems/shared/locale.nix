# Configure location, language, and keymap settings.
#
# This module can be imported by all system configs.
{ ... }:
{
  time.timeZone = "Europe/Helsinki";
  i18n.defaultLocale = "fi_FI.UTF-8";
  # extraLocaleSettings set in Home Manager.

  console.keyMap = "fi";
  # Keyboard config in Home Manager.
}

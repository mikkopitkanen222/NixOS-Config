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

  console.keyMap = "fi";
  # Keyboard layout config in Hyprland (user specific).
}

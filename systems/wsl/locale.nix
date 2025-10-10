# nixos-config/systems/wsl/locale.nix
# Configure locale on host 'wsl'.
{ ... }:
{
  time.timeZone = "Europe/Helsinki";
  i18n.defaultLocale = "fi_FI.UTF-8";
  # extraLocaleSettings set in Home Manager.

  console.keyMap = "fi";
  # Keyboard config in Home Manager.
}

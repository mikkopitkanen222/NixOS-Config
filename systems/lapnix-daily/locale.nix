# nixos-config/systems/lapnix-daily/locale.nix
# Configure locale for system 'daily' on host 'lapnix'.
{ ... }:
{
  time.timeZone = "Europe/Helsinki";
  i18n.defaultLocale = "fi_FI.UTF-8";
  # extraLocaleSettings set in Home Manager.

  console.keyMap = "fi";
  # Keyboard config in Home Manager.
}

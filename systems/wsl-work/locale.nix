# nixos-config/systems/wsl-work/locale.nix
# Configure locale for system 'work' on host 'wsl'.
{ ... }:
{
  time.timeZone = "Europe/Helsinki";
  i18n.defaultLocale = "fi_FI.UTF-8";
  # extraLocaleSettings set in Home Manager.

  console.keyMap = "fi";
  # Keyboard config in Home Manager.
}

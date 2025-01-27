# Enable KDE Plasma 6.
{ pkgs, ... }:
{
  services.desktopManager.plasma6.enable = true;

  # Disable unwanted packages enabled by default.
  environment.plasma6.excludePackages = with pkgs.kdePackages; [ kate ];
}

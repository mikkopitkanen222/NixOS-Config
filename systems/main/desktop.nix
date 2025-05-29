# Configure display manager and desktop environment.
#
# This module can be imported by system "main" config.
{ pkgs, ... }:
{
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    # Enable numlock _after_ logging in.
    autoNumlock = true;
  };

  services.desktopManager.plasma6.enable = true;
  environment = {
    sessionVariables.NIXOS_OZONE_WL = "1";
    plasma6.excludePackages = with pkgs.kdePackages; [
      elisa
      gwenview
      kate
      konsole
    ];
  };
}

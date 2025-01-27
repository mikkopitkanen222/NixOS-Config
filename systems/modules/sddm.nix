# Enable graphical login screen.
{ ... }:
{
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;

    # Enable numlock after logging in.
    autoNumlock = true;
  };
}

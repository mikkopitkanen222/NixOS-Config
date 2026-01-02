{ pkgs, ... }:
{
  hardware.logitech.wireless = {
    enable = true;
    # solaar is less featureful than libratbag, but it shows remaining charge and works wirelessly.
    enableGraphical = true;
  };

  # piper is a GUI for ratbagctl, used to remap mouse buttons.
  environment.systemPackages = with pkgs; [ piper ];

  # ratbagd will not detect G502 X when connected wirelessly. Use a cable.
  services.ratbagd.enable = true;

  # When suspending the system, the receiver for G502 X will immediately wake the system back up.
  # There's three ways to make the system stay suspended:
  # 1. Without moving the mouse, suspend the system again after waking up.
  # 2. Unplug and reinsert the receiver, and without moving the mouse, suspend the system.
  # 3. Add an udev rule to disable the receiver's wakeup capability.
  services.udev.extraRules = ''
    # Prevent Logitech Lightspeed receiver for G502 X from waking up the system.
    SUBSYSTEMS=="usb", ATTR{idVendor}=="046d", ATTR{idProduct}=="c547", ATTR{power/wakeup}="disabled"
  '';
}

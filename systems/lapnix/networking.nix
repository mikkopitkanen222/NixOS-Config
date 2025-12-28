{ ... }:
{
  imports = [ ../desknix/networking.nix ];

  networking.networkmanager.wifi.powersave = true;
}

{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [ ../../profiles/gaming.nix ];

  networking.hostName = "desknix";
  system.stateVersion = "25.05";
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # AMD Ryzen 9 9950X3D:
  nixpkgs.hostPlatform = "x86_64-linux";
  hardware.enableRedistributableFirmware = true;
  hardware.cpu.amd.updateMicrocode =
    config.hardware.enableRedistributableFirmware;

  # AMD Radeon RX 9070 XT:
  hardware.amdgpu = {
    # Fix archaic image resolution (640x480) during boot:
    initrd.enable = true;
    opencl.enable = true;
    overdrive.enable = config.services.lact.enable;
  };
  services.lact.enable = true;

  services.getty = {
    autologinUser = lib.head (config.mp222.host.users).name;
    autologinOnce = true;
  };

  mp222 = {
    host.users = [
      {
        name = "mp";
        extraGroups = [ "wheel" ];
      }
    ];
    accessories = {
      mouse.G502X.enable = true;
      keyboard.qmk.enable = true;
    };
    factorio.enable = true;
  };
}

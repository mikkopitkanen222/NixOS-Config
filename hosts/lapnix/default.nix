# Lenovo IdeaPad 1 15ALC7
{
  config,
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.disko.nixosModules.disko
    ./disko.nix
    ./hardware-configuration.nix
  ];

  # Profiles and users:
  mp222 = {
    host.isLaptop = true;
    profiles = {
      personal.enable = true;
      workstation.enable = true;
    };
    users.mp.enable = true;
  };
  services.getty = {
    autologinUser = config.users.users.mp.name;
    autologinOnce = true;
  };

  # AMD Ryzen 5 5500U:
  boot.kernelModules = [ "k10temp" ];
  mp222.host.cpuTempSensor = "k10temp/Tctl";

  # AMD Ryzen 5 5500U iGPU:
  mp222.amdgpu.enable = true;

  # Storage:
  boot.initrd = {
    systemd.enable = true;
    luks.devices.crypted.device = "/dev/disk/by-partlabel/luks";
  };

  # Displays:
  mp222.hyprland = {
    monitors = [
      {
        output = "desc:AU Optronics 0x4A99";
        mode = "1920x1080@60";
        position = "0x0";
        scale = 1.0;
      }
    ];
    workspaces = [
      "1, monitor:desc:AU Optronics 0x4A99, persistent:true, default:true"
      "10, monitor:desc:AU Optronics 0x4A99, persistent:true, layout:scrolling"
    ];
  };

  # Peripherals:
  mp222.fprintd.enable = true;

  environment.systemPackages = [ pkgs.tree ];

  system.stateVersion = "25.11";
}

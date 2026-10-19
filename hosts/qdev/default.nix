# Lenovo ThinkPad T16 Gen 2
{
  imports = [ ./hardware-configuration.nix ];

  # Profiles and users:
  mp222 = {
    host.isLaptop = true;
    profiles = {
      work.enable = true;
      workstation.enable = true;
    };
    users.mp.enable = true;
  };

  # Intel Core i7-1355U:
  boot.kernelModules = [ "coretemp" ];
  mp222.host.cpuTempSensor = "coretemp/Package id 0";

  # Storage:
  mp222.btrfs = {
    scrub.enable = true;
    snapper.enable = true;
  };
  services.snapper.configs = {
    root = {
      SUBVOLUME = "/";
      TIMELINE_LIMIT_DAILY = 7;
      TIMELINE_LIMIT_WEEKLY = 6;
    };
    nix = {
      SUBVOLUME = "/nix";
      TIMELINE_LIMIT_DAILY = 7;
    };
    home = {
      SUBVOLUME = "/home";
      TIMELINE_LIMIT_HOURLY = 8;
      TIMELINE_LIMIT_DAILY = 5;
    };
  };

  # Displays:
  mp222.hyprland = {
    monitors = [
      {
        output = "desc:Lenovo Group Limited D27-40 URHMMCKN";
        mode = "1920x1080@60";
        position = "0x0";
        scale = 1.0;
      }
      {
        output = "desc:Lenovo Group Limited LEN T27h-20 VNA5XD80";
        mode = "2560x1440@60";
        # Position on the left, rotated 90 degrees counter-clockwise:
        position = "-1440x-1000";
        transform = 3;
        scale = 1.0;
      }
      {
        output = "desc:Chimei Innolux Corporation 0x1614";
        mode = "1920x1200@60";
        # Position on the right:
        position = "1920x350";
        scale = 1.0;
      }
    ];
    workspaces = [
      "1, monitor:desc:Lenovo Group Limited D27-40 URHMMCKN, persistent:true, default:true"
      "2, monitor:desc:Lenovo Group Limited LEN T27h-20 VNA5XD80, persistent:true, default:true"
      "3, monitor:desc:Chimei Innolux Corporation 0x1614, persistent:true, default:true"
      "10, monitor:desc:Lenovo Group Limited D27-40 URHMMCKN, persistent:true, layout:scrolling"
    ];
  };

  # Peripherals:
  mp222.fprintd.enable = true;
  hardware.keyboard.qmk.enable = true;

  # Programs:
  virtualisation.podman.enable = true;

  # Dual-boots Windows, which is picked from the boot menu.
  boot.loader.timeout = 5;

  system.stateVersion = "25.11";
}

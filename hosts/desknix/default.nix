{ config, pkgs, ... }: {
  imports = [ ./hardware-configuration.nix ];

  # Profiles and users:
  mp222 = {
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

  # AMD Ryzen 9 9950X3D:
  boot.kernelModules = [ "k10temp" ];
  mp222.host.cpuTempSensor = "k10temp/Tctl";

  # AMD Radeon RX 9070 XT:
  mp222.amdgpu.enable = true;
  mp222.host.amdGpuName = "RX 9070 XT";

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
    persist = {
      SUBVOLUME = "/persist";
      TIMELINE_LIMIT_DAILY = 7;
      TIMELINE_LIMIT_WEEKLY = 6;
    };
  };
  programs.nh.clean = {
    dates = "daily";
    extraArgs = "--keep-since 7d";
  };

  # Displays:
  mp222 = {
    hyprland = {
      monitors = [
        {
          output = "desc:ASUSTek COMPUTER INC VG34VQ3B SCLMTF073685";
          # Maximum refresh rate supporting bitdepth=10 or HDR is 144 Hz:
          mode = "3440x1440@144";
          position = "0x0";
          scale = 1.0;
          bitdepth = 10;
          cm = "wide";
        }
        {
          output = "desc:Acer Technologies Acer KG241 P 0x91305EF3";
          mode = "1920x1080@120";
          # Position on the left, rotated 90 degrees counter-clockwise:
          position = "-1080x-400";
          transform = 3;
          scale = 1.0;
        }
      ];
      workspaces = [
        "1, monitor:desc:ASUSTek COMPUTER INC VG34VQ3B SCLMTF073685, persistent:true, default:true"
        "2, monitor:desc:Acer Technologies Acer KG241 P 0x91305EF3, persistent:true, default:true"
        "10, monitor:desc:ASUSTek COMPUTER INC VG34VQ3B SCLMTF073685, persistent:true, layout:scrolling"
      ];
    };
    dank = {
      mainBar.screens = [ "VG34VQ3B" ];
      secondaryBar.screens = [ "Acer KG241 P" ];
    };
  };

  # Peripherals:
  mp222.g502x.enable = true;
  hardware.keyboard.qmk.enable = true;

  # Programs:
  sops.secrets.factorio_game_password = { };
  sops.templates.factorio-extra-settings.content = builtins.toJSON {
    game_password = config.sops.placeholder.factorio_game_password;
  };
  mp222.factorio = {
    enable = true;
    settingsFile = config.sops.templates.factorio-extra-settings.path;
  };
  home-manager.users.mp.home.packages = [
    pkgs.bs-manager
    pkgs.pcsx2
  ];

  system.stateVersion = "25.05";
}

{ config, pkgs, ... }: {
  users.users.mp = {
    isNormalUser = true;
    extraGroups = [
      "netdev"
      "networkmanager"
      "wheel"
    ];
    hashedPasswordFile = config.sops.secrets."passwd_mp".path;
    shell = pkgs.zsh;
  };

  system.activationScripts."cp-authorizedKeys-mp".text = ''
    mkdir -p "/etc/ssh/authorized_keys.d";
    cp "${config.sops.secrets."openssh_mp".path}" "/etc/ssh/authorized_keys.d/mp";
    chmod +r "/etc/ssh/authorized_keys.d/mp"
  '';

  home-manager.users.mp = {
    programs.home-manager.enable = true;
    home = {
      username = "mp";
      homeDirectory = "/home/mp";
      stateVersion = "25.11";
      packages = with pkgs; [
        nixd
        qalculate-qt
        qimgv
        vlc
      ];
    };
  };

  imports = [
    ../../../lapnix/users/mp/btop.nix
    ./chromium.nix
    ../../../desknix/users/mp/clipse.nix
    ./dank.nix
    ../../../desknix/users/mp/direnv.nix
    ../../../wsl/users/mp/git.nix
    ../../../desknix/users/mp/gtk.nix
    ./hyprland.nix
    ../../../desknix/users/mp/kitty.nix
    ../../../desknix/users/mp/nnn.nix
    ../../../desknix/users/mp/obsidian.nix
    ../../../desknix/users/mp/prompt.nix
    ../../../desknix/users/mp/shell.nix
    ./slack.nix
    ../../../desknix/users/mp/udiskie.nix
    ../../../desknix/users/mp/user-dirs.nix
    ../../../desknix/users/mp/vscodium.nix
    ../../../desknix/users/mp/walls.nix
  ];

  mp222 = {
    hyprland = {
      monitors.monitors = [
        {
          output = "desc:Lenovo Group Limited D27-40 URHMMCKN";
          mode = "1920x1080@60";
          position = "0x0";
          scale = 1;
        }
        # Position on the left, rotated 90 degrees counter-clockwise:
        {
          output = "desc:Lenovo Group Limited LEN T27h-20 VNA5XD80";
          mode = "2560x1440@60";
          position = "-1440x-1000";
          transform = 3;
          scale = 1;
        }
        # Position on the right:
        {
          output = "desc:Chimei Innolux Corporation 0x1614";
          mode = "1920x1200@60";
          position = "1920x350";
          scale = 1;
        }
      ];
      savePower = true;
    };

    slack = {
      enable = true;
      autostart.enable = true;
    };
  };
}

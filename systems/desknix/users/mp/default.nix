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
      stateVersion = "25.05";
      packages = with pkgs; [
        # Downtime
        bolt-launcher
        bs-manager
        pcsx2
        spotify
        # Image, Music & Video Viewers
        qimgv
        vlc
        # Messengers
        # Disable whatsie, as it depends on qt webengine 5.15, which is insecure and fails config eval.
        # Wait until whatsie migrates to qt webengine 6, or look for alternatives.
        # whatsie
        # Work
        nixd
        qalculate-qt
      ];
    };
  };

  imports = [
    ./btop.nix
    ./chromium.nix
    ./clipse.nix
    ./dank.nix
    ./direnv.nix
    ./git.nix
    ./gtk.nix
    ./hyprland.nix
    ./kitty.nix
    ./nnn.nix
    ./obsidian.nix
    ./prompt.nix
    ./proton.nix
    ./shell.nix
    ./thunderbird.nix
    ./udiskie.nix
    ./user-dirs.nix
    ./vesktop.nix
    ./vscodium.nix
    ./walls.nix
  ];

  mp222 = {
    hyprland.monitors.monitors = [
      # Maximum refresh rate supporting bitdepth=10 or HDR is 144 Hz:
      {
        output = "desc:ASUSTek COMPUTER INC VG34VQ3B SCLMTF073685";
        mode = "3440x1440@144";
        position = "0x0";
        scale = 1;
        bitdepth = 10;
        cm = "wide";
      }
      # Position on the left, rotated 90 degrees counter-clockwise:
      {
        output = "desc:Acer Technologies Acer KG241 P 0x91305EF3";
        mode = "1920x1080@120";
        position = "-1080x-400";
        transform = 3;
        scale = 1;
      }
    ];
  };
}

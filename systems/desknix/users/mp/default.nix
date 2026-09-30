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
    ./comma.nix
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
}

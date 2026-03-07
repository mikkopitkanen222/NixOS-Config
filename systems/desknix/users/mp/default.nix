{ config, pkgs, ... }:
{
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
    ./hyprland
    ./btop.nix
    ./chromium.nix
    ./clipse.nix
    ./dank.nix
    ./direnv.nix
    ./git.nix
    ./gtk.nix
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
    ./vscode.nix
    ./walls.nix
  ];
}

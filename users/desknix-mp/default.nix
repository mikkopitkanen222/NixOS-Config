# nixos-config/users/desknix-mp/default.nix
# Configure user 'mp' on host 'desknix'.
{ config, pkgs, ... }:
{
  users.users.mp = {
    isNormalUser = true;
    extraGroups = [
      "netdev"
      "wheel"
    ];
    # openssh.authorizedKeys.keys copied at activation time.
  };

  sops.secrets."openssh_mp" = { };
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

      # Lone packages without further config are installed here:
      packages = with pkgs; [
        # Downtime
        bolt-launcher
        # Image, Music & Video Editors
        gimp-with-plugins
        shotcut
        # Image, Music & Video Viewers
        qimgv
        vlc
        # Messengers
        whatsie
        # Work
        hunspell
        hunspellDicts.en_US
        libreoffice-qt6-fresh
        nixd
        qalculate-qt
      ];
    };
  };

  # Packages requiring config are installed in modules imported here:
  imports = [
    ./hyprland
    ./bash.nix
    ./btop.nix
    ./chromium.nix
    ./clipse.nix
    ./git.nix
    ./gtk.nix
    ./kitty.nix
    ./language.nix
    ./nano.nix
    ./nnn.nix
    ./obsidian.nix
    ./proton.nix
    ./spotify-player.nix
    ./swaync.nix
    ./thunderbird.nix
    ./tofi.nix
    ./udiskie.nix
    ./user-dirs.nix
    ./vesktop.nix
    ./vscode.nix
    ./waybar.nix
  ];
}

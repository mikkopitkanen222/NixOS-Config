# nixos-config/users/desknix-mp/default.nix
# Configure user 'mp' on host 'desknix'.
{ pkgs, ... }:
{
  users.users.mp = {
    isNormalUser = true;
    extraGroups = [
      "netdev"
      "wheel"
    ];
    openssh.authorizedKeys.keyFiles = [ ./key/yubikey.pub ];
  };

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
        obsidian
        qalculate-qt
      ];
    };
  };

  # Packages requiring config are installed in modules imported here:
  imports = [
    ./hyprland
    ./bash.nix
    ./chromium.nix
    ./clipse.nix
    ./git.nix
    ./gtk.nix
    ./kitty.nix
    ./language.nix
    ./nano.nix
    ./nnn.nix
    ./proton.nix
    ./spotify-player.nix
    ./thunderbird.nix
    ./udiskie.nix
    ./user-dirs.nix
    ./vesktop.nix
    ./vscode.nix
  ];
}

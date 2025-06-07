# nixos-config/users/lapnix-mp/default.nix
# Configure user 'mp' on host 'lapnix'.
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
        # Image, Music & Video Viewers
        qimgv
        vlc
        # Messengers
        whatsie
        # Work
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
    ./git.nix
    ./gtk.nix
    ./kitty.nix
    ./language.nix
    ./nano.nix
    ./proton.nix
    ./spotify-player.nix
    ./thunderbird.nix
    ./udiskie.nix
    ./user-dirs.nix
    ./vesktop.nix
    ./vscode.nix
  ];
}

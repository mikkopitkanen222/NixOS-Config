# nixos-config/users/qdev-mp/default.nix
# Configure user 'mp' on host 'qdev'.
{ config, pkgs, ... }:
{
  users.users.mp = {
    isNormalUser = true;
    extraGroups = [
      "netdev"
      "wheel"
    ];
    hashedPasswordFile = config.sops.secrets."passwd_mp".path;
    # openssh.authorizedKeys.keys copied at activation time.
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

      # Lone packages without further config are installed here:
      packages = with pkgs; [
        # Image, Music & Video Viewers
        qimgv
        vlc
        # Work
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
    ./swaync.nix
    ./tofi.nix
    ./udiskie.nix
    ./user-dirs.nix
    ./vscode.nix
    ./waybar.nix
  ];
}

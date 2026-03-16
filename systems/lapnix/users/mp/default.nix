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
      stateVersion = "25.11";
      packages = with pkgs; [
        # Downtime
        bolt-launcher
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
    ../../../desknix/users/mp/chromium.nix
    ../../../desknix/users/mp/clipse.nix
    ./dank.nix
    ../../../desknix/users/mp/direnv.nix
    ../../../desknix/users/mp/git.nix
    ../../../desknix/users/mp/gtk.nix
    ./hyprland.nix
    ../../../desknix/users/mp/kitty.nix
    ../../../desknix/users/mp/nnn.nix
    ../../../desknix/users/mp/obsidian.nix
    ../../../desknix/users/mp/prompt.nix
    ../../../desknix/users/mp/proton.nix
    ../../../desknix/users/mp/shell.nix
    ../../../desknix/users/mp/thunderbird.nix
    ../../../desknix/users/mp/udiskie.nix
    ../../../desknix/users/mp/user-dirs.nix
    ../../../desknix/users/mp/vesktop.nix
    ../../../desknix/users/mp/vscode.nix
    ../../../desknix/users/mp/walls.nix
  ];
}

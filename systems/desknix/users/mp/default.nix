{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  wm-eval = inputs.wrapper-manager.lib {
    inherit pkgs;
    modules = [
      inputs.self.wrappers.mp
      { _module.args.systemConfig = config; }
      {
        mp222 = {
          git.enable = true;
          starship.enable = true;
          zsh = {
            enable = true;
            # TODO: Move to hyprland (when wrapped)
            loginShellInit = ''
              if [[ "$(tty)" = "/dev/tty1" ]] && uwsm check may-start; then
                exec uwsm start hyprland-uwsm.desktop
              fi
            '';
            # TODO: Move to direnv (when wrapped)
            interactiveShellInit = lib.optionalString config.home-manager.users.mp.programs.direnv.enable ''
              eval "$(${lib.getExe config.home-manager.users.mp.programs.direnv.package} hook zsh)"
            '';
            # TODO: Move to vscode (when wrapped)
            shellAliases = {
              "code" = "codium";
            };
          };
        };
      }
    ];
  };
in
{
  users.users.mp = {
    isNormalUser = true;
    extraGroups = [
      "netdev"
      "networkmanager"
      "wheel"
    ];
    hashedPasswordFile = config.sops.secrets."passwd_mp".path;
    packages = builtins.attrValues wm-eval.config.build.packages;
    shell = wm-eval.config.build.packages.zsh;
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
    ./direnv.nix
    ./gtk.nix
    ./hyprpanel.nix
    ./kitty.nix
    ./nnn.nix
    ./obsidian.nix
    ./proton.nix
    ./spotify-player.nix
    ./thunderbird.nix
    ./tofi.nix
    ./udiskie.nix
    ./user-dirs.nix
    ./vesktop.nix
    ./vscode.nix
  ];
}

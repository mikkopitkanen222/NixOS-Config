{
  config,
  inputs,
  pkgs,
  ...
}:
let
  wm-eval = inputs.wrapper-manager.lib {
    inherit pkgs;
    modules = [
      inputs.self.wrappers.mp
      { _module.args.systemConfig = config; }
      { mp222 = { }; }
    ];
  };
in
{
  users.users.mp = {
    isNormalUser = true;
    extraGroups = [
      "netdev"
      "wheel"
    ];
    hashedPasswordFile = config.sops.secrets."passwd_mp".path;
    packages = builtins.attrValues wm-eval.config.build.packages;
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
    ../../../desknix/users/mp/bash.nix
    ./btop.nix
    ../../../desknix/users/mp/chromium.nix
    ../../../desknix/users/mp/clipse.nix
    ../../../desknix/users/mp/direnv.nix
    ../../../desknix/users/mp/git.nix
    ../../../desknix/users/mp/gtk.nix
    ../../../desknix/users/mp/kitty.nix
    ../../../desknix/users/mp/language.nix
    ../../../desknix/users/mp/nano.nix
    ../../../desknix/users/mp/nnn.nix
    ../../../desknix/users/mp/obsidian.nix
    ../../../desknix/users/mp/proton.nix
    ../../../desknix/users/mp/spotify-player.nix
    ../../../desknix/users/mp/swaync.nix
    ../../../desknix/users/mp/thunderbird.nix
    ./tofi.nix
    ../../../desknix/users/mp/udiskie.nix
    ../../../desknix/users/mp/user-dirs.nix
    ../../../desknix/users/mp/vesktop.nix
    ../../../desknix/users/mp/vscode.nix
    ./waybar.nix
  ];
}

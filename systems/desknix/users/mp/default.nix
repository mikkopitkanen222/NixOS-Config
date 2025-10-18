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
        # Downtime
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
    ./bash.nix
    ./btop.nix
    ./chromium.nix
    ./clipse.nix
    ./direnv.nix
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

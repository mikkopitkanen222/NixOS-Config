# nixos-config/users/desknix-mp/proton.nix
# Configure Proton software suite for user 'mp' on host 'desknix'.
{
  config,
  inputs,
  pkgs,
  ...
}:
{
  home-manager.users.mp = {
    home.packages = with pkgs; [
      proton-pass
      protonvpn-gui
    ];

    services.protonmail-bridge.enable = true;

    programs.rclone = {
      enable = true;
      remotes.proton = {
        config = {
          type = "protondrive";
          enable_caching = false;
        };
        mounts."" = {
          enable = true;
          mountPoint = "/persist/proton";
          options = {
            dir-cache-time = "732h";
            dir-perms = "700";
            file-perms = "600";
            link-perms = "600";
            vfs-cache-mode = "writes";
          };
        };
        secrets = {
          username = config.sops.secrets."protondrive/username".path;
          password = config.sops.secrets."protondrive/password".path;
          "2fa" = config.sops.secrets."protondrive/2fa".path;
          client_uid = config.sops.secrets."protondrive/client_uid".path;
          client_access_token =
            config.sops.secrets."protondrive/client_access_token".path;
          client_refresh_token =
            config.sops.secrets."protondrive/client_refresh_token".path;
          client_salted_key_pass =
            config.sops.secrets."protondrive/client_salted_key_pass".path;
        };
      };
    };

    systemd.user.services."rclone-mount:@proton" = {
      # Stop trying to mount proton: after a couple failed tries.
      # Otherwise 10 attempts in a row are fired off right at boot,
      # causing invalidation of saved protondrive credentials.
      Unit = {
        StartLimitIntervalSec = 150;
        StartLimitBurst = 2;
      };
      Service = {
        RestartSec = 60;
      };
    };
  };

  sops.secrets =
    let
      proton-sops = {
        sopsFile = "${inputs.nixos-secrets}/desknix-proton.yaml";
        owner = config.users.users.mp.name;
      };
    in
    {
      "protondrive/username" = proton-sops;
      "protondrive/password" = proton-sops;
      "protondrive/2fa" = proton-sops;
      "protondrive/client_uid" = proton-sops;
      "protondrive/client_access_token" = proton-sops;
      "protondrive/client_refresh_token" = proton-sops;
      "protondrive/client_salted_key_pass" = proton-sops;
    };
}

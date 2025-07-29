# nixos-config/users/lapnix-mp/proton.nix
# Configure Proton software suite for user 'mp' on host 'lapnix'.
{ pkgs, ... }:
{
  home-manager.users.mp = {
    home.packages = with pkgs; [
      proton-pass
      protonmail-bridge
      protonvpn-gui
    ];

    systemd.user.services.protonmail-bridge = {
      Unit = {
        Description = "Protonmail Bridge";
        After = [ "network-online.target" ];
      };
      Service = {
        Restart = "always";
        ExecStart = "${pkgs.protonmail-bridge}/bin/protonmail-bridge -n";
      };
      Install = {
        WantedBy = [ "default.target" ];
      };
    };

    # rclone.conf must be created imperatively due to 2FA.
    # Todo: Use (sops-nix, agenix, ?) etc. and create it here declaratively.
    programs.rclone = {
      enable = true;
      #  remotes.proton = {
      #    config = {
      #      type = "protondrive";
      #      username = "foobar";
      #      enable_caching = false;
      #    };
      #    secrets = {
      #      password = "/run/secrets/proton2";
      #      "2fa" = "/run/secrets/proton3";
      #    };
      #  };
    };

    systemd.user.services.protondrive-mount = {
      Unit = {
        Description = "Mount Proton Drive";
        After = [ "network-online.target" ];
      };
      Service = {
        Type = "notify";
        ExecStartPre = "/usr/bin/env mkdir -p /persist/proton";
        ExecStart = "${pkgs.rclone}/bin/rclone --config=/persist/secrets/rclone.conf --vfs-cache-mode writes --ignore-checksum mount proton: /persist/proton";
        ExecStop = "/bin/fusermount -u /persist/proton/%i";
      };
      Install = {
        WantedBy = [ "default.target" ];
      };
    };
  };
}

{ config, lib, ... }:
let
  cfg = config.mp222.sshd;
in
{
  options.mp222.sshd = {
    enable = lib.mkEnableOption "incoming SSH connections";
  };

  config = lib.mkIf cfg.enable {
    sops.secrets = lib.mapAttrs' (
      name: _:
      lib.nameValuePair "openssh_${name}" {
        path = "/etc/ssh/authorized_keys.d/${name}";
        owner = name;
        mode = "0400";
      }
    ) config.mp222.users;

    services.openssh = {
      enable = true;
      settings = {
        # Require crypto keys to log in.
        KbdInteractiveAuthentication = false;
        PasswordAuthentication = false;
        # Root user does not need to log in remotely.
        PermitRootLogin = "no";
      };
    };
  };
}

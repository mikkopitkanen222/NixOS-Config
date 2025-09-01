# nixos-config/systems/desknix-daily/sops.nix
# Configure sops for system 'daily' on host 'desknix'.
# https://github.com/Mic92/sops-nix
{ config, inputs, ... }:
{
  imports = [ inputs.sops-nix.nixosModules.sops ];

  sops = {
    defaultSopsFile = "${inputs.nixos-secrets}/desknix.yaml";
    defaultSopsFormat = "yaml";
    age = {
      generateKey = false;
      sshKeyPaths = [ ];
    };
    gnupg = {
      home = "/var/lib/sops";
      sshKeyPaths = [ ];
    };
    secrets = {
      "passwd_mp".neededForUsers = true;
      "openssh_mp" = { };
      "u2f_keys" = {
        group = config.users.users.mp.group;
        mode = "0440";
      };
    };
  };
}

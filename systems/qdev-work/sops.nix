# nixos-config/systems/qdev-work/sops.nix
# Configure sops for system 'work' on host 'qdev'.
# https://github.com/Mic92/sops-nix
{ config, inputs, ... }:
{
  imports = [ inputs.sops-nix.nixosModules.sops ];

  sops = {
    defaultSopsFile = "${inputs.nixos-secrets}/qdev.yaml";
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
      "work_email" = { };
    };
  };
}

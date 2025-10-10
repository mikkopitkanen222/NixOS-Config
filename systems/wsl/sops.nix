# nixos-config/systems/wsl/sops.nix
# Configure sops on host 'wsl'.
# https://github.com/Mic92/sops-nix
{ inputs, ... }:
{
  imports = [ inputs.sops-nix.nixosModules.sops ];

  sops = {
    defaultSopsFile = "${inputs.nixos-secrets}/wsl.yaml";
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
      "work_email" = { };
    };
  };
}

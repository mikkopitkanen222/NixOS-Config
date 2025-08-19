# nixos-config/systems/lapnix-daily/sops.nix
# Configure sops for system 'daily' on host 'lapnix'.
# https://github.com/Mic92/sops-nix
{ inputs, ... }:
{
  imports = [ inputs.sops-nix.nixosModules.sops ];

  sops = {
    defaultSopsFile = "${inputs.nixos-secrets}/lapnix.yaml";
    defaultSopsFormat = "yaml";
    gnupg = {
      home = "/var/lib/sops";
      sshKeyPaths = [ ];
    };
  };
}

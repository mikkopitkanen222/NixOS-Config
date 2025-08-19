# nixos-config/systems/desknix-daily/sops.nix
# Configure sops for system 'daily' on host 'desknix'.
# https://github.com/Mic92/sops-nix
{ inputs, ... }:
{
  imports = [ inputs.sops-nix.nixosModules.sops ];

  sops = {
    defaultSopsFile = "${inputs.nixos-secrets}/desknix.yaml";
    defaultSopsFormat = "yaml";
    gnupg = {
      home = "/var/lib/sops";
      sshKeyPaths = [ ];
    };
  };
}

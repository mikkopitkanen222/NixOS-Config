# nixos-config/systems/wsl-work/sops.nix
# Configure sops for system 'work' on host 'wsl'.
# https://github.com/Mic92/sops-nix
{ inputs, ... }:
{
  imports = [ inputs.sops-nix.nixosModules.sops ];

  sops = {
    defaultSopsFile = "${inputs.nixos-secrets}/wsl.yaml";
    defaultSopsFormat = "yaml";
    gnupg = {
      home = "/var/lib/sops";
      sshKeyPaths = [ ];
    };
  };
}

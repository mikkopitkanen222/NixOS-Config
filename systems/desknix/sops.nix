# https://github.com/Mic92/sops-nix
{ config, inputs, ... }:
{
  imports = [ inputs.sops-nix.nixosModules.sops ];

  sops = {
    defaultSopsFile = "${inputs.nixos-secrets}/${config.networking.hostName}.yaml";
    defaultSopsFormat = "yaml";
    age = {
      generateKey = false;
      sshKeyPaths = [ ];
    };
    gnupg = {
      home = "/var/lib/sops";
      sshKeyPaths = [ ];
    };
  };
}

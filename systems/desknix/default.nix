{ config, pkgs, ... }:
{
  imports = [
    ./games.nix
    ./iwgtk.nix
    ./locale.nix
    ./nixos.nix
    ./overskride.nix
    ./pipewire.nix
    ./security.nix
    ./smartcard-crypto.nix
    ./sops.nix
    ./vscode-server.nix
  ];

  # Lone packages without further config are installed here:
  environment.systemPackages = with pkgs; [ tree ];

  # Overlays output by our flake are enabled here:
  nixpkgs.overlays = [ ];

  mp222.enableFactorio = true;

  sops.secrets = {
    "passwd_mp".neededForUsers = true;
    "openssh_mp" = { };
    "u2f_keys" = {
      group = config.users.users.mp.group;
      mode = "0440";
    };
  };
}

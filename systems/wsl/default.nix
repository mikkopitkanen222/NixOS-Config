{ pkgs, ... }:
{
  imports = [
    ../desknix/locale.nix
    ../lapnix/nixos.nix
    ../desknix/smartcard-crypto.nix
    ../desknix/sops.nix
    ../desknix/vscode-server.nix
  ];

  # Lone packages without further config are installed here:
  environment.systemPackages = with pkgs; [
    tree
    wget
  ];

  # Overlays output by our flake are enabled here:
  nixpkgs.overlays = [ ];

  sops.secrets = {
    "passwd_mp".neededForUsers = true;
    "work_email" = { };
  };
}

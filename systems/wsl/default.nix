{ lib, pkgs, ... }:
let
  users = [ "mp" ];
in
{
  imports = [
    ./host-configuration.nix
    ../desknix/locale.nix
    ../lapnix/nixos.nix
    ../desknix/smartcard-crypto.nix
    ../desknix/sops.nix
    ../desknix/terminal-text-editor.nix
    ../desknix/vscode-server.nix
  ]
  ++ (lib.map (user: ./. + "/users/${user}") users);

  # Lone packages without further config are installed here:
  environment.systemPackages = with pkgs; [
    tree
    wget
  ];

  # Overlays output by our flake are enabled here:
  nixpkgs.overlays = [ ];

  wsl.defaultUser = lib.head users;

  sops.secrets = {
    "passwd_mp".neededForUsers = true;
    "work_email" = { };
  };
}

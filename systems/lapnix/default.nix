{
  config,
  lib,
  pkgs,
  ...
}:
let
  host = "lapnix";
  users = [ "mp" ];
in
{
  imports = [
    ../desknix/games.nix
    ../desknix/iwgtk.nix
    ../desknix/locale.nix
    ./nixos.nix
    ../desknix/overskride.nix
    ../desknix/pipewire.nix
    ../desknix/security.nix
    ../desknix/smartcard-crypto.nix
    ../desknix/sops.nix
    ../desknix/vscode-server.nix
  ]
  ++ (lib.singleton (./. + "/../../hosts/${host}"))
  ++ (lib.map (user: ./. + "/users/${user}") users);

  # Lone packages without further config are installed here:
  environment.systemPackages = with pkgs; [ tree ];

  # Overlays output by our flake are enabled here:
  nixpkgs.overlays = [ ];

  sops.secrets = {
    "passwd_mp".neededForUsers = true;
    "openssh_mp" = { };
    "u2f_keys" = {
      group = config.users.users.mp.group;
      mode = "0440";
    };
  };
}

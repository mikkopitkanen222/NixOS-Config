{
  config,
  lib,
  pkgs,
  ...
}:
let
  users = [ "mp" ];
in
{
  imports = [
    ./boot-splash.nix
    ../desknix/games.nix
    ./hardware-configuration.nix
    ./host-configuration.nix
    ../desknix/iwgtk.nix
    ../desknix/locale.nix
    ./nixos.nix
    ../desknix/overskride.nix
    ../desknix/pipewire.nix
    ../desknix/security.nix
    ../desknix/smartcard-crypto.nix
    ../desknix/sops.nix
    ../desknix/terminal-text-editor.nix
    ../desknix/vscode-server.nix
  ]
  ++ (lib.map (user: ./. + "/users/${user}") users);

  # Lone packages without further config are installed here:
  environment.systemPackages = with pkgs; [ tree ];

  # Overlays output by our flake are enabled here:
  nixpkgs.overlays = [ ];

  services.getty = {
    autologinUser = lib.head users;
    autologinOnce = true;
  };

  sops.secrets = {
    "passwd_mp".neededForUsers = true;
    "openssh_mp" = { };
    "u2f_keys" = {
      group = config.users.users.mp.group;
      mode = "0440";
    };
  };
}

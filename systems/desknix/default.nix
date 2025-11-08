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
    ./games.nix
    ./hardware-configuration.nix
    ./host-configuration.nix
    ./iwgtk.nix
    ./locale.nix
    ./nixos.nix
    ./overskride.nix
    ./pipewire.nix
    ./security.nix
    ./smartcard-crypto.nix
    ./sops.nix
    ./terminal-text-editor.nix
    ./vscode-server.nix
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

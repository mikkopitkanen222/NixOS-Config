# Configuration for user "mp".
{
  config,
  lib,
  pkgs,
  ...
}:
{
  users.users.mp = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    openssh.authorizedKeys.keyFiles = [ ./key/yubikey.pub ];
  };

  home-manager.users.mp = import ./home.nix { inherit config lib pkgs; };

  unfree.allowedPackages = [
    "obsidian"
    "spotify"
  ];
}

# Configuration for user "mp".
{ ... }:
{
  users.users.mp = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    openssh.authorizedKeys.keyFiles = [ ./key/yubikey.pub ];
  };

  home-manager.users.mp = ./home.nix;

  unfree.allowedPackages = [
    "obsidian"
    "spotify"
  ];
}

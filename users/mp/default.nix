# Configuration for user "mp".
{ ... }:
{
  imports = [ ./home.nix ];

  users.users.mp = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    openssh.authorizedKeys.keyFiles = [ ./key/yubikey.pub ];
  };

  unfree.allowedPackages = [
    "obsidian"
    "spotify"
  ];
}

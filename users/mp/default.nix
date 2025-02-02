# mp user configuration.
{ ... }:
let
  username = "mp";
in
{
  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    openssh.authorizedKeys.keyFiles = [
      ./key/yubikey.pub
    ];
  };

  home-manager.users.${username} = {
    programs.home-manager.enable = true;
    home = {
      inherit username;
      homeDirectory = "/home/${username}";
      stateVersion = "24.11";
    };
  };

  imports = [
    ./git.nix
    ../modules/plasma-browser-integration.nix
  ];

  plasmaBrowserIntegration.mp.enable = true;
}

# nixos-config/users/wsl-mp/default.nix
# Configure user 'mp' on host 'wsl'.
{ config, pkgs, ... }:
{
  users.users.mp = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    hashedPasswordFile = config.sops.secrets."passwd_mp".path;
  };
  sops.secrets."passwd_mp".neededForUsers = true;

  home-manager.users.mp = {
    programs.home-manager.enable = true;

    home = {
      username = "mp";
      homeDirectory = "/home/mp";
      stateVersion = "25.05";

      # Lone packages without further config are installed here:
      packages = with pkgs; [
        # Work
        nixd
      ];
    };
  };

  # Packages requiring config are installed in modules imported here:
  imports = [
    ./bash.nix
    ./git.nix
    ./language.nix
    ./nano.nix
  ];
}

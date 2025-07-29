# nixos-config/users/wsl-mp/default.nix
# Configure user 'mp' on host 'wsl'.
{ pkgs, ... }:
{
  users.users.mp = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

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

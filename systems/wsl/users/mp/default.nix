{ config, pkgs, ... }:
{
  users.users.mp = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    hashedPasswordFile = config.sops.secrets."passwd_mp".path;
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
    ../../../desknix/users/mp/direnv.nix
    ./git.nix
    ../../../desknix/users/mp/language.nix
    ../../../desknix/users/mp/nano.nix
  ];
}

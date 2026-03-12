{ config, pkgs, ... }:
{
  users.users.mp = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    hashedPasswordFile = config.sops.secrets."passwd_mp".path;
    shell = pkgs.zsh;
  };

  home-manager.users.mp = {
    programs.home-manager.enable = true;
    home = {
      username = "mp";
      homeDirectory = "/home/mp";
      stateVersion = "25.05";
      packages = with pkgs; [
        # Work
        nixd
      ];
    };
  };

  imports = [
    ../../../desknix/users/mp/direnv.nix
    ./git.nix
    ../../../desknix/users/mp/prompt.nix
    ../../../desknix/users/mp/shell.nix
  ];
}

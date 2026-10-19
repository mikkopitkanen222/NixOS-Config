{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.mp222.profiles.base;
in
{
  options.mp222.profiles.base = {
    enable = lib.mkEnableOption "the base user profile";
  };

  config = lib.mkIf cfg.enable {
    mp222 = lib.mkDefault {
      # Apps
      comma.enable = true;
      git.enable = true;
      # Infra
      direnv.enable = true;
      gpg.enable = true;
      starship.enable = true;
      zsh.enable = true;
    };

    home.packages = [ pkgs.nixd ];
  };
}

{ config, lib, ... }:
let
  cfg = config.mp222.git;
in
{
  options.mp222.git = {
    enable = lib.mkEnableOption "git";
  };

  config = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;
      settings = {
        core = {
          editor = lib.mkIf config.programs.vscodium.enable "codium --wait";
          pager = "less -x2";
        };
        init.defaultBranch = "master";
      };
      signing.signByDefault = true;
    };
  };
}

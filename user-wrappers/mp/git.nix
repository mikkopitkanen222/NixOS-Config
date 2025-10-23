{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.mp222.git;

  gitconfig = pkgs.writeText "mp-gitconfig" ''
    [user]
      name = "Mikko Pitkänen"
      email = "mikko.pitkanen.code@pm.me"

    [init]
      defaultBranch = "master"

    [core]
      pager = "less -x2"

    [commit]
      gpgSign = true

    [tag]
      gpgSign = true

    ${cfg.includes}
  '';
in
{
  options.mp222.git = {
    enable = lib.mkEnableOption "Git";

    package = lib.mkPackageOption pkgs "git" { };

    includes = lib.mkOption {
      type = lib.types.lines;
      default = "";
      description = "File includes appended to main Git config.";
    };
  };

  config = lib.mkIf cfg.enable {
    wrappers.git = {
      basePackage = cfg.package;
      env.GIT_CONFIG_GLOBAL.value = gitconfig;
    };
  };
}

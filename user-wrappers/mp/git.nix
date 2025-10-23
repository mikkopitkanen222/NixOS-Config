{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.mp222.git;

  # From HM:
  gitIniType =
    with lib.types;
    let
      primitiveType = either str (either bool int);
      multipleType = either primitiveType (listOf primitiveType);
      sectionType = attrsOf multipleType;
      supersectionType = attrsOf (either multipleType sectionType);
    in
    attrsOf supersectionType;

  gitIncludesType =
    with lib.types;
    listOf (submodule {
      options.path = lib.mkOption {
        type = either str path;
        description = "Path of the configuration file to include.";
      };
    });

  defaultGitConfig = {
    user = {
      name = "Mikko Pitkänen";
      email = "mikko.pitkanen.code@pm.me";
    };
    core.pager = "less -x2";
    init.defaultBranch = "master";
    commit.gpgSign = true;
    tag.gpgSign = true;
  };

  gitconfig =
    lib.generators.toGitINI cfg.settings
    + "\n"
    + lib.concatStringsSep "\n" (
      map lib.generators.toGitINI (
        map (include: { include.path = "${include.path}"; }) cfg.includes
      )
    );
in
{
  options.mp222.git = {
    enable = lib.mkEnableOption "Git";

    package = lib.mkPackageOption pkgs "git" { };

    settings = lib.mkOption {
      type = gitIniType;
      default = defaultGitConfig;
      description = "Configuration written to Git's config file.";
    };

    includes = lib.mkOption {
      type = gitIncludesType;
      default = [ ];
      description = "List of configuration files to include.";
    };
  };

  config = lib.mkIf cfg.enable {
    wrappers.git = {
      basePackage = cfg.package;
      env.GIT_CONFIG_GLOBAL.value = builtins.toFile "mp-git-config" gitconfig;
    };
  };
}

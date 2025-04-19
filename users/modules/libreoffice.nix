# Configuration for user module "libreoffice".
{
  config,
  lib,
  pkgs,
  ...
}:
let
  moduleOptions = {
    options.libreoffice = {
      enable = lib.mkEnableOption "libreoffice";

      package = lib.mkPackageOption pkgs "libreoffice" { };

      spellcheck.enable = lib.mkEnableOption "hunspell";

      spellcheck.languages = lib.mkOption {
        description = "List of enabled hunspell dictionaries.";
        type = lib.types.listOf lib.types.str;
        default = [ ];
        example = [ "en_US" ];
      };
    };
  };

  moduleConfig =
    user: cfg:
    let
      module = cfg.libreoffice;
    in
    lib.mkMerge [
      (lib.mkIf module.enable { home.packages = [ module.package ]; })
      (lib.mkIf (module.enable && module.spellcheck.enable) {
        home.packages = [
          pkgs.hunspell
        ] ++ (builtins.map (x: pkgs.hunspellDicts.${x}) module.spellcheck.languages);
      })
    ];

  cfg = config.build.user;
in
{
  options = {
    build.user = lib.mkOption { type = lib.types.attrsOf (lib.types.submodule moduleOptions); };
  };

  config = {
    home-manager.users = builtins.mapAttrs (moduleConfig) cfg;
  };
}

# Configuration for user module "nano".
{
  config,
  lib,
  pkgs,
  ...
}:
let
  moduleOptions = {
    options.nano = {
      enable = lib.mkOption {
        description = ''
          Whether to enable nano.
          Nano is enabled system-wide by default on NixOS,
          so this option is not needed most of the time.
        '';
        type = lib.types.bool;
        default = false;
        example = true;
      };

      package = lib.mkPackageOption pkgs "nano" { };

      syntaxHighlight = lib.mkOption {
        description = ''
          Whether to include syntax highlighting files.
          The system-wide options include these by default.
        '';
        type = lib.types.bool;
        default = false;
        example = true;
      };

      usableDefaults = lib.mkEnableOption "usable nanorc defaults";

      extraConfig = lib.mkOption {
        description = "Extra nanorc commands appended after default commands.";
        type = lib.types.lines;
        default = "";
        example = ''
          unset positionlog
          set tabsize 4
        '';
      };
    };
  };

  moduleConfig =
    user: cfg:
    let
      module = cfg.nano;
    in
    lib.mkIf (config.programs.nano.enable || module.enable) {
      home.packages = lib.mkIf module.enable [ module.package ];

      home.file.".config/nano/nanorc".text = builtins.concatStringsSep "\n" [
        (
          if module.syntaxHighlight then
            ''
              # load syntax highlighting files
              include "${pkgs.nano}/share/nano/*.nanorc"
              include "${pkgs.nano}/share/nano/extra/*.nanorc"
            ''
          else
            ""
        )
        (
          if module.usableDefaults then
            ''
              set autoindent
              set linenumbers
              set mouse
              set positionlog
              set tabsize 2
            ''
          else
            ""
        )
        module.extraConfig
      ];
    };

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

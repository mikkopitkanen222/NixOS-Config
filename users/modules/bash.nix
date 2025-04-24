# Configuration for user module "bash".
{
  config,
  lib,
  pkgs,
  ...
}:
let
  coloredText.options =
    let
      channel = c: {
        description = "${c} color channel value.";
        type = lib.types.ints.u8;
        default = 0;
        example = 255;
      };

      rgb.options = {
        r = lib.mkOption (channel "Red");
        g = lib.mkOption (channel "Green");
        b = lib.mkOption (channel "Blue");
      };

      color = g: {
        description = "${g} text color.";
        type = lib.types.nullOr (lib.types.submodule rgb);
        default = null;
        example = { };
      };
    in
    {
      foreground = lib.mkOption (color "Foreground");
      background = lib.mkOption (color "Background");
      text = lib.mkOption {
        description = "Text being colored.";
        type = lib.types.str;
        default = "";
        example = "\\u@\\h";
      };
    };

  renderText =
    ct:
    let
      colorToString =
        rgb:
        builtins.concatStringsSep ";" (
          builtins.map (c: builtins.toString rgb.${c}) [
            "r"
            "g"
            "b"
          ]
        );
    in
    if (ct.foreground != null || ct.background != null) then
      builtins.concatStringsSep "" [
        "\\033["
        (if (ct.foreground != null) then "38;2;${colorToString ct.foreground}" else "")
        (if (ct.foreground != null && ct.background != null) then ";" else "")
        (if (ct.background != null) then "48;2;${colorToString ct.background}" else "")
        "m\\]"
        ct.text
        "\\033[0m\\]"
      ]
    else
      ct.text;

  moduleOptions = {
    options = {
      bash = {
        usableDefaults = lib.mkEnableOption "usable bashrc defaults";

        gitPrompt = lib.mkEnableOption "sourcing git completions and git prompt";

        bashPrompt = lib.mkOption {
          description = "24-bit colored bash prompt.";
          type = lib.types.nullOr (lib.types.listOf (lib.types.submodule coloredText));
          default = null;
          example = [
            {
              foreground = {
                r = 255;
                b = 127;
              };
              text = "\\w ";
            }
          ];
        };

        devshellPrompt = lib.mkOption {
          description = "24-bit colored bash prompt when inside Nix devshell.";
          type = lib.types.nullOr (lib.types.listOf (lib.types.submodule coloredText));
          default = null;
          example = [
            {
              foreground = {
                r = 255;
                b = 127;
              };
              text = "\\w ";
            }
          ];
        };
      };
    };
  };

  moduleConfig =
    user: cfg:
    let
      module = cfg.bash;
    in
    lib.mkMerge [
      (lib.mkIf module.usableDefaults {
        programs.bash = {
          enable = true;
          historyControl = [ "ignoreboth" ];
          historyIgnore = [
            "clear"
            "ls"
            "pwd"
            "cd"
            "exit"
          ];
          shellAliases = {
            "ll" = "ls -l";
            ".." = "cd ..";
            "..." = "cd ../..";
          };
        };
      })
      (lib.mkIf (module.gitPrompt || module.bashPrompt != null) {
        programs.bash.initExtra = builtins.concatStringsSep "" [
          (
            if module.gitPrompt then
              ''
                . /etc/profiles/per-user/${user}/share/bash-completion/completions/git
                . /etc/profiles/per-user/${user}/share/bash-completion/completions/git-prompt.sh
                export GIT_PS1_SHOWDIRTYSTATE=1
              ''
            else
              ""
          )
          (
            if module.bashPrompt != null then
              "PS1='${builtins.concatStringsSep "" (builtins.map renderText module.bashPrompt)}'"
            else
              ""
          )
        ];
      })
      (lib.mkIf (module.devshellPrompt != null) {
        nix.settings = {
          bash-prompt = builtins.concatStringsSep "" (builtins.map renderText module.devshellPrompt);
        };
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

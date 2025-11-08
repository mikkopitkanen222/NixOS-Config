{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  wm-eval = inputs.wrapper-manager.lib {
    inherit pkgs;
    modules = [
      inputs.self.wrappers.mp
      { _module.args.systemConfig = config; }
      {
        mp222 = {
          git = {
            enable = true;
            includes = ''
              [include]
                path = ${config.sops.templates."secret-gitconfig".path}
            '';
          };
          starship.enable = true;
          zsh = {
            enable = true;
            # TODO: Move to direnv (when wrapped)
            interactiveShellInit = lib.optionalString config.home-manager.users.mp.programs.direnv.enable ''
              eval "$(${lib.getExe config.home-manager.users.mp.programs.direnv.package} hook zsh)"
            '';
          };
        };
      }
    ];
  };
in
{
  users.users.mp = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    hashedPasswordFile = config.sops.secrets."passwd_mp".path;
    packages = builtins.attrValues wm-eval.config.build.packages;
    shell = wm-eval.config.build.packages.zsh;
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
    ../../../desknix/users/mp/language.nix
  ];

  sops.templates."secret-gitconfig" = {
    content = ''
      [user]
        email = "${config.sops.placeholder."work_email"}"
    '';
    owner = config.users.users.mp.name;
  };
}

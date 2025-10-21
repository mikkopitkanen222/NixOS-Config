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
          starship.enable = true;
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
    ./bash.nix
    ../../../desknix/users/mp/direnv.nix
    ./git.nix
    ../../../desknix/users/mp/language.nix
    ../../../desknix/users/mp/nano.nix
  ];

  # TODO: Move this to bash wrapper when bash is configured using WM.
  # This must be here for now, because wm-eval is not available in other modules.
  # In wrapper modules it is "implicitly" available: config.build.packages.starship works.
  home-manager.users.mp.programs.bash.initExtra = ''
    if [[ $TERM != "dumb" ]]; then
      eval "$(${lib.getExe wm-eval.config.build.packages.starship} init bash --print-full-init)"
    fi
  '';
}

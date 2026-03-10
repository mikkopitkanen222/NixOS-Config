{
  config,
  inputs,
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
    ../../../desknix/users/mp/shell.nix
  ];
}

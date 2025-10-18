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
      { mp222 = { }; }
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
}

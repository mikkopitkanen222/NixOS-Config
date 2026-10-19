{ config, lib, ... }:
let
  cfg = config.mp222.users.mp;
in
lib.mkMerge [
  {
    mp222.users.mp = {
      admin = lib.mkDefault true;
      home = ./home.nix;
    };
  }
  (lib.mkIf cfg.enable {
    sops = lib.mkIf config.mp222.profiles.work.enable {
      secrets.work_email = { };
      templates.secret-gitconfig = {
        content = lib.generators.toINI { } {
          user.email = config.sops.placeholder.work_email;
        };
        owner = config.users.users.mp.name;
      };
    };
  })
]

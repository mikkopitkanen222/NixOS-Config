{ lib, osConfig, ... }:
let
  work = osConfig.mp222.profiles.work.enable;

  workstation = osConfig.mp222.profiles.workstation.enable;
in
{
  mp222.profiles = {
    base.enable = true;
    personal.enable = workstation && !work;
    work.enable = work;
    workstation.enable = workstation;
  };

  programs.git = {
    settings.user = {
      name = "Mikko Pitkänen";
      email = "mikko.pitkanen.code@pm.me";
    };
    includes = lib.mkIf work [
      { path = osConfig.sops.templates.secret-gitconfig.path; }
    ];
  };
}

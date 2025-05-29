# Configure Git.
#
# This module can be imported by user "mp" config.
{ ... }:
{
  programs.git = {
    enable = true;
    userName = "Mikko Pitkänen";
    userEmail = "mikko.pitkanen.code@pm.me";
    signing.signByDefault = true;
    extraConfig = {
      core.pager = "less -x2";
      init.defaultBranch = "master";
    };
  };
}

# Configure Git.
#
# This module can be imported by user "wsl" config.
{ ... }:
{
  programs.git = {
    enable = true;
    userName = "Mikko Pitkänen";
    userEmail = "change.me@work";
    extraConfig = {
      core.pager = "less -x2";
    };
  };
}

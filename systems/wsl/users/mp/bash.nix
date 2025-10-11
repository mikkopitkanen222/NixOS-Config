{ lib, ... }:
let
  basefile = ../../../desknix/users/mp/bash.nix;
in
{
  imports = [ basefile ];

  home-manager.users.mp.programs = {
    bash.shellAliases = lib.mkForce (
      let
        bash = import basefile { };
        aliases = bash.home-manager.users.mp.programs.bash.shellAliases;
      in
      lib.removeAttrs aliases [ "code" ]
    );

    powerline-go.settings.mode = "flat";
  };
}

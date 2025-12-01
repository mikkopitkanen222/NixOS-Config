{ lib, stdenvNoCC }:
stdenvNoCC.mkDerivation {
  name = "initial-install";
  src = lib.fileset.toSource {
    root = ../..;
    fileset = lib.fileset.unions [
      ./configuration.nix
      ./first-boot.sh
      ./install.sh
      ../../systems/lapnix/disko.nix
      ../../systems/lapnix/hardware-configuration.nix
    ];
  };
  installPhase = ''
    mkdir -p $out/bin
    cp packages/initial-install/*.sh $out/bin

    mkdir -p $out/share
    cp packages/initial-install/configuration.nix $out/share
    cp -r systems/*/ $out/share
  '';
}

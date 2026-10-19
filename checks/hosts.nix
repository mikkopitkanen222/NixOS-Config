{ pkgs, self }:
let
  inherit (pkgs) lib;

  stubSecrets = name: {
    sops = {
      defaultSopsFile = "/dummy/${name}.yaml";
      validateSopsFiles = false;
      age.keyFile = "/dummy/key";
    };
  };
in
lib.pipe self.lib.hostNames [
  (map (
    name:
    let
      host = self.lib.mkHost name [ (stubSecrets name) ];
      # Evaluate the whole system, but don't depend on building it.
      drvPath = builtins.unsafeDiscardStringContext host.config.system.build.toplevel.drvPath;
    in
    lib.nameValuePair "eval-${name}" (pkgs.writeText "eval-${name}" drvPath)
  ))
  lib.listToAttrs
]

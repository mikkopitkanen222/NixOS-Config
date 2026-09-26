{ inputs, ... }: final: _prev: {
  unstable = import inputs.nixpkgs-unstable {
    inherit (final) config;
    localSystem = final.stdenv.hostPlatform;
  };
}

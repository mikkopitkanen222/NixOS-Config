{ ... }: {
  projectRootFile = "flake.nix";
  programs = {
    nixfmt = {
      enable = true;
      strict = true;
      width = 80;
    };
    deadnix = {
      enable = true;
      no-underscore = true;
    };
    statix = {
      enable = true;
      disabled-lints = [ "repeated_keys" ];
    };
  };
}

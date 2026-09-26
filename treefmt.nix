{
  projectRootFile = "flake.nix";
  programs = {
    nixfmt = {
      enable = true;
      strict = true;
      width = 80;
    };
    deadnix = {
      enable = false;
      no-underscore = true;
    };
    statix = {
      enable = false;
      disabled-lints = [ "repeated_keys" ];
    };
  };
}

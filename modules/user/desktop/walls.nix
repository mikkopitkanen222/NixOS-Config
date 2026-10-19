{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.mp222.walls;

  wallModule = lib.types.submodule (wall: {
    options = {
      url = lib.mkOption {
        type = lib.types.str;
        description = "The wallpaper's URL.";
      };

      hash = lib.mkOption {
        type = lib.types.str;
        description = "The wallpaper's hash.";
      };

      outDir = lib.mkOption {
        type = lib.types.str;
        default = "walls";
        description = ''
          Directory where the downloaded wallpaper is linked to.
          This is relative to the user's XDG pictures directory.
        '';
      };

      path = lib.mkOption {
        readOnly = true;
        type = lib.types.str;
        description = "The wallpaper's path in store.";
      };
    };

    config.path = "${pkgs.fetchurl {
      inherit (wall.config) url hash;
      # wallpapercave returns error 403 when no user agent is set.
      curlOpts = "--user-agent 'Chrome/137.0.0.0'";
    }}";
  });

  picturesDir = lib.removePrefix "${config.home.homeDirectory}/" config.xdg.userDirs.pictures;
in
{
  options.mp222.walls = {
    enable = lib.mkEnableOption "the wallpaper collection and links";

    wallpapers = lib.mkOption {
      type = lib.types.attrsOf wallModule;
      default = { };
      description = "Wallpapers to download, by file name.";
    };
  };

  config = lib.mkIf cfg.enable {
    # In Nix, individual wallpapers can be referred to just fine by reading the
    # wall.path option, no linking required (e.g. kitty background). Wallpapers
    # only really need to be linked when a program wants to read all wallpapers
    # in a directory, e.g. DMS's wallpaper rotation. In any case, all wallpapers
    # are linked to pictures, so they're easily accessible.
    home.file = lib.mapAttrs' (
      name: wall:
      lib.nameValuePair (lib.pipe
        [ picturesDir wall.outDir name ]
        [
          (lib.filter (s: s != "" && s != "."))
          (lib.concatStringsSep "/")
        ]
      ) { source = wall.path; }
    ) cfg.wallpapers;

    mp222.walls.wallpapers = {
      "space-blue1.jpg" = {
        url = "https://wallpapercave.com/download/3440x1440-space-wallpapers-wp11599666";
        hash = "sha256-j/y5Dfghb8iC+d0KjH+hYGlfiM6foxo3Xmt3KlkJkbU=";
      };
      "space-blue2.jpg" = {
        url = "https://wallpapercave.com/download/minimalist-3440x1440-wallpapers-wp11362040";
        hash = "sha256-A5PPCf6aC21oLrslEUBauUtby7Iy0mlEbTS1iAlEfXk=";
      };
      "space-dark-green.jpg" = {
        url = "https://wallpapercave.com/download/uwqhd-wallpapers-wp10032966";
        hash = "sha256-38ffAwl/o52ctw6j43wnSpzIWSO0wMLtyi4yj3isqOc=";
      };
      "neon-green.jpg" = {
        url = "https://wallpapercave.com/download/3440x1440-crystalline-wallpapers-wp11147536";
        hash = "sha256-AnITQpwfjXmxIzVvkwJT4VQ5JvZ8kUUYGkmrM1JU1nI=";
      };
      "neon-pink.jpg" = {
        url = "https://wallpapercave.com/download/neon-nature-wallpapers-wp9364811";
        hash = "sha256-H2DXRrVzIbMpwT+yFxZI1Khfw7b0WAGzHV2YHG87Q/w=";
      };
      "neon-sun1.jpg" = {
        url = "https://wallpapercave.com/download/summer-3440x1440-wallpapers-wp12399300";
        hash = "sha256-b39HcP7PuqBZAYNNSeK1GJPSwcLZBeD7q0jq33pCU7s=";
      };
      "neon-sun2.jpg" = {
        url = "https://wallpapercave.com/download/3440x1440-aesthetic-wallpapers-wp8793934";
        hash = "sha256-vEy5yr7kVVi7oCvHhudLdXXXNmseUPSXh2gCQ13wgVI=";
      };
      "neon-city.jpg" = {
        url = "https://wallpapercave.com/download/cyberpunk-4k-for-pc-wallpapers-wp10620150";
        hash = "sha256-Zve6cqwC7chiwHU1uZzNgqV7rwHkWN1MRoSOqHKmdUE=";
      };
      "neon-landscape.jpg" = {
        url = "https://wallpapercave.com/download/3440x1440-wallpapers-wp14821517";
        hash = "sha256-ENCdBBiW7Tnh+ezK46aAT+LgECowtFsQisfmJgFNt5E=";
      };
      "cartoon-sun.jpg" = {
        url = "https://wallpapercave.com/download/red-ultrawide-wallpapers-wp14815408";
        hash = "sha256-tnKIqjkm3rb1aXBFd4o7afOzFB15LM4/wePcT/Brfmk=";
      };
      "cartoon-saturn.jpg" = {
        url = "https://wallpapercave.com/download/3440x1440-purple-wallpapers-wp15674980";
        hash = "sha256-CZezp0tbarIqpCwNbuBpiG9ZV85cSNiU9MJuuhWguW4=";
      };
      "cartoon-night.jpg" = {
        url = "https://wallpapercave.com/download/3440x1440-dark-wallpapers-wp13535618";
        hash = "sha256-k+R7AIS1wA7DtiJRxPmUX0FFtER+I8nUL3JhavKdRMk=";
      };
      "cartoon-mountains.jpg" = {
        url = "https://wallpapercave.com/download/3440x1440-dark-wallpapers-wp12927901";
        hash = "sha256-yaTqfuO+fz7zRXXVXMlzZh48h7PIX1JpUi8fJnIGO6A=";
      };
      "cartoon-forest.jpg" = {
        url = "https://wallpapercave.com/download/3440x1440-crystalline-wallpapers-wp12690888";
        hash = "sha256-QvN0u/7Ez1jVNHZSNojNoYgW4E7cuOLBQibbpLC1NMQ=";
      };
      "forest.jpg" = {
        url = "https://wallpapercave.com/download/dark-winter-3440x1440-wallpapers-wp13568704";
        hash = "sha256-ll+oo+Tv6gaXwn3HPj9wkEehm1iCaCTySsr+7kPzgiU=";
      };
      "lake.jpg" = {
        url = "https://wallpapercave.com/download/3440x1440-summer-sunset-wallpapers-wp15449570";
        hash = "sha256-Tpv15xiiH1Eq7pbBhK9JsgBBc3nvWOKui7L2uQ1kpSQ=";
      };
      "landscape1.jpg" = {
        url = "https://wallpapercave.com/download/bavarian-forest-national-park-wallpapers-wp5074032";
        hash = "sha256-GPzNt9+pWoW5ZrhMbzTUmaYxfD5/iJ4BsYnzfH8oBNM=";
      };
      "landscape2.jpg" = {
        url = "https://wallpapercave.com/download/spring-3440x1440-wallpapers-wp8822111";
        hash = "sha256-cLmK36bqC6YEycuZnOJ5F5uIYZfVO6KZf8ZKLIsG6Es=";
      };
      "landscape3.jpg" = {
        url = "https://wallpapercave.com/download/3440x1440-nature-wallpapers-wp13654853";
        hash = "sha256-2Ap+hALObhzLLbbJ+7QwvVJcAHjySzPvJVf/5uaFzPo=";
      };
    };
  };
}

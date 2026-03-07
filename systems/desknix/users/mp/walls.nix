{
  config,
  lib,
  pkgs,
  ...
}:
{
  home-manager.users.mp = {
    home.file =
      let
        userCfg = config.home-manager.users.mp;
        wallsDirAbs = "${userCfg.xdg.userDirs.pictures}/walls";
        wallsDirRel = lib.removePrefix "${userCfg.home.homeDirectory}/" wallsDirAbs;

        fetchWallpaper = name: url: hash: {
          "${wallsDirRel}/${name}".source = pkgs.fetchurl {
            inherit url hash;
            # The requested URL returns error 403 when no user agent is set:
            curlOpts = "--user-agent 'Chrome/137.0.0.0'";
          };
        };
      in
      lib.mkMerge [
        (fetchWallpaper "space-blue1.jpg"
          "https://wallpapercave.com/download/3440x1440-space-wallpapers-wp11599666"
          "sha256-j/y5Dfghb8iC+d0KjH+hYGlfiM6foxo3Xmt3KlkJkbU="
        )
        (fetchWallpaper "space-blue2.jpg"
          "https://wallpapercave.com/download/minimalist-3440x1440-wallpapers-wp11362040"
          "sha256-A5PPCf6aC21oLrslEUBauUtby7Iy0mlEbTS1iAlEfXk="
        )
        (fetchWallpaper "space-dark-green.jpg"
          "https://wallpapercave.com/download/uwqhd-wallpapers-wp10032966"
          "sha256-38ffAwl/o52ctw6j43wnSpzIWSO0wMLtyi4yj3isqOc="
        )
        (fetchWallpaper "neon-green.jpg"
          "https://wallpapercave.com/download/3440x1440-crystalline-wallpapers-wp11147536"
          "sha256-AnITQpwfjXmxIzVvkwJT4VQ5JvZ8kUUYGkmrM1JU1nI="
        )
        (fetchWallpaper "neon-pink.jpg"
          "https://wallpapercave.com/download/neon-nature-wallpapers-wp9364811"
          "sha256-H2DXRrVzIbMpwT+yFxZI1Khfw7b0WAGzHV2YHG87Q/w="
        )
        (fetchWallpaper "neon-sun1.jpg"
          "https://wallpapercave.com/download/summer-3440x1440-wallpapers-wp12399300"
          "sha256-b39HcP7PuqBZAYNNSeK1GJPSwcLZBeD7q0jq33pCU7s="
        )
        (fetchWallpaper "neon-sun2.jpg"
          "https://wallpapercave.com/download/3440x1440-aesthetic-wallpapers-wp8793934"
          "sha256-vEy5yr7kVVi7oCvHhudLdXXXNmseUPSXh2gCQ13wgVI="
        )
        (fetchWallpaper "neon-city.jpg"
          "https://wallpapercave.com/download/cyberpunk-4k-for-pc-wallpapers-wp10620150"
          "sha256-Zve6cqwC7chiwHU1uZzNgqV7rwHkWN1MRoSOqHKmdUE="
        )
        (fetchWallpaper "neon-landscape.jpg"
          "https://wallpapercave.com/download/3440x1440-wallpapers-wp14821517"
          "sha256-ENCdBBiW7Tnh+ezK46aAT+LgECowtFsQisfmJgFNt5E="
        )
        (fetchWallpaper "cartoon-sun.jpg"
          "https://wallpapercave.com/download/red-ultrawide-wallpapers-wp14815408"
          "sha256-tnKIqjkm3rb1aXBFd4o7afOzFB15LM4/wePcT/Brfmk="
        )
        (fetchWallpaper "cartoon-saturn.jpg"
          "https://wallpapercave.com/download/3440x1440-purple-wallpapers-wp15674980"
          "sha256-CZezp0tbarIqpCwNbuBpiG9ZV85cSNiU9MJuuhWguW4="
        )
        (fetchWallpaper "cartoon-night.jpg"
          "https://wallpapercave.com/download/3440x1440-dark-wallpapers-wp13535618"
          "sha256-k+R7AIS1wA7DtiJRxPmUX0FFtER+I8nUL3JhavKdRMk="
        )
        (fetchWallpaper "cartoon-mountains.jpg"
          "https://wallpapercave.com/download/3440x1440-dark-wallpapers-wp12927901"
          "sha256-yaTqfuO+fz7zRXXVXMlzZh48h7PIX1JpUi8fJnIGO6A="
        )
        (fetchWallpaper "cartoon-forest.jpg"
          "https://wallpapercave.com/download/3440x1440-crystalline-wallpapers-wp12690888"
          "sha256-QvN0u/7Ez1jVNHZSNojNoYgW4E7cuOLBQibbpLC1NMQ="
        )
        (fetchWallpaper "forest.jpg"
          "https://wallpapercave.com/download/dark-winter-3440x1440-wallpapers-wp13568704"
          "sha256-ll+oo+Tv6gaXwn3HPj9wkEehm1iCaCTySsr+7kPzgiU="
        )
        (fetchWallpaper "lake.jpg"
          "https://wallpapercave.com/download/3440x1440-summer-sunset-wallpapers-wp15449570"
          "sha256-Tpv15xiiH1Eq7pbBhK9JsgBBc3nvWOKui7L2uQ1kpSQ="
        )
        (fetchWallpaper "landscape1.jpg"
          "https://wallpapercave.com/download/bavarian-forest-national-park-wallpapers-wp5074032"
          "sha256-GPzNt9+pWoW5ZrhMbzTUmaYxfD5/iJ4BsYnzfH8oBNM="
        )
        (fetchWallpaper "landscape2.jpg"
          "https://wallpapercave.com/download/spring-3440x1440-wallpapers-wp8822111"
          "sha256-cLmK36bqC6YEycuZnOJ5F5uIYZfVO6KZf8ZKLIsG6Es="
        )
        (fetchWallpaper "landscape3.jpg"
          "https://wallpapercave.com/download/3440x1440-nature-wallpapers-wp13654853"
          "sha256-2Ap+hALObhzLLbbJ+7QwvVJcAHjySzPvJVf/5uaFzPo="
        )
      ];
  };
}

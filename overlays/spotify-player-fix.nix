# nixos-config/overlays/spotify-player-fix.nix
# Workaround for https://github.com/aome510/spotify-player/issues/802.
{ ... }:
final: prev: {
  spotify-player =
    let
      # This file itself is the 01.default.nix from szaffarano's gist below.
      # It is copied here because the filenames are wrong in the original ("03. 1532.patch" & "02. Cargo.lock.patch").
      fix = prev.fetchzip {
        url = "https://gist.github.com/szaffarano/18c148eaa1495dfc010f89344fdf2857/archive/3a5bce9e155277c02b63e0faa1af0bf943d12cfb.zip";
        hash = "sha256-FmGyzgk4R1Z645LMeCqMi1Z3p/10z/PC61KAUVHn2nM=";
      };

      spotifyPlayerSrc = prev.fetchFromGitHub {
        owner = "aome510";
        repo = "spotify-player";
        rev = "b92c7379b192e6492ec37b722ecb9934e6803c2f";
        hash = "sha256-cWJAj0n3Q8WC5U0PvDMeDQ6yjxYtvoF5N9LJPJJnixo=";
      };
      librespotSrc = prev.stdenv.mkDerivation {
        name = "librespot-patched-src";
        src = prev.fetchFromGitHub {
          owner = "librespot-org";
          repo = "librespot";
          rev = "9456a02afa3ba1c96470d532ebc6e9b858824a3c";
          hash = "sha256-VlTqRfBL1zFc6YePHGpM4Y+HJX9Sp1A1jBKnUzwZfys=";
        };

        installPhase = ''
          cp -r . $out
        '';
      };

      spotifyPlayerPatchedSrc = prev.runCommand "spotify-player-patched-src" { } ''
        cp -r ${spotifyPlayerSrc} $out
        chmod -R +w $out

        cd $out
        patch -p1 < ${prev.writeText "use-local-librespot.patch" ''
          diff --git a/spotify_player/Cargo.toml b/spotify_player/Cargo.toml
          index a5c812d..8c8532d 100644
          --- a/spotify_player/Cargo.toml
          +++ b/spotify_player/Cargo.toml
          @@ -15,11 +15,11 @@ clap = { version = "4.5.41", features = ["derive", "string"] }
           config_parser2 = "0.1.6"
           crossterm = "0.29.0"
           dirs-next = "2.0.0"
          -librespot-connect = { version = "0.6.0", optional = true }
          -librespot-core = "0.6.0"
          -librespot-oauth = "0.6.0"
          -librespot-playback = { version = "0.6.0", optional = true }
          -librespot-metadata = "0.6.0"
          +librespot-connect = { path = "${librespotSrc}/connect", optional = true }
          +librespot-core = { path = "${librespotSrc}/core" }
          +librespot-oauth = { path = "${librespotSrc}/oauth" }
          +librespot-playback = { path = "${librespotSrc}/playback", optional = true }
          +librespot-metadata = { path = "${librespotSrc}/metadata" }
           log = "0.4.27"
           chrono = "0.4.41"
           reqwest = { version = "0.12.22", features = ["json"] }
        ''}
        patch -p1 < ${fix}/03.\ 1532.patch
        patch -p1 < ${fix}/02.\ Cargo.lock.patch
      '';
    in
    prev.spotify-player.overrideAttrs (_: rec {
      pname = "spotify-player";
      version = "0.21.0-dev";
      src = spotifyPlayerPatchedSrc;
      cargoDeps = final.rustPlatform.fetchCargoVendor {
        inherit src;
        hash = "sha256-Io7dU3tkEAQR0Uphiulc/BbWibjXtDp4AyAJiwM3/Lw=";
      };
    });
}

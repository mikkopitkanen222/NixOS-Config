# https://github.com/aome510/spotify-player
{ ... }:
{
  home-manager.users.mp = {
    programs.spotify-player = {
      enable = true;
      settings = {
        theme = "theme";
        device = {
          volume = 100;
          audio_cache = true;
          autoplay = true;
        };
      };
      themes = [
        {
          name = "theme";
          component_style = {
            block_title = {
              fg = "Magenta";
            };
            border = { };
            playback_status = {
              fg = "Green";
            };
            playback_track = {
              fg = "Cyan";
              modifiers = [ "Bold" ];
            };
            playback_artists = {
              fg = "Cyan";
            };
            playback_album = {
              fg = "Yellow";
            };
            playback_metadata = {
              fg = "BrightBlack";
            };
            playback_progress_bar = {
              fg = "Green";
              bg = "Black";
            };
            current_playing = {
              fg = "Green";
            };
            page_desc = {
              fg = "Cyan";
              modifiers = [ "Bold" ];
            };
            table_header = {
              fg = "Blue";
            };
            selection = {
              modifiers = [
                "Bold"
                "Reversed"
              ];
            };
            like = {
              fg = "Red";
            };
          };
        }
      ];
    };
  };
}

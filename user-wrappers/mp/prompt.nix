# https://github.com/starship/starship
{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.mp222.starship;

  tomlFormat = pkgs.formats.toml { };

  defaultStarshipConfig = {
    format = ''
      ([\[](fg:8) $container$nix_shell$env_var[\]](fg:8)
      )([\[](fg:8) $direnv$git_branch$git_commit$git_state$git_status$git_metrics[\]](fg:8)
      )([\[](fg:8) ($username$hostname )$sudo$jobs$status$cmd_duration[\]](fg:8)
      )$directory
      $shlvl$character
    '';
    cmd_duration = {
      min_time = 10000;
    };
    directory = {
      truncation_length = 0;
      truncate_to_repo = false;
      format = "([$read_only]($read_only_style) )[󰉋 $path]($style)";
    };
    direnv = {
      format = "($loaded )";
      disabled = false;
      loaded_msg = "📖";
      unloaded_msg = "📕";
    };
    git_branch = {
      format = "[$symbol$branch]($style) ";
      symbol = " ";
      only_attached = true;
    };
    git_commit = {
      format = "[($tag )$hash]($style) ";
      style = "bold purple";
      tag_disabled = false;
      tag_symbol = "🏷";
    };
    git_metrics = {
      format = "([+$added]($added_style) )([-$deleted]($deleted_style) )";
      disabled = false;
    };
    git_state = {
      rebase = "⤵️";
      merge = "⤴️";
      revert = "↩️";
      cherry_pick = "🍒";
      bisect = "✂️";
      am = "📫";
      am_or_rebase = "📫/⤵️";
      format = "\\([$state( $progress_current/$progress_total)]($style)\\) ";
    };
    git_status = {
      format = "([$stashed$ahead_behind$conflicted$untracked$staged$renamed$modified$deleted]($style))";
      conflicted = "🔀$count ";
      ahead = "📤$count ";
      behind = "📥$count ";
      diverged = "📤$ahead_count📥$behind_count ";
      untracked = "❔$count ";
      stashed = "💾$count ";
      modified = "📝$count ";
      staged = "👀$count ";
      renamed = "✏️$count ";
      deleted = "❌$count ";
      style = "bold cyan";
    };
    hostname = {
      format = "@[$hostname]($style)";
    };
    jobs = {
      symbol = "🔨";
    };
    nix_shell = {
      format = "[$symbol$state]($style) ";
      symbol = "❄️ ";
    };
    shlvl = {
      format = "[$symbol]($style)";
      symbol = "❯";
      repeat = true;
      repeat_offset = 1;
      disabled = false;
    };
    status = {
      format = "[($symbol $status(:$common_meaning) )]($style)";
      disabled = false;
    };
    sudo = {
      format = "[$symbol]($style)";
      symbol = "👨‍💻 ";
      disabled = false;
    };
    username = {
      format = "[$user]($style)";
    };
  };
in
{
  options.mp222.starship = {
    enable = lib.mkEnableOption "the Starship prompt";

    package = lib.mkPackageOption pkgs "starship" { };

    settings = lib.mkOption {
      type = tomlFormat.type;
      default = defaultStarshipConfig;
      description = "Configuration written to Starship's config file.";
    };
  };

  config = lib.mkIf cfg.enable {
    wrappers.starship = {
      basePackage = cfg.package;
      env.STARSHIP_CONFIG.value = tomlFormat.generate "mp-starship-config" cfg.settings;
    };
  };
}

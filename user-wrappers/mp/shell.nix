# https://github.com/zsh-users/zsh
{
  systemConfig,
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.mp222.zsh;

  # Taken from [1]
  zshAliases = builtins.concatStringsSep "\n" (
    lib.mapAttrsToList (k: v: "alias -- ${k}=${lib.escapeShellArg v}") (
      lib.filterAttrs (k: v: v != null) cfg.shellAliases
    )
  );

  zshenv = pkgs.writeTextFile {
    name = "mp-zshenv";
    text = ''
      # The global zsh init files are written to /etc when zsh is installed on
      # the system level.  We install zsh only on the user level, so we don't
      # read anything from /etc.  All system level configuration normally found
      # in /etc/zshenv is combined with user level configuration in this file
      # ($ZDOTDIR/.zshenv).

      setopt no_global_rcs

      # Only execute this file once per shell.
      if [ -n "''${__ZDOTDIR_ZSHENV_SOURCED-}" ]; then return; fi
      __ZDOTDIR_ZSHENV_SOURCED=1

      # Source system level variables from NixOS modules.
      if [ -z "''${__NIXOS_SET_ENVIRONMENT_DONE-}" ]; then
        . ${systemConfig.system.build.setEnvironment}
      fi

      # TODO: Get rid of HM.
      #       Does zsh wrapper need an option for variables for use in other wrappers? Or is wrappers.xxx.env enough?
      # Source user level variables from Home-Manager modules.
      . "${systemConfig.home-manager.users.mp.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh"

      # Setup custom system level global shell init stuff.
      ${systemConfig.environment.shellInit}

      # Setup custom user level global shell init stuff.
      ${cfg.shellInit}
    '';
  };

  zprofile = pkgs.writeTextFile {
    name = "mp-zprofile";
    text = ''
      # The global zsh init files are written to /etc when zsh is installed on
      # the system level.  We install zsh only on the user level, so we don't
      # read anything from /etc.  All system level configuration normally found
      # in /etc/zprofile is combined with user level configuration in this file
      # ($ZDOTDIR/.zprofile).

      # Only execute this file once per shell.
      if [ -n "''${__ZDOTDIR_ZPROFILE_SOURCED-}" ]; then return; fi
      __ZDOTDIR_ZPROFILE_SOURCED=1

      # Setup custom system level login shell init stuff.
      ${systemConfig.environment.loginShellInit}

      # Setup custom user level login shell init stuff.
      ${cfg.loginShellInit}
    '';
  };

  zshrc = pkgs.writeTextFile {
    name = "mp-zshrc";
    text = ''
      # The global zsh init files are written to /etc when zsh is installed on
      # the system level.  We install zsh only on the user level, so we don't
      # read anything from /etc.  All system level configuration normally found
      # in /etc/zshrc is combined with user level configuration in this file
      # ($ZDOTDIR/.zshrc).

      # Only execute this file once per shell.
      if [ -n "''${__ZDOTDIR_ZSHRC_SOURCED-}" ]; then return; fi
      __ZDOTDIR_ZSHRC_SOURCED=1

      typeset -U path cdpath fpath manpath

      # Tell zsh how to find installed completions.
      for profile in ''${(z)NIX_PROFILES}; do
        fpath+=($profile/share/zsh/site-functions $profile/share/zsh/$ZSH_VERSION/functions $profile/share/zsh/vendor-completions)
      done
      fpath=(${pkgs.nix-zsh-completions}/share/zsh/site-functions $fpath)

      HELPDIR="${cfg.package}/share/zsh/$ZSH_VERSION/help"

      # Alternative method of determining short and full hostname.
      HOST=${systemConfig.networking.fqdnOrHostName}

      # Configure sane keyboard defaults.
      bindkey -e
      # create a zkbd compatible hash;
      # to add other keys to this hash, see: man 5 terminfo
      typeset -A key
      key[Home]=''${terminfo[khome]}
      key[End]=''${terminfo[kend]}
      key[Delete]=''${terminfo[kdch1]}
      key[Up]=''${terminfo[kcuu1]}
      key[Down]=''${terminfo[kcud1]}
      key[Left]=''${terminfo[kcub1]}
      key[Right]=''${terminfo[kcuf1]}
      key[PageUp]=''${terminfo[kpp]}
      key[PageDown]=''${terminfo[knp]}
      key[CtrlLeft]="^[[1;5D"
      key[CtrlRight]="^[[1;5C"

      # setup key accordingly
      [[ -n "''${key[Home]}"      ]] && bindkey "''${key[Home]}"      beginning-of-line
      [[ -n "''${key[End]}"       ]] && bindkey "''${key[End]}"       end-of-line
      [[ -n "''${key[Delete]}"    ]] && bindkey "''${key[Delete]}"    delete-char
      [[ -n "''${key[Up]}"        ]] && bindkey "''${key[Up]}"        up-line-or-history
      [[ -n "''${key[Down]}"      ]] && bindkey "''${key[Down]}"      down-line-or-history
      [[ -n "''${key[Left]}"      ]] && bindkey "''${key[Left]}"      backward-char
      [[ -n "''${key[Right]}"     ]] && bindkey "''${key[Right]}"     forward-char
      [[ -n "''${key[PageUp]}"    ]] && bindkey "''${key[PageUp]}"    beginning-of-buffer-or-history
      [[ -n "''${key[PageDown]}"  ]] && bindkey "''${key[PageDown]}"  end-of-buffer-or-history
      [[ -n "''${key[CtrlLeft]}"  ]] && bindkey "''${key[CtrlLeft]}"  backward-word
      [[ -n "''${key[CtrlRight]}" ]] && bindkey "''${key[CtrlRight]}" forward-word

      # Finally, make sure the terminal is in application mode, when zle is
      # active. Only then are the values from $terminfo valid.
      if (( ''${+terminfo[smkx]} )) && (( ''${+terminfo[rmkx]} )); then
        function zle-line-init () {
          printf '%s' "''${terminfo[smkx]}"
        }
        function zle-line-finish () {
          printf '%s' "''${terminfo[rmkx]}"
        }
        zle -N zle-line-init
        zle -N zle-line-finish
      fi

      # Enable autocompletion.
      autoload -U compinit && compinit
      zstyle ':completion:*' completer _complete _ignored _match _approximate
      zstyle ':completion:*' completions 1
      zstyle ':completion:*' glob 1
      zstyle ':completion:*' ignore-parents parent pwd
      zstyle ':completion:*' insert-unambiguous true
      zstyle ':completion:*' list-colors ${"''"}
      zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
      zstyle ':completion:*' list-suffixes true
      zstyle ':completion:*' matcher-list ${"''"} 'm:{[:lower:]}={[:upper:]}' 'r:|[._-]=** r:|=**' 'l:|=* r:|=*'
      zstyle ':completion:*' match-original both
      zstyle ':completion:*' max-errors 3
      zstyle ':completion:*' menu select=2
      zstyle ':completion:*' original true
      zstyle ':completion:*' preserve-prefix '//[^/]##/'
      zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
      zstyle ':completion:*' squeeze-slashes true
      zstyle ':completion:*' substitute 1
      zstyle ':completion:*' verbose true

      # Enable compatibility with bash's completion system.
      autoload -U bashcompinit && bashcompinit

      # Enable autosuggestions.
      . ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
      export ZSH_AUTOSUGGEST_STRATEGY=(history)
      export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#00ddff,bold"

      # Set zsh options.
      setopt no_auto_cd
      setopt no_beep
      setopt nomatch
      setopt notify

      # Setup command line history.
      setopt append_history
      setopt hist_expire_dups_first
      setopt hist_ignore_all_dups
      setopt hist_save_no_dups
      setopt hist_ignore_space
      setopt hist_reduce_blanks
      # Don't export these, otherwise other shells (bash) will try to use same HISTFILE.
      SAVEHIST=10000
      HISTSIZE=10000
      HISTFILE=$HOME/.zsh_history

      # Setup aliases.
      alias -- ..='cd ..'
      alias -- ...='cd ../..'
      ${zshAliases}

      # Enable syntax highlighting.
      . ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
      ZSH_HIGHLIGHT_HIGHLIGHTERS=(main cursor)

      # Extra colors for directory listings.
      eval "$(${pkgs.coreutils}/bin/dircolors -b)"

      # Setup custom system level interactive shell init stuff.
      ${systemConfig.environment.interactiveShellInit}

      # Setup custom user level interactive shell init stuff.
      tabs -2
      ${cfg.interactiveShellInit}
    ''; # [2]
  };

  zdotdir = pkgs.stdenv.mkDerivation {
    name = "mp-zdotdir";
    phases = [ "installPhase" ];
    installPhase = ''
      mkdir -p $out
      cp ${zshenv} $out/.zshenv
      cp ${zprofile} $out/.zprofile
      cp ${zshrc} $out/.zshrc
    '';
  };
in
{
  options.mp222.zsh = {
    enable = lib.mkEnableOption "the zsh shell";

    package = lib.mkPackageOption pkgs "zsh" { };

    # Taken from [1]
    shellAliases = lib.mkOption {
      type = with lib.types; attrsOf (nullOr (either str path));
      default = { };
      description = ''
        Set of aliases for zsh shell, which overrides {option}`environment.shellAliases`.
        See {option}`environment.shellAliases` for an option format description.
      '';
    };

    shellInit = lib.mkOption {
      type = lib.types.lines;
      default = "";
      description = "Extra lines appended to $ZDOTDIR/.zshenv.";
    };

    loginShellInit = lib.mkOption {
      type = lib.types.lines;
      default = "";
      description = "Extra lines appended to $ZDOTDIR/.zprofile.";
    };

    interactiveShellInit = lib.mkOption {
      type = lib.types.lines;
      default = "";
      description = "Extra lines appended to $ZDOTDIR/.zshrc.";
    };
  };

  config = lib.mkIf cfg.enable {
    # Adapted from [1]
    mp222.zsh.shellAliases = builtins.mapAttrs (
      name: lib.mkDefault
    ) systemConfig.environment.shellAliases;

    wrappers.zsh = {
      basePackage = cfg.package;
      extraPackages = with pkgs; [
        coreutils
        nix-zsh-completions
        zsh-autosuggestions
        zsh-syntax-highlighting
      ];
      env.ZDOTDIR.value = zdotdir;
    };
  };
}

# References:
# [1] https://github.com/NixOS/nixpkgs/blob/nixos-unstable/nixos/modules/programs/zsh/zsh.nix
# [2] https://github.com/nix-community/home-manager/blob/master/modules/programs/zsh/default.nix

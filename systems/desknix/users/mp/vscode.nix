{ config, pkgs, ... }:
{
  home-manager.users.mp = {
    programs.vscode = {
      enable = true;
      package = pkgs.vscodium;
      profiles.default = {
        extensions =
          (with pkgs.vscode-extensions; [
            ms-vscode.cmake-tools
            moshfeu.compare-folders
            yzhang.markdown-all-in-one
            yzane.markdown-pdf
            jnoortheen.nix-ide
            tomoki1207.pdf
            jebbs.plantuml
            rust-lang.rust-analyzer
            llvm-vs-code-extensions.vscode-clangd
          ])
          ++ (pkgs.vscode-utils.extensionsFromVscodeMarketplace [
            {
              name = "vscode-hyprls";
              publisher = "ewen-lbh";
              version = "0.4.1";
              sha256 = "sha256-NOEuatXKx5NRd+MfKFiNiwZLhnPuD0Gkes8ni5vF3kM=";
            }
          ]);
        userSettings = {
          "editor.accessibilitySupport" = "off";
          "editor.emptySelectionClipboard" = false;
          "editor.fontFamily" =
            "'Droid Sans Mono', 'monospace', monospace, 'SpaceMono Nerd Font'";
          "editor.guides.bracketPairs" = "active";
          "editor.guides.highlightActiveBracketPair" = false;
          "editor.hover.delay" = 100;
          "editor.hover.sticky" = false;
          "editor.inlayHints.enabled" = "offUnlessPressed";
          "editor.multiCursorModifier" = "ctrlCmd";
          "editor.renderWhitespace" = "all";
          "editor.smoothScrolling" = true;
          "editor.tabSize" = 2;
          "editor.wordWrap" = "on";
          "editor.wrappingIndent" = "none";
          "editor.cursorBlinking" = "smooth";
          "editor.cursorSmoothCaretAnimation" = "on";
          "editor.find.addExtraSpaceOnTop" = false;
          "editor.suggest.matchOnWordStartOnly" = false;
          "files.trimFinalNewlines" = true;
          "files.trimTrailingWhitespace" = true;
          "search.showLineNumbers" = true;
          "terminal.integrated.defaultProfile.linux" = "zsh";
          "terminal.integrated.suggest.enabled" = true;
          "workbench.startupEditor" = "newUntitledFile";
          "workbench.tips.enabled" = false;
          "workbench.tree.indent" = 12;
          "workbench.tree.renderIndentGuides" = "always";
          "workbench.editor.empty.hint" = "hidden";
          "window.commandCenter" = false;
          "explorer.incrementalNaming" = "smart";
          "extensions.ignoreRecommendations" = true;
          "chat.agent.enabled" = false;
          "telemetry.feedback.enabled" = false;
          "security.workspace.trust.banner" = "never";
          "security.workspace.trust.startupPrompt" = "never";
          "security.workspace.trust.untrustedFiles" = "open";
          "git.openRepositoryInParentFolders" = "never";
          "nix.enableLanguageServer" = true;
          "nix.serverPath" = "nixd";
          "nix.serverSettings" = {
            "nixd" = {
              "nixpkgs" = {
                "expr" =
                  "import (builtins.getFlake (builtins.toString ./.)).inputs.nixpkgs { }";
              };
              "options" = {
                "nixos" = {
                  "expr" =
                    "(builtins.getFlake (builtins.toString ./.)).nixosConfigurations.${config.networking.hostName}.options";
                };
                "home-manager" = {
                  "expr" =
                    "(builtins.getFlake (builtins.toString ./.)).nixosConfigurations.${config.networking.hostName}.options.home-manager.users.type.getSubOptions []";
                };
              };
            };
          };
          "[cpp]" = {
            "editor.detectIndentation" = false;
            "editor.insertSpaces" = false;
            "editor.tabSize" = 2;
          };
        };
      };
    };

    home.shellAliases = {
      "code" = "codium";
    };
  };
}

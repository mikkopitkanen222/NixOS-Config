{
  config,
  lib,
  pkgs,
  ...
}:
{
  home-manager.users.mp = {
    programs.vscodium = {
      enable = true;
      profiles = {
        # Profile "default" is never used. The following configuration options
        # just can not be configured in actual "$user" profiles:
        "default" = {
          enableExtensionUpdateCheck = false;
          enableUpdateCheck = false;
          userSettings = {
            "security.workspace.trust.banner" = "never";
            "security.workspace.trust.startupPrompt" = "never";
            "security.workspace.trust.untrustedFiles" = "open";
            "window.newWindowProfile" = "mp";
          };
        };
        "mp" = lib.mkMerge [
          {
            extensions = pkgs.vscode-utils.extensionsFromVscodeMarketplace [
              {
                name = "lambda-black";
                publisher = "janw4ld";
                version = "0.2.20";
                sha256 = "sha256-P1/wZ0EEBHcF99KV2wZi+6ITjK5nhb+VK71s86dawK0=";
              }
            ];
            userSettings = {
              "workbench.colorTheme" = "Lambda Black";
              "workbench.colorCustomizations" = {
                "[Lambda Black]" =
                  let
                    almostBlack = "#050403";
                    lightBlack = "#0d0e0f";
                    brightBlack = "#1a1c1b";
                  in
                  {
                    "editor.background" = almostBlack;
                    "activityBar.background" = almostBlack;
                    "editorGroupHeader.tabsBackground" = almostBlack;
                    "editorGutter.background" = almostBlack;
                    "panel.background" = almostBlack;
                    "sideBar.background" = almostBlack;
                    "sideBarSectionHeader.background" = almostBlack;
                    "statusBar.background" = almostBlack;
                    "titleBar.inactiveBackground" = almostBlack;
                    "titleBar.activeBackground" = almostBlack;

                    # My Hyprland window border colors:
                    "activityBar.inactiveForeground" = "#541680";
                    "activityBar.activeBorder" = "#d0a028";
                    "activityBar.foreground" = "#d0a028";

                    "list.inactiveSelectionBackground" = lightBlack;
                    "list.activeSelectionBackground" = brightBlack;
                    "list.hoverBackground" = brightBlack;

                    "menu.background" = lightBlack;
                    "menu.selectionBackground" = brightBlack;
                    "menu.border" = brightBlack;

                    "tab.inactiveBackground" = lightBlack;
                    "tab.activeBackground" = brightBlack;
                    "tab.hoverBackground" = brightBlack;
                    "tab.border" = brightBlack;
                  };
              };
              "editor.tokenColorCustomizations" = {
                "[Lambda Black]" = {
                  # I don't understand why so many color themes color comments
                  # gray... It's hard to read, and the color gray should be
                  # reserved for disabled code only.
                  "comments" = "#4d8834";
                };
              };
            };
          }
          {
            extensions =
              (with pkgs.vscode-extensions; [
                ms-vscode.cmake-tools
                moshfeu.compare-folders
                llvm-vs-code-extensions.lldb-dap
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
              "diffEditor.ignoreTrimWhitespace" = false;
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
          }
        ];
      };
    };

    home.shellAliases = {
      "code" = "codium";
    };
  };
}

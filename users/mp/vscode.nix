# Configure VSCode.
#
# This module can be imported by user "mp" config.
{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        jnoortheen.nix-ide
        ms-vscode.cmake-tools
        llvm-vs-code-extensions.vscode-clangd
        wakatime.vscode-wakatime
      ];
      userSettings = builtins.fromJSON (builtins.readFile ./vscode-settings.json);
    };
  };
}

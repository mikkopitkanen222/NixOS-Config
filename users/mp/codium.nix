# User specific code editor config.
{ pkgs, ... }:
{
  home-manager.users.mp = {
    programs.vscode = {
      enable = true;
      package = pkgs.vscodium;
      extensions = with pkgs.vscode-extensions; [
        jnoortheen.nix-ide
        twxs.cmake
        ms-vscode.cmake-tools
        llvm-vs-code-extensions.vscode-clangd
      ];
    };

    home.packages = with pkgs; [
      cmake
      ninja
      clang
      clang-tools
      gdb
    ];
  };
}

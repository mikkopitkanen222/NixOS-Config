# nixos-config/users/desknix-mp/obsidian.nix
# Configure Obsidian for user 'mp' on host 'desknix'.
{ ... }:
{
  home-manager.users.mp = {
    programs.obsidian = {
      enable = true;
      defaultSettings = {
        appearance = {
          theme = "obsidian";
          accentColor = "#d0a028";
          baseFontSize = 16;
          baseFontSizeAction = true;
          showViewHeader = true;
          showRibbon = true;
          nativeMenus = false;
        };
        app = {
          showInlineTitle = true;
          focusNewTab = true;
          defaultViewMode = "source";
          livePreview = false;
          readableLineLength = true;
          strictLineBreaks = true;
          propertiesInDocument = "visible";
          foldHeading = true;
          foldIndent = true;
          showLineNumber = true;
          showIndentGuide = true;
          rightToLeft = false;
          spellcheck = true;
          autoPairBrackets = true;
          autoPairMarkdown = true;
          smartIndentList = true;
          useTab = true;
          tabSize = 2;
          autoConvertHtml = true;
          vimMode = false;
          promptDelete = false;
          trashOption = "local";
          alwaysUpdateLinks = false;
          newFileLocation = "current";
          newLinkFormat = "relative";
          useMarkdownLinks = true;
          showUnsupportedFiles = true;
          attachmentFolderPath = "./";
        };
        corePlugins = [
          "editor-status"
          "backlink"
          "bookmarks"
          "command-palette"
          "file-recovery"
          "file-explorer"
          "note-composer"
          "outgoing-link"
          "outline"
          "page-preview"
          "switcher"
          "global-search"
          "tag-pane"
          "templates"
          "word-count"
        ];
      };
      vaults = {
        Notes = {
          enable = true;
          target = "obsidian-vaults/notes";
        };
        Work = {
          enable = true;
          target = "obsidian-vaults/work";
        };
      };
    };
  };
}

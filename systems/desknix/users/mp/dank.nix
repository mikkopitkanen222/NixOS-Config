{
  inputs,
  lib,
  pkgs,
  ...
}:
let
  # Changing managed settings:
  # 1. Edit settings in Dank Settings app
  # 2. Dump settings to .json and convert to .nix:
  # `dms ipc call settings dump > dank.json && echo -e "dank.json\ndank.nix" | nix run github:sempruijs/json2nix -- -`
  # https://danklinux.com/docs/dankmaterialshell/nixos-flake#settings-home-manager-only
  settings = {
    currentThemeName = "dynamic";
    radiusStrength = 30;
    radiusMode = "fixed";
    fixedRadius = 8;
    clockFormat = "24h";
    showSeconds = true;
    blurBorderEnabled = true;
    blurBorderOpacity = 0.15;
    lockDateFormat = "dddd d. MMMM yyyy";
    fontFamily = "Inter Variable";
    lockScreenShowPowerActions = true;
    lockScreenShowProfileImage = false;
    powerMenuDefaultAction = "suspend";
    powerMenuGridLayout = true;
    dockConfigs = [
      {
        id = "dock";
        name = "Dock";
        enabled = true;
        screenPreferences = [ "all" ];
        showOnLastDisplay = true;
        position = 1;
        mode = "compact";
        taskbarAlign = "center";
        widgetExpansion = "popout";
        iconSize = 40;
        spacing = 5;
        itemSpacing = 4;
        margin = 0;
        bottomGap = 0;
        transparency = 0.8;
        followInterfaceStyle = false;
        autoHide = false;
        smartAutoHide = true;
        useOverlayLayer = false;
        editOnRightClick = true;
        showOnFullscreen = false;
        openOnOverview = false;
        groupByApp = true;
        separatePinnedAndRunningApps = false;
        restoreSpecialWorkspaceOnClick = false;
        isolateDisplays = false;
        indicatorStyle = "circle";
        borderEnabled = true;
        borderColor = "surfaceText";
        borderOpacity = 0.3;
        borderThickness = 1;
        launcherEnabled = true;
        launcherLogoMode = "os";
        launcherLogoCustomPath = "";
        launcherLogoColorOverride = "";
        launcherLogoSizeOffset = 0;
        launcherLogoBrightness = 0.5;
        launcherLogoContrast = 1;
        maxVisibleApps = 10;
        maxVisibleRunningApps = 10;
        showOverflowBadge = true;
        showTrash = false;
        trashFileManager = "default";
        trashCustomCommand = "";
        order = [ ];
        widgets = [
          {
            id = "dock_launcher";
            widgetId = "dockLauncher";
            enabled = true;
          }
          {
            id = "dock_apps";
            widgetId = "appsDock";
            enabled = true;
          }
          {
            id = "dock_trash";
            widgetId = "dockTrash";
            enabled = true;
          }
        ];
      }
    ];
    currentThemeCategory = "dynamic";
    popupTransparency = 0.8;
    widgetBackgroundColor = "s";
    widgetColorMode = "colorful";
    controlCenterTileColorMode = "primaryContainer";
    buttonColorMode = "primaryContainer";
    hyprlandLayoutRadiusOverride = 10;
    firstDayOfWeek = 1;
    showWeekNumber = true;
    calendarBackend = "dankcal";
    windSpeedUnit = "ms";
    m3ElevationLightDirection = "topLeft";
    blurEnabled = true;
    blurBorderSeeded = true;
    blurLayerOutlineOpacity = 0.15;
    controlCenterWidgets = [
      {
        enabled = true;
        id = "volumeSlider";
        w = 4;
        h = 1;
      }
      {
        enabled = true;
        id = "inputVolumeSlider";
        w = 4;
        h = 1;
      }
      {
        enabled = true;
        id = "wifi";
        w = 4;
        h = 1;
      }
      {
        enabled = true;
        id = "bluetooth";
        w = 4;
        h = 1;
      }
      {
        enabled = true;
        id = "audioOutput";
        w = 4;
        h = 1;
      }
      {
        enabled = true;
        id = "audioInput";
        w = 4;
        h = 1;
      }
      {
        enabled = true;
        id = "nightMode";
        w = 2;
        h = 1;
      }
      {
        enabled = true;
        id = "darkMode";
        w = 2;
        h = 1;
      }
      {
        enabled = true;
        id = "idleInhibitor";
        w = 2;
        h = 1;
      }
      {
        enabled = true;
        id = "doNotDisturb";
        w = 2;
        h = 1;
      }
    ];
    appIdSubstitutions = [ ];
    clockDateFormat = "ddd d.M.yyyy";
    appLauncherGridColumns = 6;
    spotlightSectionViewModes = {
      apps = "grid";
      plugin_emojiLauncher = "grid";
    };
    dankLauncherV2BorderThickness = 1;
    dashTabs = [
      {
        id = "overview";
        enabled = true;
      }
      {
        id = "media";
        enabled = true;
      }
      {
        id = "wallpaper";
        enabled = true;
      }
      {
        id = "weather";
        enabled = true;
      }
      {
        id = "notifications";
        enabled = true;
      }
    ];
    dashOptions = {
      clock = {
        seconds = true;
        date = true;
        numbers = true;
      };
      calendar = {
        weekends = true;
      };
    };
    networkPreference = "wifi";
    iconThemeDark = "Adwaita";
    cursorSettings = {
      dwl = {
        cursorHideTimeout = 0;
      };
      hyprland = {
        hideOnKeyPress = false;
        hideOnTouch = false;
        inactiveTimeout = 0;
      };
      niri = {
        hideAfterInactiveMs = 0;
        hideWhenTyping = false;
      };
      size = 24;
      theme = "Bibata-Modern-Classic";
    };
    notepadShowLineNumbers = true;
    notepadTransparencyOverride = 0.92;
    notepadLastCustomTransparency = 0.92;
    soundVolumeChanged = false;
    acMonitorTimeout = 900;
    acLockTimeout = 600;
    acSuspendTimeout = 1200;
    acPostLockMonitorTimeout = 15;
    lockBeforeSuspend = true;
    launchPrefix = "uwsm app -- ";
    terminalsAlwaysDark = true;
    matugenTemplateNiri = false;
    matugenTemplateHyprland = false;
    matugenTemplateMangowc = false;
    matugenTemplateFirefox = false;
    matugenTemplatePywalfox = false;
    matugenTemplateZenBrowser = false;
    matugenTemplateVesktop = false;
    matugenTemplateEquibop = false;
    matugenTemplateGhostty = false;
    matugenTemplateKitty = false;
    matugenTemplateFoot = false;
    matugenTemplateAlacritty = false;
    matugenTemplateWezterm = false;
    matugenTemplateKcolorscheme = false;
    matugenTemplateVscode = false;
    matugenTemplateEmacs = false;
    lockScreenShowSystemIcons = false;
    lockScreenShowPasswordField = false;
    lockScreenShowMediaPlayer = false;
    lockPamExternallyManaged = true;
    notificationTimeoutLow = 3000;
    notificationShowTimeoutBar = true;
    notificationHistoryMaxCount = 100;
    notificationHistoryMaxAgeDays = 3;
    osdAlwaysShowValue = true;
    osdPosition = 7;
    osdMediaPlaybackEnabled = true;
    osdPowerProfileEnabled = true;
    updaterIntervalSeconds = 86400;
    screenPreferences = {
      wallpaper = [ "all" ];
    };
    barConfigs = [
      {
        autoHide = false;
        autoHideDelay = 250;
        borderColor = "surfaceText";
        borderEnabled = false;
        borderOpacity = 1;
        borderThickness = 1;
        bottomGap = "unknown character to parse: -";
        ",
      " = "unknown character to parse: c";
        nterWidgets = [
          {
            enabled = true;
            id = "weather";
          }
          {
            clockCompactMode = false;
            enabled = true;
            id = "clock";
          }
          {
            enabled = true;
            id = "music";
            mediaSize = 3;
            audioScrollMode = "volume";
          }
          {
            enabled = true;
            id = "spacer";
            size = 5;
          }
        ];
        clickThrough = false;
        enabled = true;
        fontScale = 1;
        gothCornerRadiusOverride = false;
        gothCornerRadiusValue = 12;
        gothCornersEnabled = false;
        id = "default";
        innerPadding = 2;
        leftWidgets = [
          {
            enabled = true;
            id = "workspaceSwitcher";
            showWorkspaceIndex = true;
            showWorkspaceName = false;
            showWorkspacePadding = false;
            showWorkspaceApps = true;
            workspaceDragReorder = true;
            maxWorkspaceIcons = 3;
            workspaceAppIconSizeOffset = 2;
            groupWorkspaceApps = true;
            workspaceFollowFocus = false;
            showOccupiedWorkspacesOnly = false;
            reverseScrolling = true;
            dwlShowAllTags = false;
            workspaceColorMode = "default";
            workspaceOccupiedColorMode = "none";
            workspaceUnfocusedColorMode = "sch";
            workspaceUrgentColorMode = "default";
            workspaceFocusedBorderEnabled = false;
            workspaceFocusedBorderColor = "primary";
            workspaceFocusedBorderThickness = 1;
            workspaceIndicatorStyle = "pills";
            showSpecialWorkspaces = false;
          }
        ];
        maximizeDetection = true;
        name = "Main Bar";
        noBackground = false;
        openOnOverview = false;
        popupGapsAuto = true;
        popupGapsManual = 4;
        position = 0;
        rightWidgets = [
          {
            enabled = true;
            id = "developerUtilities";
          }
          {
            enabled = true;
            id = "hueManager";
          }
          {
            enabled = true;
            id = "idleInhibitor";
          }
          {
            enabled = true;
            id = "notificationButton";
          }
          {
            enabled = true;
            id = "privacyIndicator";
            privacyShowMicIcon = false;
            privacyShowCameraIcon = false;
            privacyShowScreenShareIcon = false;
          }
          {
            enabled = true;
            id = "battery";
            showBatteryPercent = true;
          }
          {
            enabled = true;
            id = "controlCenterButton";
            showAudioPercent = true;
            showBatteryIcon = true;
            showBrightnessIcon = true;
            showBrightnessPercent = true;
            showMicIcon = true;
            showMicPercent = true;
            showPrinterIcon = false;
            showScreenSharingIcon = true;
            showNetworkIcon = true;
            showVpnIcon = true;
            showBluetoothIcon = true;
            showAudioIcon = true;
          }
          {
            enabled = true;
            id = "systemTray";
          }
        ];
        screenPreferences = [ "all" ];
        scrollEnabled = true;
        scrollXBehavior = "column";
        scrollYBehavior = "workspace";
        shadowColorMode = "text";
        shadowCustomColor = "#000000";
        shadowIntensity = 12;
        shadowOpacity = 60;
        showOnLastDisplay = true;
        showOnWindowsOpen = true;
        spacing = 0;
        squareCorners = false;
        transparency = 0;
        visible = true;
        widgetOutlineColor = "surfaceText";
        widgetOutlineEnabled = true;
        widgetOutlineOpacity = 0.3;
        widgetOutlineThickness = 1;
        widgetTransparency = 0.85;
        followInterfaceStyle = false;
        shadowDirectionMode = "inherit";
        attachToScreenEdge = false;
      }
      {
        autoHide = false;
        autoHideDelay = 250;
        borderColor = "surfaceText";
        borderEnabled = false;
        borderOpacity = 1;
        borderThickness = 1;
        bottomGap = "unknown character to parse: -";
        ",
      " = "unknown character to parse: c";
        nterWidgets = [
          {
            enabled = true;
            id = "weather";
          }
          {
            clockCompactMode = false;
            enabled = true;
            id = "clock";
          }
          {
            enabled = true;
            id = "music";
            mediaSize = 3;
            audioScrollMode = "volume";
          }
          {
            enabled = true;
            id = "spacer";
            size = 5;
          }
        ];
        clickThrough = false;
        enabled = false;
        fontScale = 1;
        gothCornerRadiusOverride = false;
        gothCornerRadiusValue = 12;
        gothCornersEnabled = false;
        id = "dot1790255361154";
        innerPadding = 2;
        leftWidgets = [
          {
            enabled = true;
            id = "workspaceSwitcher";
            showWorkspaceIndex = true;
            showWorkspaceName = false;
            showWorkspacePadding = false;
            showWorkspaceApps = true;
            workspaceDragReorder = true;
            maxWorkspaceIcons = 3;
            workspaceAppIconSizeOffset = 2;
            groupWorkspaceApps = true;
            workspaceFollowFocus = false;
            showOccupiedWorkspacesOnly = false;
            reverseScrolling = true;
            dwlShowAllTags = false;
            workspaceColorMode = "default";
            workspaceOccupiedColorMode = "none";
            workspaceUnfocusedColorMode = "sch";
            workspaceUrgentColorMode = "default";
            workspaceFocusedBorderEnabled = false;
            workspaceFocusedBorderColor = "primary";
            workspaceFocusedBorderThickness = 1;
          }
        ];
        maximizeDetection = true;
        name = "Dot";
        noBackground = false;
        openOnOverview = false;
        popupGapsAuto = true;
        popupGapsManual = 4;
        position = 0;
        rightWidgets = [
          {
            enabled = true;
            id = "developerUtilities";
          }
          {
            enabled = true;
            id = "hueManager";
          }
          {
            enabled = true;
            id = "idleInhibitor";
          }
          {
            enabled = true;
            id = "notificationButton";
          }
          {
            enabled = true;
            id = "privacyIndicator";
            privacyShowMicIcon = false;
            privacyShowCameraIcon = false;
            privacyShowScreenShareIcon = false;
          }
          {
            enabled = true;
            id = "battery";
          }
          {
            enabled = true;
            id = "controlCenterButton";
            showAudioPercent = true;
            showBatteryIcon = true;
            showBrightnessIcon = true;
            showBrightnessPercent = true;
            showMicIcon = true;
            showMicPercent = true;
            showPrinterIcon = false;
            showScreenSharingIcon = true;
            showNetworkIcon = true;
            showVpnIcon = true;
            showBluetoothIcon = true;
            showAudioIcon = true;
          }
          {
            enabled = true;
            id = "systemTray";
          }
        ];
        screenPreferences = [ "all" ];
        scrollEnabled = true;
        scrollXBehavior = "column";
        scrollYBehavior = "workspace";
        shadowColorMode = "text";
        shadowCustomColor = "#000000";
        shadowIntensity = 12;
        shadowOpacity = 60;
        showOnLastDisplay = true;
        showOnWindowsOpen = true;
        spacing = 0;
        squareCorners = false;
        transparency = 0;
        visible = true;
        widgetOutlineColor = "surfaceText";
        widgetOutlineEnabled = true;
        widgetOutlineOpacity = 0.3;
        widgetOutlineThickness = 1;
        widgetTransparency = 0.85;
        followInterfaceStyle = false;
        shadowDirectionMode = "inherit";
        island = false;
        dot = true;
        islandNotificationBadgeClearOnOpen = true;
        islandNotificationPopups = true;
      }
    ];
    builtInPluginSettings = {
      dms_settings_search = {
        trigger = "?";
      };
      dms_sysmon = {
        enabled = true;
      };
      dms_qr_generator = {
        trigger = "qrg";
      };
      dms_power = {
        trigger = "pw";
      };
      dms_clipboard_search = {
        trigger = "cb";
      };
    };
    configVersion = 29;
  };

  clipboardSettings = {
    maxHistory = 100;
    maxEntrySize = 50 * 1024 * 1024;
    autoClearDays = 7;
    clearAtStartup = false;
    disabled = false;
  };

  plugins = {
    calculator = {
      enable = true;
      src = pkgs.fetchFromGitHub {
        owner = "rochacbruno";
        repo = "DankCalculator";
        rev = "0.2.2";
        sha256 = "sha256-bhV22bL38CJp58Y8tCY8sEBRYxmuk671fEymmdg0Yuk=";
      };
      settings = {
        trigger = "=";
        calcEngine = "qalc";
        noTrigger = false;
        persistHistoryOnFile = false;
      };
    };
    dankNotepadModule = {
      enable = true;
      src = "${
        pkgs.fetchFromGitHub {
          owner = "AvengeMedia";
          repo = "dms-plugins";
          rev = "141841fc85e01494df6d217bd5a27c65da87256d";
          sha256 = "sha256-/155wFIotV9xiZzX9XRGs3ANjBcLJwS4kNDDNO6WkF0=";
        }
      }/DankNotepadModule";
      settings = {
        style = "github-dark";
      };
    };
    developerUtilities = {
      enable = true;
      src = pkgs.fetchFromGitHub {
        owner = "xxyangyoulin";
        repo = "dms-plugin-developer-utilities";
        rev = "51143ca6a2df83959abfa1ea20643eae8b202992";
        sha256 = "sha256-UJE2Qf/w4zsx7grS5Q/0HqKExf6Xi8EdQjA0TgSfwTo=";
      };
      settings = {
        autoPaste = false;
        autoCloseOnCopy = true;
        enableColor = true;
        enableJson = true;
        enableJwt = true;
        enableTimestamp = true;
        enableUrl = true;
        enableBase64 = true;
        enableNumber = true;
      };
    };
    emojiLauncher = {
      enable = true;
      src = pkgs.fetchFromGitHub {
        owner = "devnullvoid";
        repo = "dms-emoji-launcher";
        rev = "cb5a2ae79084f84890135005ed2e60567307e690";
        sha256 = "sha256-5VpvUbFeatfuGdnUlNa5FB78R4dN1Zw9r/uWpUxHHfU=";
      };
      settings = {
        trigger = ":";
        pasteOnSelect = false;
        useDMS = true;
      };
    };
    hueManager = {
      enable = true;
      src = pkgs.fetchFromGitHub {
        owner = "derethil";
        repo = "dms-hue-manager";
        rev = "9901e6aa83099ad4aa91b9a8477fdf1703eee044";
        sha256 = "sha256-s/KgTULlBn/GBod4kvFsrvhoQgJoqv44j8hu5nwDxyM=";
      };
      settings = {
        openHuePath = "openhue";
        jqPath = "jq";
        useDeviceIcons = true;
      };
    };
  };
in
{
  home-manager.users.mp = {
    imports = [
      inputs.dms.homeModules.dank-material-shell
      inputs.dank-calendar.homeModules.dank-calendar
      inputs.dank-search.homeModules.dsearch
    ];

    home.packages =
      with pkgs;
      [ adwaita-icon-theme ]
      ++ lib.optionals (
        plugins.calculator.enable && plugins.calculator.settings.calcEngine == "qalc"
      ) [ libqalculate ]
      ++ lib.optionals (
        plugins.emojiLauncher.enable && !plugins.emojiLauncher.settings.useDMS
      ) [ wl-clipboard ]
      ++ lib.optionals plugins.hueManager.enable [
        jq
        openhue-cli
      ];

    programs.dank-material-shell = {
      enable = true;
      systemd.enable = true;
      inherit settings clipboardSettings plugins;
    };

    programs.dank-calendar = {
      enable = true;
      systemd.enable = true;
      settings = { };
    };
    programs.dsearch.enable = true;
  };
}

{
  inputs,
  lib,
  pkgs,
  ...
}:
let
  settings = {
    currentThemeName = "dynamic";
    currentThemeCategory = "dynamic";
    customThemeFile = "";
    registryThemeVariants = { };
    matugenScheme = "scheme-tonal-spot";
    runUserMatugenTemplates = true;
    matugenTargetMonitor = "";
    popupTransparency = 0.85;
    dockTransparency = 0.85;
    widgetBackgroundColor = "s";
    widgetColorMode = "colorful";
    controlCenterTileColorMode = "primaryContainer";
    buttonColorMode = "primaryContainer";
    cornerRadius = 10;
    niriLayoutGapsOverride = -1;
    niriLayoutRadiusOverride = -1;
    niriLayoutBorderSize = -1;
    hyprlandLayoutGapsOverride = -1;
    hyprlandLayoutRadiusOverride = -1;
    hyprlandLayoutBorderSize = -1;
    mangoLayoutGapsOverride = -1;
    mangoLayoutRadiusOverride = -1;
    mangoLayoutBorderSize = -1;
    use24HourClock = true;
    showSeconds = true;
    padHours12Hour = false;
    useFahrenheit = false;
    windSpeedUnit = "ms";
    nightModeEnabled = false;
    animationSpeed = 1;
    customAnimationDuration = 500;
    syncComponentAnimationSpeeds = true;
    popoutAnimationSpeed = 1;
    popoutCustomAnimationDuration = 150;
    modalAnimationSpeed = 1;
    modalCustomAnimationDuration = 150;
    enableRippleEffects = true;
    wallpaperFillMode = "Fill";
    blurredWallpaperLayer = false;
    blurWallpaperOnOverview = false;
    showLauncherButton = true;
    showWorkspaceSwitcher = true;
    showFocusedWindow = true;
    showWeather = true;
    showMusic = true;
    showClipboard = true;
    showCpuUsage = true;
    showMemUsage = true;
    showCpuTemp = true;
    showGpuTemp = true;
    selectedGpuIndex = 0;
    enabledGpuPciIds = [ ];
    showSystemTray = true;
    showClock = true;
    showNotificationButton = true;
    showBattery = true;
    showControlCenterButton = true;
    showCapsLockIndicator = true;
    controlCenterShowNetworkIcon = true;
    controlCenterShowBluetoothIcon = true;
    controlCenterShowAudioIcon = true;
    controlCenterShowAudioPercent = false;
    controlCenterShowVpnIcon = true;
    controlCenterShowBrightnessIcon = false;
    controlCenterShowBrightnessPercent = false;
    controlCenterShowMicIcon = false;
    controlCenterShowMicPercent = true;
    controlCenterShowBatteryIcon = false;
    controlCenterShowPrinterIcon = false;
    controlCenterShowScreenSharingIcon = true;
    showPrivacyButton = true;
    privacyShowMicIcon = false;
    privacyShowCameraIcon = false;
    privacyShowScreenShareIcon = false;
    controlCenterWidgets = [
      {
        id = "volumeSlider";
        enabled = true;
        width = 50;
      }
      {
        id = "inputVolumeSlider";
        enabled = true;
        width = 50;
      }
      {
        id = "wifi";
        enabled = true;
        width = 50;
      }
      {
        id = "bluetooth";
        enabled = true;
        width = 50;
      }
      {
        id = "audioOutput";
        enabled = true;
        width = 50;
      }
      {
        id = "audioInput";
        enabled = true;
        width = 50;
      }
      {
        id = "nightMode";
        enabled = true;
        width = 25;
      }
      {
        id = "darkMode";
        enabled = true;
        width = 25;
      }
      {
        id = "idleInhibitor";
        enabled = true;
        width = 25;
      }
      {
        id = "doNotDisturb";
        enabled = true;
        width = 25;
      }
    ];
    showWorkspaceIndex = true;
    showWorkspaceName = false;
    showWorkspacePadding = false;
    workspaceScrolling = false;
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
    workspaceNameIcons = { };
    waveProgressEnabled = true;
    scrollTitleEnabled = true;
    audioVisualizerEnabled = true;
    audioScrollMode = "volume";
    audioWheelScrollAmount = 5;
    clockCompactMode = false;
    focusedWindowCompactMode = false;
    runningAppsCompactMode = true;
    barMaxVisibleApps = 0;
    barMaxVisibleRunningApps = 0;
    barShowOverflowBadge = true;
    appsDockHideIndicators = false;
    appsDockColorizeActive = false;
    appsDockActiveColorMode = "primary";
    appsDockEnlargeOnHover = false;
    appsDockEnlargePercentage = 125;
    appsDockIconSizePercentage = 100;
    keyboardLayoutNameCompactMode = false;
    runningAppsCurrentWorkspace = false;
    runningAppsGroupByApp = false;
    runningAppsCurrentMonitor = false;
    appIdSubstitutions = [ ];
    centeringMode = "index";
    clockDateFormat = "ddd d.M.yyyy";
    lockDateFormat = "dddd d. MMMM yyyy";
    mediaSize = 1;
    appLauncherViewMode = "grid";
    spotlightModalViewMode = "grid";
    browserPickerViewMode = "grid";
    browserUsageHistory = { };
    appPickerViewMode = "grid";
    filePickerUsageHistory = { };
    sortAppsAlphabetically = false;
    appLauncherGridColumns = 6;
    spotlightCloseNiriOverview = true;
    spotlightSectionViewModes = {
      apps = "grid";
      plugin_emojiLauncher = "grid";
    };
    appDrawerSectionViewModes = { };
    niriOverviewOverlayEnabled = true;
    dankLauncherV2Size = "compact";
    dankLauncherV2BorderEnabled = false;
    dankLauncherV2BorderThickness = 1;
    dankLauncherV2BorderColor = "primary";
    dankLauncherV2ShowFooter = true;
    dankLauncherV2UnloadOnClose = false;
    useAutoLocation = false;
    weatherEnabled = true;
    networkPreference = "wifi";
    iconTheme = "Adwaita";
    cursorSettings = {
      theme = "Bibata-Modern-Classic";
      size = 24;
      niri = {
        hideWhenTyping = false;
        hideAfterInactiveMs = 0;
      };
      hyprland = {
        hideOnKeyPress = false;
        hideOnTouch = false;
        inactiveTimeout = 0;
      };
      dwl = {
        cursorHideTimeout = 0;
      };
    };
    launcherLogoMode = "os";
    launcherLogoCustomPath = "";
    launcherLogoColorOverride = "";
    launcherLogoColorInvertOnMode = false;
    launcherLogoBrightness = 0.5;
    launcherLogoContrast = 1;
    launcherLogoSizeOffset = 8;
    fontFamily = "Inter Variable";
    monoFontFamily = "Fira Code";
    fontWeight = 400;
    fontScale = 1;
    notepadUseMonospace = true;
    notepadFontFamily = "";
    notepadFontSize = 14;
    notepadShowLineNumbers = true;
    notepadTransparencyOverride = 0.92;
    notepadLastCustomTransparency = 0.92;
    soundsEnabled = true;
    useSystemSoundTheme = false;
    soundNewNotification = true;
    soundVolumeChanged = false;
    soundPluggedIn = true;
    acMonitorTimeout = 900;
    acLockTimeout = 600;
    acSuspendTimeout = 1200;
    acSuspendBehavior = 0;
    acProfileName = "";
    batteryMonitorTimeout = 0;
    batteryLockTimeout = 0;
    batterySuspendTimeout = 0;
    batterySuspendBehavior = 0;
    batteryProfileName = "";
    batteryChargeLimit = 100;
    lockBeforeSuspend = true;
    loginctlLockIntegration = true;
    fadeToLockEnabled = true;
    fadeToLockGracePeriod = 5;
    fadeToDpmsEnabled = true;
    fadeToDpmsGracePeriod = 5;
    launchPrefix = "uwsm app -- ";
    brightnessDevicePins = { };
    wifiNetworkPins = {
      preferredWifi = [
        "TP-Link_E7D8_MLO"
        "TP-Link_E7D8"
      ];
    };
    bluetoothDevicePins = {
      preferredDevice = [ "00:0A:45:43:FD:74" ];
    };
    audioInputDevicePins = { };
    audioOutputDevicePins = { };
    gtkThemingEnabled = false;
    qtThemingEnabled = false;
    syncModeWithPortal = true;
    terminalsAlwaysDark = true;
    runDmsMatugenTemplates = true;
    matugenTemplateGtk = true;
    matugenTemplateNiri = false;
    matugenTemplateHyprland = false;
    matugenTemplateMangowc = false;
    matugenTemplateQt5ct = true;
    matugenTemplateQt6ct = true;
    matugenTemplateFirefox = false;
    matugenTemplatePywalfox = false;
    matugenTemplateZenBrowser = false;
    matugenTemplateVesktop = false;
    matugenTemplateEquibop = false;
    matugenTemplateGhostty = false;
    matugenTemplateKitty = false;
    matugenTemplateFoot = false;
    matugenTemplateAlacritty = false;
    matugenTemplateNeovim = false;
    matugenTemplateWezterm = false;
    matugenTemplateDgop = true;
    matugenTemplateKcolorscheme = false;
    matugenTemplateVscode = false;
    matugenTemplateEmacs = false;
    showDock = true;
    dockAutoHide = false;
    dockSmartAutoHide = true;
    dockGroupByApp = true;
    dockOpenOnOverview = false;
    dockPosition = 1;
    dockSpacing = 5;
    dockBottomGap = 0;
    dockMargin = 0;
    dockIconSize = 40;
    dockIndicatorStyle = "circle";
    dockBorderEnabled = false;
    dockBorderColor = "surfaceText";
    dockBorderOpacity = 1;
    dockBorderThickness = 1;
    dockIsolateDisplays = false;
    dockLauncherEnabled = true;
    dockLauncherLogoMode = "os";
    dockLauncherLogoCustomPath = "";
    dockLauncherLogoColorOverride = "";
    dockLauncherLogoSizeOffset = 0;
    dockLauncherLogoBrightness = 0.5;
    dockLauncherLogoContrast = 1;
    dockMaxVisibleApps = 0;
    dockMaxVisibleRunningApps = 0;
    dockShowOverflowBadge = true;
    notificationOverlayEnabled = false;
    notificationPopupShadowEnabled = true;
    notificationPopupPrivacyMode = false;
    modalDarkenBackground = true;
    lockScreenShowPowerActions = true;
    lockScreenShowSystemIcons = false;
    lockScreenShowTime = true;
    lockScreenShowDate = true;
    lockScreenShowProfileImage = false;
    lockScreenShowPasswordField = false;
    lockScreenShowMediaPlayer = false;
    lockScreenPowerOffMonitorsOnLock = false;
    lockAtStartup = false;
    enableFprint = false;
    maxFprintTries = 15;
    lockScreenActiveMonitor = "all";
    lockScreenInactiveColor = "#000000";
    lockScreenNotificationMode = 0;
    hideBrightnessSlider = false;
    notificationTimeoutLow = 3000;
    notificationTimeoutNormal = 5000;
    notificationTimeoutCritical = 0;
    notificationCompactMode = false;
    notificationPopupPosition = 0;
    notificationAnimationSpeed = 1;
    notificationCustomAnimationDuration = 400;
    notificationHistoryEnabled = true;
    notificationHistoryMaxCount = 100;
    notificationHistoryMaxAgeDays = 3;
    notificationHistorySaveLow = true;
    notificationHistorySaveNormal = true;
    notificationHistorySaveCritical = true;
    notificationRules = [ ];
    osdAlwaysShowValue = true;
    osdPosition = 7;
    osdVolumeEnabled = true;
    osdMediaVolumeEnabled = true;
    osdMediaPlaybackEnabled = true;
    osdBrightnessEnabled = true;
    osdIdleInhibitorEnabled = true;
    osdMicMuteEnabled = true;
    osdCapsLockEnabled = true;
    osdPowerProfileEnabled = true;
    osdAudioOutputEnabled = true;
    powerActionConfirm = true;
    powerActionHoldDuration = 0.5;
    powerMenuActions = [
      "reboot"
      "logout"
      "poweroff"
      "lock"
      "suspend"
      "restart"
    ];
    powerMenuDefaultAction = "suspend";
    powerMenuGridLayout = true;
    customPowerActionLock = "";
    customPowerActionLogout = "";
    customPowerActionSuspend = "";
    customPowerActionHibernate = "";
    customPowerActionReboot = "";
    customPowerActionPowerOff = "";
    updaterHideWidget = false;
    updaterUseCustomCommand = false;
    updaterCustomCommand = "";
    updaterTerminalAdditionalParams = "";
    displayNameMode = "system";
    screenPreferences = {
      wallpaper = [ "all" ];
    };
    showOnLastDisplay = { };
    niriOutputSettings = { };
    hyprlandOutputSettings = { };
    displayProfiles = { };
    activeDisplayProfile = { };
    displayProfileAutoSelect = false;
    displayShowDisconnected = false;
    displaySnapToEdge = true;
    barConfigs = [
      {
        id = "default";
        name = "Main Bar";
        enabled = true;
        position = 0;
        screenPreferences = [
          {
            name = "DP-1";
            model = "VG34VQ3B";
          }
        ];
        showOnLastDisplay = true;
        leftWidgets = [
          {
            id = "workspaceSwitcher";
            enabled = true;
          }
        ];
        centerWidgets = [
          {
            id = "weather";
            enabled = true;
          }
          {
            id = "clock";
            enabled = true;
            clockCompactMode = false;
          }
          {
            id = "music";
            enabled = true;
            mediaSize = 3;
          }
          {
            id = "spacer";
            enabled = true;
            size = 5;
          }
        ];
        rightWidgets = [
          {
            id = "developerUtilities";
            enabled = true;
          }
          {
            id = "hueManager";
            enabled = true;
          }
          {
            id = "idleInhibitor";
            enabled = true;
          }
          {
            id = "notificationButton";
            enabled = true;
          }
          {
            id = "privacyIndicator";
            enabled = true;
          }
          {
            id = "controlCenterButton";
            enabled = true;
            showAudioPercent = true;
            showBrightnessIcon = false;
            showBrightnessPercent = false;
            showMicIcon = true;
            showMicPercent = true;
            showBatteryIcon = false;
            showPrinterIcon = false;
            showScreenSharingIcon = true;
          }
          {
            id = "systemTray";
            enabled = true;
          }
        ];
        spacing = 0;
        innerPadding = 2;
        bottomGap = -3;
        transparency = 0;
        widgetTransparency = 0.85;
        squareCorners = false;
        noBackground = false;
        gothCornersEnabled = false;
        gothCornerRadiusOverride = false;
        gothCornerRadiusValue = 12;
        borderEnabled = false;
        borderColor = "surfaceText";
        borderOpacity = 1;
        borderThickness = 1;
        widgetOutlineEnabled = true;
        widgetOutlineColor = "surfaceText";
        widgetOutlineOpacity = 0.3;
        widgetOutlineThickness = 1;
        fontScale = 1;
        autoHide = false;
        autoHideDelay = 250;
        showOnWindowsOpen = true;
        openOnOverview = false;
        visible = true;
        popupGapsAuto = true;
        popupGapsManual = 4;
        maximizeDetection = true;
        scrollEnabled = true;
        scrollXBehavior = "column";
        scrollYBehavior = "workspace";
        shadowIntensity = 80;
        shadowOpacity = 60;
        shadowColorMode = "text";
        shadowCustomColor = "#000000";
        clickThrough = false;
      }
      {
        id = "bar1770932945945";
        name = "Bar 2";
        enabled = true;
        position = 0;
        screenPreferences = [
          {
            name = "HDMI-A-1";
            model = "Acer KG241 P";
          }
        ];
        showOnLastDisplay = false;
        leftWidgets = [
          {
            id = "workspaceSwitcher";
            enabled = true;
          }
        ];
        centerWidgets = [
          {
            id = "clock";
            enabled = true;
            clockCompactMode = false;
          }
        ];
        rightWidgets = [
          {
            id = "controlCenterButton";
            enabled = true;
            showNetworkIcon = false;
            showBluetoothIcon = false;
            showAudioPercent = true;
            showVpnIcon = false;
            showBrightnessIcon = false;
            showBrightnessPercent = false;
            showMicIcon = false;
            showMicPercent = false;
            showBatteryIcon = false;
            showPrinterIcon = false;
            showScreenSharingIcon = true;
          }
          {
            id = "systemTray";
            enabled = true;
          }
        ];
        spacing = 0;
        innerPadding = 2;
        bottomGap = -3;
        transparency = 0;
        widgetTransparency = 0.8;
        squareCorners = false;
        noBackground = false;
        gothCornersEnabled = false;
        gothCornerRadiusOverride = false;
        gothCornerRadiusValue = 12;
        borderEnabled = false;
        borderColor = "surfaceText";
        borderOpacity = 1;
        borderThickness = 1;
        widgetOutlineEnabled = true;
        widgetOutlineColor = "surfaceText";
        widgetOutlineOpacity = 0.3;
        widgetOutlineThickness = 1;
        fontScale = 1;
        autoHide = false;
        autoHideDelay = 250;
        showOnWindowsOpen = false;
        openOnOverview = false;
        visible = true;
        popupGapsAuto = true;
        popupGapsManual = 4;
        maximizeDetection = true;
        scrollEnabled = true;
        scrollXBehavior = "column";
        scrollYBehavior = "workspace";
        shadowIntensity = 0;
        shadowOpacity = 60;
        shadowColorMode = "text";
        shadowCustomColor = "#000000";
      }
    ];
    desktopClockEnabled = false;
    desktopClockStyle = "analog";
    desktopClockTransparency = 0.8;
    desktopClockColorMode = "primary";
    desktopClockCustomColor = {
      r = 1;
      g = 1;
      b = 1;
      a = 1;
      hsvHue = -1;
      hsvSaturation = 0;
      hsvValue = 1;
      hslHue = -1;
      hslSaturation = 0;
      hslLightness = 1;
      valid = true;
    };
    desktopClockShowDate = true;
    desktopClockShowAnalogNumbers = false;
    desktopClockShowAnalogSeconds = true;
    desktopClockX = -1;
    desktopClockY = -1;
    desktopClockWidth = 280;
    desktopClockHeight = 180;
    desktopClockDisplayPreferences = [ "all" ];
    systemMonitorEnabled = false;
    systemMonitorShowHeader = true;
    systemMonitorTransparency = 0.8;
    systemMonitorColorMode = "primary";
    systemMonitorCustomColor = {
      r = 1;
      g = 1;
      b = 1;
      a = 1;
      hsvHue = -1;
      hsvSaturation = 0;
      hsvValue = 1;
      hslHue = -1;
      hslSaturation = 0;
      hslLightness = 1;
      valid = true;
    };
    systemMonitorShowCpu = true;
    systemMonitorShowCpuGraph = true;
    systemMonitorShowCpuTemp = true;
    systemMonitorShowGpuTemp = false;
    systemMonitorGpuPciId = "";
    systemMonitorShowMemory = true;
    systemMonitorShowMemoryGraph = true;
    systemMonitorShowNetwork = true;
    systemMonitorShowNetworkGraph = true;
    systemMonitorShowDisk = true;
    systemMonitorShowTopProcesses = false;
    systemMonitorTopProcessCount = 3;
    systemMonitorTopProcessSortBy = "cpu";
    systemMonitorGraphInterval = 60;
    systemMonitorLayoutMode = "auto";
    systemMonitorX = -1;
    systemMonitorY = -1;
    systemMonitorWidth = 320;
    systemMonitorHeight = 480;
    systemMonitorDisplayPreferences = [ "all" ];
    systemMonitorVariants = [ ];
    desktopWidgetPositions = { };
    desktopWidgetGridSettings = { };
    desktopWidgetInstances = [ ];
    desktopWidgetGroups = [ ];
    builtInPluginSettings = {
      dms_settings_search = {
        trigger = "?";
      };
      dms_sysmon = {
        enabled = true;
      };
      dankNotepadModule = {
        previewActive = false;
        currentFilePath = "";
        currentFileExtension = "md";
        sourceContent = "";
        updatedAt = 1773522842439;
        highlightedHtml = "";
      };
    };
    clipboardEnterToPaste = false;
    launcherPluginVisibility = { };
    launcherPluginOrder = [ ];
    configVersion = 5;
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
    imports = [ inputs.dms.homeModules.dank-material-shell ];

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
      dgop.package = inputs.dgop.packages.${pkgs.system}.default;
      enableVPN = false;
      inherit settings clipboardSettings plugins;
    };
  };
}

{ lib, ... }: {
  imports = [ ../../../desknix/users/mp/dank.nix ];

  home-manager.users.mp = {
    programs.dank-material-shell = {
      settings = lib.mkForce {
        currentThemeName = "dynamic";
        radiusStrength = 30;
        radiusMode = "fixed";
        fixedRadius = 8;
        clockFormat = "24h";
        showSeconds = true;
        blurBorderEnabled = true;
        blurBorderOpacity = 0.15;
        lockDateFormat = "dddd d. MMMM yyyy";
        monoFontFamily = "Hack Nerd Font";
        lockScreenShowPowerActions = true;
        enableFprint = true;
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
            spacing = 7;
            itemSpacing = 4;
            margin = 0;
            bottomGap = 0;
            transparency = 0.8;
            followInterfaceStyle = false;
            autoHide = false;
            smartAutoHide = true;
            useOverlayLayer = true;
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
            launcherLogoSizeOffset = 12;
            launcherLogoBrightness = 0.5;
            launcherLogoContrast = 1;
            maxVisibleApps = 10;
            maxVisibleRunningApps = 10;
            showOverflowBadge = true;
            showTrash = false;
            trashFileManager = "default";
            trashCustomCommand = "kitty -e nnn trash:///";
            order = [ ];
            widgets = [
              {
                enabled = true;
                id = "dock_launcher";
                widgetId = "dockLauncher";
              }
              {
                enabled = true;
                id = "dock_apps";
                widgetId = "appsDock";
                runningAppsCurrentWorkspace = false;
                appsDockEnlargeOnHover = false;
                appsDockColorizeActive = true;
              }
              {
                enabled = true;
                id = "dock_trash";
                widgetId = "dockTrash";
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
            h = 1;
            id = "volumeSlider";
            w = 4;
          }
          {
            enabled = true;
            h = 1;
            id = "inputVolumeSlider";
            w = 4;
          }
          {
            enabled = true;
            h = 1;
            id = "wifi";
            w = 4;
          }
          {
            enabled = true;
            h = 1;
            id = "bluetooth";
            w = 4;
          }
          {
            enabled = true;
            h = 1;
            id = "audioOutput";
            w = 4;
          }
          {
            enabled = true;
            h = 1;
            id = "audioInput";
            w = 4;
          }
          {
            enabled = true;
            h = 1;
            id = "nightMode";
            w = 2;
          }
          {
            enabled = true;
            h = 1;
            id = "darkMode";
            w = 2;
          }
          {
            enabled = true;
            h = 1;
            id = "idleInhibitor";
            w = 2;
          }
          {
            enabled = true;
            h = 1;
            id = "doNotDisturb";
            w = 2;
          }
        ];
        appIdSubstitutions = [ ];
        clockDateFormat = "ddd d.M.yyyy";
        appLauncherGridColumns = 6;
        rememberLastQuery = true;
        spotlightSectionViewModes = {
          apps = "grid";
          plugin_emojiLauncher = "grid";
        };
        dankLauncherV2BorderEnabled = true;
        dankLauncherV2BorderThickness = 1;
        launcherUseOverlayLayer = true;
        dashTabs = [
          {
            enabled = true;
            id = "overview";
          }
          {
            enabled = true;
            id = "media";
          }
          {
            enabled = true;
            id = "wallpaper";
          }
          {
            enabled = true;
            id = "weather";
          }
          {
            enabled = true;
            id = "notifications";
          }
        ];
        dashOptions = {
          clock = {
            date = true;
            seconds = true;
            numbers = true;
          };
          weather = {
            city = true;
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
            bottomGap = -3;
            centerWidgets = [
              {
                enabled = true;
                id = "weather";
              }
              {
                clockCompactMode = false;
                enabled = true;
                id = "clock";
                clockDateOrder = "dateFirst";
                clockNotificationBadge = true;
              }
              {
                enabled = true;
                id = "music";
                mediaSize = 3;
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
                workspaceIndicatorStyle = "pills";
                showWorkspaceIndex = true;
                showWorkspaceName = false;
                showWorkspaceApps = true;
                showSpecialWorkspaces = false;
                showOccupiedWorkspacesOnly = false;
                workspaceColorMode = "default";
                workspaceFocusedCustomColor = "#6750A4";
                workspaceOccupiedColorMode = "secondaryContainer";
                workspaceUnfocusedColorMode = "default";
                workspaceUnfocusedCustomColor = "#49454E";
                groupActiveWorkspaceApps = false;
                workspaceActiveAppHighlightEnabled = false;
                workspaceFollowFocus = false;
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
                showBatteryPercentOnlyOnBattery = false;
                showBatteryTime = false;
                batteryStyle = "outline";
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
              }
              {
                enabled = true;
                id = "systemTray";
                trayUseInlineExpansion = false;
              }
            ];
            screenPreferences = [ "all" ];
            scrollEnabled = true;
            scrollXBehavior = "column";
            scrollYBehavior = "workspace";
            shadowColorMode = "text";
            shadowCustomColor = "#000000";
            shadowIntensity = 80;
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
            hoverPopouts = true;
          }
        ];
        builtInPluginSettings = {
          dms_clipboard_search = {
            trigger = "cb";
          };
          dms_power = {
            trigger = "pw";
          };
          dms_qr_generator = {
            trigger = "qrg";
          };
          dms_settings_search = {
            trigger = "?";
          };
          dms_sysmon = {
            enabled = true;
          };
        };
        configVersion = 29;
      };
    };
  };
}

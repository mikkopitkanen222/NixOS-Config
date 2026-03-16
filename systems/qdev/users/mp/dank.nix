{ lib, ... }:
{
  imports = [ ../../../desknix/users/mp/dank.nix ];

  home-manager.users.mp = {
    programs.dank-material-shell = {
      settings = {
        wifiNetworkPins.preferredWifi = lib.mkForce [ ];
        bluetoothDevicePins.preferredDevice = lib.mkForce [ ];
        lockScreenShowProfileImage = lib.mkForce true;
        lockScreenShowPasswordField = lib.mkForce true;
        lockScreenNotificationMode = lib.mkForce 1;
        barConfigs = lib.mkForce [
          {
            id = "default";
            name = "Main Bar";
            enabled = true;
            position = 0;
            screenPreferences = [ "all" ];
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
                id = "battery";
                enabled = true;
              }
              {
                id = "controlCenterButton";
                enabled = true;
                showAudioPercent = true;
                showBrightnessIcon = true;
                showBrightnessPercent = true;
                showMicIcon = true;
                showMicPercent = true;
                showBatteryIcon = true;
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
        ];
      };

      plugins.hueManager.enable = lib.mkForce false;
    };
  };
}

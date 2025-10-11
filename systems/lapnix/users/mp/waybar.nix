# https://github.com/Alexays/Waybar
{ lib, ... }:
{
  imports = [ ../../../desknix/users/mp/waybar.nix ];

  home-manager.users.mp.programs.waybar.settings.mainBar = {
    modules-right = lib.mkForce [
      "custom/notifications"
      "tray"
      "bluetooth"
      "wireplumber"
      "network"
      "battery"
      "group/resources"
      "idle_inhibitor"
    ];

    battery = {
      design-capacity = true;
      interval = 15;
      states = {
        full = 100;
        high = 75;
        mid = 50;
        low = 25;
      };
      format = "{icon} {capacity}%";
      format-charging = "󰂄 {capacity}%";
      format-discharging = "{icon} {capacity}%";
      format-not-charging = " {capacity}%";
      format-full = "󰁹 {capacity}%";
      format-time = "{H}:{m}";
      format-icons = [
        ""
        ""
        ""
        ""
        ""
      ];
      tooltip-format = lib.strings.trim ''
        {timeTo}
        {power}W
        {cycles} cycles
        {health}% health
      '';
      tooltip-format-charging = lib.strings.trim ''
        {time} until full
        charging {power}W
        {cycles} cycles
        {health}% health
      '';
      tooltip-format-discharging = lib.strings.trim ''
        {time} until empty
        drawing {power}W
        {cycles} cycles
        {health}% health
      '';
      tooltip-format-not-charging = lib.strings.trim ''
        {timeTo}
        {cycles} cycles
        {health}% health
      '';
      tooltip-format-full = lib.strings.trim ''
        {timeTo}
        {cycles} cycles
        {health}% health
      '';
    };

    clock.interval = lib.mkForce 15;
    cpu.interval = lib.mkForce 15;
    idle_inhibitor.timeout = lib.mkForce (1.0 * 60);
    memory.interval = lib.mkForce 15;
    mpris.interval = lib.mkForce 15;
    network.interval = lib.mkForce 15;
    temperature = {
      hwmon-path = lib.mkForce "/sys/class/hwmon/hwmon2/temp1_input";
      interval = lib.mkForce 15;
    };
  };
}

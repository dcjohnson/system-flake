{
  main = {
    "layer" = "top";
    "position" = "top";
    "height" = 24;
    "spacing" = 5;
    "modules-left" = [
      "hyprland/workspaces"
      "custom/launcher"
      "custom/files"
      "custom/lockscreen"
      "custom/logout"
      "custom/shutdown"
      "hyprland/window"
    ];
    "modules-center" = [ ];
    "modules-right" = [
      #"idle_inhibitor"
      #"temperature"
      "cpu"
      "memory"
      "network"
      "pulseaudio"
      #"backlight"
      #"keyboard-state"
      "battery"
      "battery#bat2"
      "tray"
      "clock"
    ];
    "hyprland/workspaces" = {
      format = "{icon}";
      format-icons = {
        active = "";
        default = "";
      };
      "icon-size" = 10;
      "sort-by-number" = true;
    };
    "hyprland/window" = {
      "format" = "{class}";
      "max-length" = 20;
    };
    "custom/lockscreen" = {
      "format" = "";
      "icon-size" = 10;
      "on-click" = "loginctl lock-session";
      "tooltip" = false;
    };
    "custom/logout" = {
      "format" = "";
      "icon-size" = 10;
      "on-click" = "kill -9 -1";
      "tooltip" = false;
    };
    "custom/shutdown" = {
      format = "";
      "icon-size" = 10;
      "on-click" = "systemctl reboot";
      "tooltip" = false;
    };
    "custom/launcher" = {
      "format" = "";
      "icon-size" = 10;
      "on-click" = "hyprlauncher";
      "tooltip" = false;
    };
    "custom/files" = {
      "format" = "";
      "interval" = 60;
      "return-type" = "plain";
      "on-click" = "nautilus";
    };
    "keyboard-state" = {
      "numlock" = true;
      "capslock" = true;
      "format" = "{name} {icon}";
      "format-icons" = {
        "locked" = "";
        "unlocked" = "";
      };
    };
    "idle_inhibitor" = {
      "format" = "{icon}";
      "format-icons" = {
        "activated" = "";
        "deactivated" = "";
      };
    };
    "tray" = {
      "spacing" = 10;
    };
    "clock" = {
      "format" = "{:%b %d, %Y %H:%M %p}";
      "tooltip-format" = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
    };
    "cpu" = {
      "format" = "  {usage}%";
    };
    "memory" = {
      "format" = "  {}%";
    };
    "temperature" = {
      "thermal-zone" = 2;
      "hwmon-path" = "/sys/class/hwmon/hwmon2/temp1_input";
      "critical-threshold" = 176;
      "format-critical" = "{icon} {temperatureF}°F";
      "format" = "{icon} {temperatureF}°F";
      "format-icons" = [
        #""
        ""
        #""
      ];
    };
    "backlight" = {
      "format" = "{icon} {percent}%";
      "format-icons" = [
        ""
        ""
        ""
        ""
        ""
        ""
        ""
        ""
        ""
      ];
    };
    "battery" = {
      "states" = {
        "warning" = 30;
        "critical" = 15;
      };
      "format" = "{icon} {capacity}%";
      "format-charging" = " {capacity}%";
      "format-plugged" = " {capacity}%";
      "format-alt" = "{icon} {time}";
      "format-icons" = [
        ""
        ""
        ""
        ""
        ""
      ];
    };
    "battery#bat2" = {
      "bat" = "BAT2";
    };
    "network" = {
      "format-wifi" = "{essid} ({signalStrength}%) ";
      "format-ethernet" = " {ifname}";
      "tooltip-format" = " {ifname} via {gwaddr}";
      "format-linked" = " {ifname} (No IP)";
      "format-disconnected" = "Disconnected ⚠ {ifname}";
      "format-alt" = " {ifname}: {ipaddr}/{cidr}";
    };
    "pulseaudio" = {
      "scroll-step" = 5;
      "format" = "{icon}  {volume}% {format_source}";
      "format-bluetooth" = " {icon} {volume}% {format_source}";
      "format-bluetooth-muted" = "  {icon} {format_source}";
      "format-muted" = " {format_source}";
      "format-source" = " {volume}%";
      "format-source-muted" = "";
      "format-icons" = {
        "default" = [
          ""
          ""
          ""
        ];
      };
      "on-click" = "pavucontrol";
      #"on-click-right" = "foot -a pw-top pw-top";
    };
  };
}

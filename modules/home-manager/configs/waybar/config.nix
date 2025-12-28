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
      "custom/poweroff"
      "custom/reboot"
    ];
    "modules-center" = [ "hyprland/window" ];
    "modules-right" = [
      "pulseaudio"
      "cpu"
      "memory"
      "network"
      "battery"
      "battery#bat2"
      "tray"
      "clock"
    ];
    "hyprland/workspaces" = {
      format = "{icon}";
      format-icons = { };
      icon-size = 10;
      sort-by-number = true;
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
      "on-click" = "kill -9 -1"; # try sigterm for now
      "tooltip" = false;
    };
    "custom/poweroff" = {
      format = "";
      "icon-size" = 10;
      "on-click" = "systemctl poweroff";
      "tooltip" = false;
    };
    "custom/reboot" = {
      format = "";
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
      "format" = "{icon}";
      "format-bluetooth" = " {icon}";
      "format-bluetooth-muted" = "  {icon}";
      "format-muted" = "";
      "format-icons" = {
        "default" = [
          ""
        ];
      };
      "on-click" = "pavucontrol";
    };
  };
}

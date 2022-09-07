{
  systemd.user = {

    timers = {
      set_wallpaper = {
        Unit = {
          Description = "use swaybg to set the wallpaper from a cache file";
        };
        Timer = {
          Persistent = "true";
          # ToDo: make timer startup depend on sway
          OnStartupSec = "15s";
          Unit = "set_wallpaper.service";
        };
        Install = {
          WantedBy = [ "timers.target" ];
        };
      };
    };
    services = {
      set_wallpaper = {
        Unit = {
          Description = "use swaybg to set the wallpaper from a cache file";
          Wants = "set_wallpaper.timer";
        };
        Service = {
          Type = "simple";
          ExecStart = "/home/klaasjan/dot-files/services/wallpaper/set_wallpaper.sh";
          Restart = "always";
          SyslogIdentifier = "wallpaper";
        };
        Install = {
          WantedBy = [ "multi-user.target" ];
        };
      };

      wallpaper_duplication = {
        Unit = {
          Description = "Enable a smooth transition between two wallpapers (ie: no flickering)";
        };
        Service = {
          Type = "simple";
          ExecStart = "/home/klaasjan/dot-files/services/wallpaper/set_wallpaper.sh";
          SyslogIdentifier = "wallpaper_duplication";
        };
        Install = {
          WantedBy = [ "multi-user.target" ];
        };
      };


    };

  };
}

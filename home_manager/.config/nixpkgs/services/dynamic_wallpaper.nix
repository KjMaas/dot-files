{
  systemd.user = {

    timers = {
      dynamic_wallpaper = {
        Unit = {
          Description = "a dynamic wallpaper, how lovely!";
        };
        Timer = {
          Persistent = "true";
          OnCalendar = "*-*-* *:*:15,45,30,00";
          # ToDo: make timer startup depend on sway
          OnStartupSec = "20s";
          Unit = "dynamic_wallpaper.service";
        };
        Install = {
          WantedBy = [ "timers.target" ];
        };
      };
    };
    services = {
      dynamic_wallpaper = {
        Unit = {
          Description = "a dynamic wallpaper, how lovely!";
          Wants = "dynamic_wallpaper.timer";
        };
        Service = {
          Type = "oneshot";
          ExecStartPre = "/home/klaasjan/dot-files/services/wallpaper/convert_to_time.sh";
          ExecStart = "/home/klaasjan/dot-files/services/wallpaper/dynamic_wallpaper.sh";
          SyslogIdentifier = "dyn-wall";
        };
        Install = {
          WantedBy = [ "multi-user.target" ];
        };
      };
    };

  };
}

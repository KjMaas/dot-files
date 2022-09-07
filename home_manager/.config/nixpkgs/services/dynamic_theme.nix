{
  systemd.user = {

    services = {
      dynamic_theme = {
        Unit = {
          Description = "a dynamic theme based on the wallpaper";
        };
        Service = {
          Type = "oneshot";
          ExecStartPre = "/home/klaasjan/dot-files/services/theme/extract_theme.sh";
          ExecStart = "/home/klaasjan/dot-files/services/theme/apply_theme.sh";
          SyslogIdentifier = "dyn-theme";
        };
        Install = {
          WantedBy = [ "multi-user.target" ];
        };
      };
    };

  };
}

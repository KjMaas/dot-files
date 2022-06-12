{ config, pkgs, lib, ... }:

{

  # configuring sway itself (assmung a display manager starts it)
  systemd.user.targets.sway-session = {
    description = "Sway compositor session";
    documentation = [ "man:systemd.special(7)" ];
    bindsTo = [ "graphical-session.target" ];
    wants = [ "graphical-session-pre.target" ];
    after = [ "graphical-session-pre.target" ];
  };

  environment.systemPackages = with pkgs; [
    i3pystatus (python38.withPackages(ps: with ps; [ i3pystatus keyring ]))
  ];

  programs.sway = {
    enable = true;
    extraPackages = with pkgs; [
      dmenu-wayland   # dmenu for wayland-compositors
      swaylock-fancy  # This is an swaylock bash script with bluring and lock img
      swaylock        # Screen locker for Wayland
      swayidle        # Idle management daemon for Wayland
      mako            # A lightweight Wayland notification daemon
      nm-tray         # Simple Network Manager frontend written in Qt
      kanshi          # Dynamic display configuration tool
      grim            # Grab images from a Wayland compositor
      pamixer         # Pulseaudio command line mixer
      slurp           # Select a region in a Wayland compositor
      rofi-wayland    # Window switcher, run dialog and dmenu replacement for Wayland
      rofi-emoji      # An emoji selector plugin for Rofi
      waybar          # Highly customizable Wayland bar for Sway and Wlroots based compositors
      wofi            # A launcher/menu program for wlroots based wayland compositors
      wofi-emoji      # Simple emoji selector for Wayland using wofi and wl-clipboard
      wl-clipboard    # Command-line copy/paste utilities for Wayland
      wf-recorder     # Utility program for screen recording of wlroots-based compositors
      wdisplays       # A graphical application for configuring displays in Wayland compositors
      wmctrl          # CLI tool to interact with EWMH/NetWM compatible X Window Managers
      wlsunset        # Day/night gamma adjustments for Wayland
      xwayland        # An X server for interfacing X11 apps with the Wayland protocol

      (python38.withPackages(ps: with ps; [ i3pystatus keyring ]))
    ];
    extraOptions = [
      "--unsupported-gpu"
    ];
    extraSessionCommands = ''
      export SDL_VIDEODRIVER=wayland
      export QT_QPA_PLATFORM=wayland
      export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
      export _JAVA_AWT_WM_NONREPARENTING=1
      export MOZ_ENABLE_WAYLAND=1
    '';
  };

  # configuring kanshi
  systemd.user.services.kanshi = {
    description = "Kanshi output autoconfig ";
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    environment = { XDG_CONFIG_HOME="/home/mschwaig/.config"; };
    serviceConfig = {
      # kanshi doesn't have an option to specifiy config file yet, so it looks
      # at .config/kanshi/config
      ExecStart = ''
      ${pkgs.kanshi}/bin/kanshi
      '';
      RestartSec = 5;
      Restart = "always";
    };
  };

  services.xserver.enable = true;
  services.xserver.displayManager.defaultSession = "sway";
  #services.xserver.displayManager.sddm.enable = true;
  services.xserver.libinput.enable = true;

  # share screen with wlroots-based compositors
  xdg.portal.wlr.enable = true;
}

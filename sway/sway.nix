{ config, pkgs, lib, ... }:

let
  baseConfig = {
    allowUnfree = true;
    cudaSupport = true;
  };
  pkgsUnstable = import (fetchTarball http://nixos.org/channels/nixos-unstable/nixexprs.tar.xz) { config = baseConfig; };

  rofi = with pkgs; rofi-wayland.override { 
    plugins = [ 
      rofi-calc       # Do live calculations in rofi!
      rofi-emoji      # An emoji selector plugin for Rofi
    ]; 
  };

  # bash script to let dbus know about important env variables and
  # propogate them to relevent services run at the end of sway config
  # see
  # https://github.com/emersion/xdg-desktop-portal-wlr/wiki/"It-doesn't-work"-Troubleshooting-Checklist
  # note: this is pretty much the same as  /etc/sway/config.d/nixos.conf but also restarts  
  # some user services to make sure they have the correct environment variables
  dbus-sway-environment = pkgs.writeTextFile {
    name = "dbus-sway-environment";
    destination = "/bin/dbus-sway-environment";
    executable = true;

    text = ''
  dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
  systemctl --user stop pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
  systemctl --user start pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
      '';
  };

  # currently, there is some friction between sway and gtk:
  # https://github.com/swaywm/sway/wiki/GTK-3-settings-on-Wayland
  # the suggested way to set gtk settings is with gsettings
  # for gsettings to work, we need to tell it where the schemas are
  # using the XDG_DATA_DIR environment variable
  # run at the end of sway config
  configure-gtk = pkgs.writeTextFile {
      name = "configure-gtk";
      destination = "/bin/configure-gtk";
      executable = true;
      text = let
        schema = pkgs.gsettings-desktop-schemas;
        datadir = "${schema}/share/gsettings-schemas/${schema.name}";
      in ''
        export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
        gnome_schema=org.gnome.desktop.interface
        gsettings set $gnome_schema gtk-theme 'Dracula'
        '';
  };

in
{

  # configuring sway itself (assmung a display manager starts it)
  # systemd.user.targets.sway-session = {
  #   description = "Sway compositor session";
  #   documentation = [ "man:systemd.special(7)" ];
  #   bindsTo = [ "graphical-session.target" ];
  #   wants = [ "graphical-session-pre.target" ];
  #   after = [ "graphical-session-pre.target" ];
  # };

  environment.systemPackages = with pkgs; [
    i3pystatus (python38.withPackages(ps: with ps; [ i3pystatus keyring ]))
  ];

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true; # so that gtk works properly

    extraPackages = with pkgs; [
      # sway - base
      sway
      glib             # gsettings
      dracula-theme    # gtk theme
      gnome3.adwaita-icon-theme  # default gnome cursors

      # custom scripts
      dbus-sway-environment
      configure-gtk

      # additionnal packages
      clipman          # A simple clipboard manager for Wayland
      dmenu-wayland    # dmenu for wayland-compositors
      feh              # A light-weight image viewer
      sxiv             # Simple X Image Viewer
      foot             # A fast, lightweight and minimalistic Wayland terminal emulator
      # nm-tray          # Simple Network Manager frontend written in Qt
      gammastep				 # Screen color temperature manager
      grim             # Grab images from a Wayland compositor
      kanshi           # Dynamic display configuration tool
      light			    	 # GNU/Linux application to control backlights
      mako             # A lightweight Wayland notification daemon
      pamixer          # Pulseaudio command line mixer
      polkit_gnome     # A dbus session bus service that is used to bring up authentication dialogs
      slurp            # Select a region in a Wayland compositor
      swappy           # A Wayland native snapshot editing tool
      swaybg           # Wallpaper tool for Wayland compositors
      swaylock-fancy   # This is an swaylock bash script with bluring and lock img
      swaylock         # Screen locker for Wayland
      swayidle         # Idle management daemon for Wayland
      swayr            # A window switcher (and more) for sway
      rofi             # Window switcher, run dialog and dmenu replacement for Wayland
      vimiv-qt         # Image viewer with Vim-like keybindings (Qt port)
      waybar           # Highly customizable Wayland bar for Sway and Wlroots based compositors
      wl-clipboard     # Command-line copy/paste utilities for Wayland
      wlr-randr        # An xrandr clone for wlroots compositors
      wdisplays        # A graphical application for configuring displays in Wayland compositors
      wf-recorder      # Utility program for screen recording of wlroots-based compositors
      greetd.wlgreet   # Raw wayland greeter for greetd, to be run under sway or similar
      wmctrl           # CLI tool to interact with EWMH/NetWM compatible X Window Managers
      xwayland         # An X server for interfacing X11 apps with the Wayland protocol

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
      export XDG_CURRENT_DESKTOP=sway
      export XDG_SESSION_DESKTOP=sway
      export WLR_DRM_NO_MODIFIERS=1
    '';
  };

  # configuring kanshi
  # systemd.user.services.kanshi = {
  #   description = "Kanshi output autoconfig ";
  #   wantedBy = [ "graphical-session.target" ];
  #   partOf = [ "graphical-session.target" ];
  #   environment = { XDG_CONFIG_HOME="/home/klaasjan/.config"; };
  #   serviceConfig = {
  #     # kanshi doesn't have an option to specifiy config file yet, so it looks
  #     # at .config/kanshi/config
  #     ExecStart = ''
  #     ${pkgs.kanshi}/bin/kanshi
  #     '';
  #     RestartSec = 5;
  #     Restart = "always";
  #   };
  # };

  #services.xserver.enable = true;
  #services.xserver.displayManager.defaultSession = "sway";
  #services.xserver.displayManager.sddm.enable = true;
  #services.xserver.libinput.enable = true;

  # share screen with wlroots-based compositors
  # xdg-desktop-portal works by exposing a series of D-Bus interfaces
  # known as portals under a well-known name
  # (org.freedesktop.portal.Desktop) and object path (/org/freedesktop/portal/desktop).
  # The portal interfaces include APIs for file access, opening URIs, printing and others.
  services.dbus.enable = true;
  xdg = {
    portal = {
      enable = true;
      wlr.enable = true;

      # gtk portal needed to make gtk apps happy
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };
  };
}

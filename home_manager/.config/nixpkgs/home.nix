{ config, pkgs, ... }:

let
  baseConfig = {
    allowUnfree = true;
    cudaSupport = true;
  };

  # Import config files
  # nvimsettings = import ./nvim/neovim.nix;

  pkgsUnstable = import (fetchTarball http://nixos.org/channels/nixos-unstable/nixexprs.tar.xz) { config = baseConfig; };
  #pkgsUnstable = import <pkgs-unstable> { config = baseConfig; };
in
{

  nixpkgs.config = baseConfig;

  fonts.fontconfig.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    username = "klaasjan";
    homeDirectory = "/home/klaasjan";

    packages = with pkgs; [
      # 3D
      pkgsUnstable.blender		# Da best!
      f3d             # Fast and minimalist 3D viewer using VTK
      foxotron        # General purpose model viewer
      # assimp          # A library to import various 3D model formats

     # (f3d.override { 
      #  cmakeFlags = ["F3D_MODULE_ASSIMP=ON"];
      #  }
      # )

      # social media
      discord			   	# All-in-one cross-platform voice and text chat for gamers
      signal-desktop	# Private, simple, and secure messenger
      whatsapp-for-linux		# Whatsapp desktop messaging app
      zoom-us         # zoom.us video conferencing application
      
      # base
      brave			    	# Privacy-oriented browser for Desktop and Laptop computers
      drawio			   	# A desktop application for creating diagrams
      gimp			    	# The GNU Image Manipulation Program
      inkscape				# Vector graphics editor
      keepassxc				# Offline password manager with many features.
				             	# /!\ " buildPhase completed in 50 minutes 17 seconds "
      btop            # A monitor of resources
      zip             # Compressor/archiver for creating and modifying zipfiles

      pdfsam-basic		# Multi-platform software designed to extract pages, split, merge, mix and rotate PDF files
      #flameshot			# Powerful yet simple to use screenshot software
      qalculate-gtk   # The ultimate desktop calculator

      qpwgraph 				# Qt graph manager for PipeWire, similar to QjackCtl

      xfce.thunar			# Xfce file manager
      xfce.thunar-volman		# Thunar extension for automatic management of removable drives and media
      gvfs	    			# Virtual Filesystem support library


      # nnn	Configuration
      (nnn.override { withNerdIcons = true; }) # Small ncurses-based file browser forked from noice
      # preview-tabbed
      tabbed          # Simple generic tabbed fronted to xembed aware applications
      mpv             # General-purpose media player, fork of MPlayer and mplayer2
      sxiv            # Simple X Image Viewer
      nsxiv           # New Suckless X Image Viewer
      zathura		    	# A highly customizable and functional PDF viewer
      file            # A program that shows the type of files
      mktemp          # Simple tool to make temporary file handling in shells scripts safe and simple
      wtype           # xdotool type for wayland (Fake keyboard/mouse input, window management, and more)
      # preview-tui
      less            # A more advanced file pager than ‘more’
      tree            # Command to produce a depth indented directory listing
      mediainfo       # Supplies technical and tag information about a video or audio file
      mktemp          # Simple tool to make temporary file handling in shells scripts safe and simple
      unzip           # An extraction utility for archives compressed in .zip format
      man             # An implementation of the standard Unix documentation system accessed using the man command
      bat             # A cat(1) clone with syntax highlighting and Git integration
      viu             # A command-line application to view images from the terminal written in Rust
      imagemagick			# A software suite to create, edit, compose, or convert bitmap images
      ffmpegthumbnailer  # A lightweight video thumbnailer
      ffmpeg          # A complete, cross-platform solution to record, convert and stream audio and video
      libreoffice-qt	# Comprehensive, professional-quality productivity suite
      poppler_utils   # A PDF rendering library
      fontpreview     # Highly customizable and minimal font previewer written in bash
      djvulibre       # The big set of CLI tools to make/modify/optimize/show/export DJVU files
      glow            # Render markdown on the CLI, with pizzazz!
      w3m             # A text-mode web browser
      pistol          # General purpose file previewer designed for Ranger, Lf to make scope.sh redundant
      kitty           # A modern, hackable, featureful, OpenGL based terminal emulator
      # launcher
      fzf             # A command-line fuzzy finder written in Go
      # drag-and-drop
      xdragon         # Simple drag-and-drop source/sink for X 




      # Colorscheme
      flavours        # An easy to use base16 scheme manager/builder that integrates with any workflow
      wpgtk           # Template based wallpaper/colorscheme generator and manager

      wpa_supplicant_gui # Qt-based GUI for wpa_supplicant
      rclone			  	# Command line program to sync files and directories to and from major cloud storage
      rclone-browser	# Graphical Frontend to Rclone written in Qt
      # etcher			  	# Flash OS images to SD cards and USB drives, safely and easily
      stow				    # Symlinking on steroids!

      # development
      # tmux            # Terminal multiplexer
      dbeaver         # Universal SQL Client for developers, DBA and analysts
      git	      			# Distributed version control system
      poetry          # Python dependency management and packaging made easy.
      tig			      	# Text-mode interface for git
      # alacritty				# A cross-platform, GPU-accelerated terminal emulator
      vscode			  	# Open source source code editor developed by Microsoft


      # lvim (NeoVim) specific configuration
      # Language servers for neovim; change these to whatever languages you code in
      # Please note: if you remove any of these, make sure to also remove them from nvim/config/nvim/lua/lsp.lua!!
      rnix-lsp
      sumneko-lua-language-server

      (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })

    ];
  };


  #  programs.git = {
  #    enable = true;
  #    userName = "Klaasjan Maas";
  #    userEmail = "klaasjan.maas@laposte.net";
  #  };


  home.sessionVariables = { 
    XDG_CONFIG_HOME="$HOME/.config";
    EDITOR="lvim";
    VISUAL="lvim";
    TERMINAL="kitty";

    # specific to nnn
    # key-bookmark pairs
    NNN_BMS="d:$HOME/Documents;D:$HOME/Downloads/;m:$HOME/onedrive/Majok/";
    # FIFO to write hovered file path to
    NNN_FIFO="/tmp/nnn.fifo";
    # plugins
    NNN_PLUG="p:preview-tui;d:dragdrop;o:fzopen";
    # extra options
    NNN_OPTS="ea";
    # use EDITOR
    NNN_USE_EDITOR=1;
    # Set a distinct color for each tab (by default all are blue)
    NNN_CONTEXT_COLORS=1234;
    # use icons in preview mode
    ICONLOOKUP=1;
    # USE_PISTOL=1;
  };
  #home.sessionPath = [ "~/.local/bin/foo" ];
  #xsession.enable = true;  

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    defaultKeymap = "viins";
    enableAutosuggestions = true;
    # shellAliases = (import ./zsh/aliases.nix);
    history.extended = true;

    plugins = [
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "be3882aeb054d01f6667facc31522e82f00b5e94";
          sha256 = "0w8x5ilpwx90s2s2y56vbzq92ircmrf0l5x8hz4g1nx3qzawv6af";
        };
      }
    ];

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "vi-mode" "z" ];
      theme = "robbyrussell";
    };

    envExtra = ''
      # direnv hook
      eval "$(direnv hook zsh)"

      # this is where lvim binary is stored
      export PATH="$PATH:$HOME/.local/bin"
      
      # # required for npm (solves permissions errors when trying to install packages globally)
      # export PATH=~/.npm-packages/bin:$PATH
      # export NODE_PATH=~/.npm-packages/lib/node_modules

      # nnn configuration
      # source ~/dot-files/nnn/.config/nnn/nnn_env_vars
    '';

  };

  # default app-launchers
  # usefull commands:
  # XDG_UTILS_DEBUG_LEVEL=2 xdg-mime query filetype foo.pdf
  # XDG_UTILS_DEBUG_LEVEL=2 xdg-mime query default application/pdf
  # cat /home/klaasjan/.nix-profile/share/applications/mimeinfo.cache
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "image/png" = ["img.desktop"];
      "image/jpg" = ["img.desktop"];
      "image/jpeg" = ["img.desktop"];
      "text/html" = ["brave-browser.desktop"];
      "text/x-python" = ["text.desktop"];
      "text/plain" = ["text.desktop"];
      "application/pdf" = ["org.pwmt.zathura-pdf-mupdf.desktop"];
    };
  };

  # Direnv
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
  };

  # services = {
  #   flameshot.enable = true;	# Powerful yet simple to use screenshot software
  # };


  # theme-ing
  # gtk = {
  #   enable = true;
  #   theme = {
  #     name = "Materia-dark";
  #     package = pkgs.materia-theme;
  #   };
  # };


  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

}

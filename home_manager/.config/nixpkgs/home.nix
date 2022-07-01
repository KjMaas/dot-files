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
      mpv	      			# General-purpose media player, fork of MPlayer and mplayer2
      zoom-us         # zoom.us video conferencing application
      
      # base
      brave			    	# Privacy-oriented browser for Desktop and Laptop computers
      drawio			   	# A desktop application for creating diagrams
      gimp			    	# The GNU Image Manipulation Program
      inkscape				# Vector graphics editor
      imagemagick			# A software suite to create, edit, compose, or convert bitmap images
      keepassxc				# Offline password manager with many features.
      libreoffice-qt	# Comprehensive, professional-quality productivity suite
				             	# /!\ " buildPhase completed in 50 minutes 17 seconds "
      mako            # A lightweight Wayland notification daemon

      pdfsam-basic		# Multi-platform software designed to extract pages, split, merge, mix and rotate PDF files
      zathura		    	# A highly customizable and functional PDF viewer
      #flameshot			# Powerful yet simple to use screenshot software
      qalculate-gtk   # The ultimate desktop calculator

      qpwgraph 				# Qt graph manager for PipeWire, similar to QjackCtl

      xfce.thunar			# Xfce file manager
      xfce.thunar-volman		# Thunar extension for automatic management of removable drives and media
      gvfs	    			# Virtual Filesystem support library

      nnn		      		# Small ncurses-based file browser forked from noice

      wpa_supplicant_gui # Qt-based GUI for wpa_supplicant
      rclone			  	# Command line program to sync files and directories to and from major cloud storage
      rclone-browser	# Graphical Frontend to Rclone written in Qt
      #etcher			  	# Flash OS images to SD cards and USB drives, safely and easily
      stow				    # Symlinking on steroids!

      # development
      git	      			# Distributed version control system
      tig			      	# Text-mode interface for git
      # alacritty				# A cross-platform, GPU-accelerated terminal emulator
      vscode			  	# Open source source code editor developed by Microsoft


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


  home.sessionVariables = { EDITOR = "lvim"; };
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
    '';

  };

  # Direnv
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
  };

  services = {
    flameshot.enable = true;	# Powerful yet simple to use screenshot software
  };


  # theme-ing
  gtk = {
    enable = true;
    theme = {
      name = "Materia-dark";
      package = pkgs.materia-theme;
    };
  };


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

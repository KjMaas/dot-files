{ config, pkgs, lib,  ... }:

# utils:
# sha256 = lib.fakeSha256;

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

  imports = [
    ./programs/nnn
  ];

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
      trash-cli       # Command line tool for the desktop trash can
      btop            # A monitor of resources
      zip             # Compressor/archiver for creating and modifying zipfiles

      # pandoc section
      ################
      # pandoc                          # Conversion between markup formats
      pandoc-drawio-filter              # Pandoc filter which converts draw.io diagrams to PDF
      # texlive.combined.scheme-basic     # TeX Live environment for scheme-basic
      texlive.combined.scheme-full
      # haskellPackages.pandoc-citeproc # Supports using pandoc with citeproc
      haskellPackages.pandoc
      haskellPackages.citeproc # Supports using pandoc with citeproc
      haskellPackages.pandoc-crossref # Pandoc filter for cross-references
      wkhtmltopdf                     # Tools for rendering web pages to PDF or images
      mendeley                        # A reference manager and academic social network
      unoconv                         # Convert between any document format supported by LibreOffice/OpenOffice


      zathura		    	# A highly customizable and functional PDF viewer
      pdfsam-basic		# Multi-platform software designed to extract pages, split, merge, mix and rotate PDF files
      imagemagick			# A software suite to create, edit, compose, or convert bitmap images
      sxiv            # Simple X Image Viewer
      libreoffice-qt	# Comprehensive, professional-quality productivity suite
				             	# /!\ " buildPhase completed in 50 minutes 17 seconds "
      qalculate-gtk   # The ultimate desktop calculator


      helvum          # A GTK patchbay for pipewire
      pavucontrol     # PulseAudio Volume Control
      carla           # An audio plugin host
      qjackctl        # A Qt application to control the JACK sound server daemon
      qpwgraph 				# Qt graph manager for PipeWire, similar to QjackCtl


      mimeo          # Open files by MIME-type or file name using regular expressions
      perl532Packages.FileMimeInfo
      xfce.thunar			# Xfce file manager
      xfce.thunar-volman		# Thunar extension for automatic management of removable drives and media
      gvfs	    			# Virtual Filesystem support library


      # Colorscheme
      flavours        # An easy to use base16 scheme manager/builder that integrates with any workflow
      # wpgtk           # Template based wallpaper/colorscheme generator and manager

      wpa_supplicant_gui # Qt-based GUI for wpa_supplicant
      rclone			  	# Command line program to sync files and directories to and from major cloud storage
      rclone-browser	# Graphical Frontend to Rclone written in Qt
      # etcher			  	# Flash OS images to SD cards and USB drives, safely and easily
      stow				    # Symlinking on steroids!

      # development
      kitty           # A modern, hackable, featureful, OpenGL based terminal emulator
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
  home.shellAliases = {
      gs = "git status";
      v = "$EDITOR";
      n = "nnn";
      "..." = "cd ../..";
      l="ls -ahlF";
      ll = "ls -l";
      ls = "ls --color=tty";
  };


  home.sessionVariables = { 
    XDG_CONFIG_HOME="$HOME/.config";
    MAJOK_DIR="$HOME/Documents/Majok";

    EDITOR="lvim";
    VISUAL="lvim";
    TERMINAL="kitty";
  };
  #home.sessionPath = [ "~/.local/bin/foo" ];
  #xsession.enable = true;  

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    defaultKeymap = "viins";
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    cdpath = ["/tmp" "~/Documents"];
    # dotDir = "$HOME/.config/zsh";
    # shellAliases = (import ./zsh/aliases.nix);
    history = {
      expireDuplicatesFirst = true;
      extended = true;
      ignorePatterns = [ "l *" "ls *" ];
      ignoreSpace = true;
    };
    loginExtra = ''
      echo "loginExtra: loaded!"
    '';
    logoutExtra = ''
      echo "logoutExtra: loaded!"
    '';
    profileExtra = ''
      echo "profileExtra: loaded!"
    '';
    sessionVariables = {};
    initExtraFirst = ''
      echo "initExtraFirst: loaded!"
    '';
    initExtra = ''
      echo "initExtra: loaded!"
      # direnv hook
      eval "$(direnv hook zsh)"

      # this is where lvim binary is stored
      export PATH="$PATH:$HOME/.local/bin"

      # # required for npm (solves permissions errors when trying to install packages globally)
      # export PATH=~/.npm-packages/bin:$PATH
      # export NODE_PATH=~/.npm-packages/lib/node_modules
    '';
    envExtra = ''
      echo "envExtra: loaded!"
      # list directory content when using 'cd'
      function cd () {
        builtin cd "$1";
        ls -ahlF --color=tty;
      }

      # cd into directory and show dir tree when created
      currentDir="$(pwd)"
      function mkcd () {
        mkdir -p "$1";
        builtin cd "$1";
        tree -L 3 -d "$currentDir";
      }
    '';
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

  };

  # default app-launchers
  # usefull commands:
  # XDG_UTILS_DEBUG_LEVEL=2 xdg-mime query filetype foo.pdf
  # XDG_UTILS_DEBUG_LEVEL=2 xdg-mime query default application/pdf
  # cat /home/klaasjan/.nix-profile/share/applications/mimeinfo.cache
  xdg = {
    mimeApps = {
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
    desktopEntries = {
      btop = {
        name = "btop";
        genericName = "Ressource Manager";
        exec = "btop";
        type = "Application";
        icon = "null";
        terminal = true;
        # categories = [ "Application" "Network"];
        mimeType = [];
      };
    };
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

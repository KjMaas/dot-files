# Edit this configuration file to define what should be installed on 
# yQt-based GUI for wpa_supplicantour system.  Help is available in the configuration.nix(5) man page 
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

let
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec -a "$0" "$@"
  '';
in
{

  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    # Configure tilling WM
    ../sway/sway.nix
    # Configure neovim
    ../home_manager/.config/nixpkgs/nvim/nvim.nix
  ];

  nixpkgs.config = {
    allowUnfree = true;
    cudaSupport = true;
  };

  hardware.enableAllFirmware = false;

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
  };

  hardware.opengl = {
    enable = true;
    driSupport = true;
  };

  hardware = {
    nvidiaOptimus.disable = false;
    nvidia = {
      modesetting.enable = true;
      # powerManagement.enable = true;
      prime = {
        offload.enable = true;
        amdgpuBusId = "PCI:4:00:0";
        nvidiaBusId = "PCI:1:00:0";
        # In sync mode the Nvidia card is turned on constantly,
        # having impact on laptop battery and health 
        sync.enable = false;
      };
    };
  };
  specialisation = {
    external-display.configuration = {
      system.nixos.tags = [ "external-display" ];
      hardware.nvidia = {
        modesetting.enable = lib.mkForce false;
        powerManagement.enable = lib.mkForce false;
        prime.offload.enable = lib.mkForce false;
        prime.sync.enable = lib.mkForce true; # --> used for external monitors connected through HDMI port
      };
    };
  };

  boot = {
    #kernelParams = [ "nomodeset" ];
    extraModulePackages = [
      config.boot.kernelPackages.broadcom_sta
      pkgs.linuxPackages.nvidia_x11
    ];
    # blacklistedKernelModules = [ "nouveau" "nvidia_drm" "nvidia_modeset" "nvidia" ];
    blacklistedKernelModules = [ "nouveau" ];
    kernelModules = [ "wl" ];
  };


  # Use the systemd-boot EFI boot loader.
  # boot.loader.systemd-boot.enable = true;
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
    grub = {
      enable = true;
      devices = [ "nodev" ];
      efiSupport = true;
      useOSProber = true;
      # copyKernels = true;
      # efiInstallAsRemovable = true;
      # fsIdentifier = "label";
      #splashImage = ./backgrounds/grub-nixos-3.png;
      #splashMode = "stretch";
      extraEntries = ''
        menuentry "Reboot" {
          reboot
        }
        menuentry "Poweroff" {
          halt
        }
      '';
    };
  };


  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";


  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    # keyMap = "us";

    # Use same config for linux console
    useXkbConfig = true;
  };


  services.xserver = {
    # Enable the X11 windowing system.
    videoDrivers = [ "nvidia" ];

    # Configure keymap in X11
    layout = "eu";
    xkbOptions = "
      # grp:win_space_toggle 
      # eurosign:e
    ";

    # Enable touchpad support (enabled default in most desktopManager).
    libinput.enable = true;
  };


  # Desktop Manager
  services.xserver = {
    enable = true;

    desktopManager = {
      xterm.enable = false;
      gnome.enable = false;
      xfce = {
        enable = true;
        noDesktop = true;
        enableXfwm = false;
      };
    };

    displayManager = {
      defaultSession = "xfce+sway";
      lightdm.enable = false;
      gdm = {
        enable = false;
        wayland = false;
      };
    };
  };
  services.gnome = {
    core-utilities.enable = false;
  };

  # configure backlight
  programs.light.enable = true;

  # sync with Microsoft OneDrive
  services.onedrive.enable = false;


  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    drivers = with pkgs; [
      hplip # Print, scan and fax HP drivers for Linux
      #      hplipWithPlugin             # Print, scan and fax HP drivers for Linux
      #      python39Packages.distro     # Linux Distribution - a Linux OS platform information API.
    ];
  };

  programs.system-config-printer.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = false;

  # rtkit is optional but recommended
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    audio.enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    jack.enable = true;
  };



  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.klaasjan = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "audio" "video" ]; # Enable ‘sudo’ for the user.
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    home-manager    # A user environment configurator
    nixops_unstable # NixOS cloud provisioning and deployment tool

    # graphics
    nvidia-offload
    linuxPackages.nvidia_x11

    # dev
    vim             # The most popular clone of the VI editor
    git             # Distributed version control system
    alacritty       # A cross-platform, GPU-accelerated terminal emulator
    shellcheck      # Shell script analysis tool
    docker-compose  # Multi-container orchestration for Docker

    # utilities
    bash
    bat             # A cat(1) clone with syntax highlighting and Git integration
    htop-vim        # An interactive process viewer for Linux, with vim-style keybindings
    zenith-nvidia   # Like htop but with zoom-able charts, network, disk usage, and NVIDIA GPU usage
    nvtop           # A (h)top like task monitor for AMD and NVIDIA GPUs
    jq              # A lightweight and flexible command-line JSON processor
    lshw            # Provide detailed information on the hardware configuration of the machine
    nmap            # Utility for network discovery and security auditing
    neofetch        # A fast, highly customizable system info script
    pciutils        # Programs for inspecting and manipulating configuration of PCI devices
    tree            # Command to produce a depth indented directory listing
    unzip           # An extraction utility for archives compressed in .zip format
    wget            # Tool for retrieving files using HTTP, HTTPS, and FTP

    gparted         # Graphical disk partitioning tool
    gnumake         # A tool to control the generation of non-source files from sources
    gcc             # GNU Compiler Collection, version 11.3.0 (wrapper script)

    stow            # Simlinking farm on steroids!

  ];

  environment.variables = {
    EDITOR = "lvim";
  };


  fonts = {
    fontDir.enable = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      fira-code
      fira-code-symbols
    ];
  };

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  networking = {
    hostName = "nixos"; # Define your hostname.

    # Pick only one of the below networking options.
    networkmanager.enable = false; # Easiest to use and most distros use this by default.
    wireless = {
      enable = true; # Enables wireless support via wpa_supplicant.
      userControlled.enable = true;

      environmentFile = "/run/keys/wireless";
      networks = {
        "Freebox-48448F" = {
          psk = "@PSK_FREE@";
          priority = 10;
        };
        "Livebox-30AC" = {
          psk = "@PSK_ORANGE@";
          priority = 10;
        };
        "NETGEAR78" = {
          pskRaw = "@PSK_PRADES@";
          priority = 3;
        };
        "NETGEAR78_EXT" = {
          psk = "@PSK_PRADES_EXT@";
          priority = 4;
        };
        "Bbox-9A77B139" = {
          psk = "@PSK_MONICA@";
          priority = 4;
        };
        "Majok" = {
          psk = "@PSK_MAJOK@";
          priority = 100;
        };
        "Galaxy S94b45" = {
          psk = "@PSK_ANTALYA@";
          priority = 90;
        };
        "CAMPUS-NUMERIQUE" = {
          psk = "@PSK_CAMPUS@";
          priority = 10;
        };
      };
    };

    # Configure network proxy if necessary
    #proxy.default = "http://user:password@proxy:port/";
    #proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Open ports in the firewall.
    #firewall.allowedTCPPorts = [ ... ];
    #firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    #firewall.enable = false;
  };

  virtualisation.docker.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    permitRootLogin = "yes"; # needed to deploy on localhost with nixops
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

}


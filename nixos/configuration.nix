# Edit this configuration file to define what should be installed on 
# your system.  Help is available in the configuration.nix(5) man page 
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
    ../sway/sway.nix
  ];

  nixpkgs.config = {
    allowUnfree = true;
    cudaSupport = false;
  };

  hardware.enableAllFirmware = true;

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
  };

  hardware.nvidia.prime = {
    offload.enable = true;
    amdgpuBusId = "PCI:4:00:0";
    nvidiaBusId = "PCI:1:00:0";
  };

  hardware.opengl = {
    enable = true;
    driSupport = true;
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
      # extraEntries = ''
      #   menuentry "Reboot" {
      #     reboot
      #   }
      #   menuentry "Poweroff" {
      #     halt
      #   }
      # '';
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
    videoDrivers = [ "nvidia" "amdgpu"];

    # Configure keymap in X11
    layout = "us,fr";
    xkbOptions = "
      grp:win_space_toggle 
      eurosign:e
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
        wayland = true;
      };
    };
  };
  services.gnome = {
    core-utilities.enable = false;
  };

 # configure backlight
 programs.light.enable = true;

 # sync with Microsoft OneDrive
 services.onedrive.enable = true;


  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    drivers = with pkgs; [ 
      hplip                       # Print, scan and fax HP drivers for Linux
#      hplipWithPlugin             # Print, scan and fax HP drivers for Linux
#      python39Packages.distro     # Linux Distribution - a Linux OS platform information API.
    ];
  };

  programs.system-config-printer.enable = true;

  # Enable sound.
  #sound.enable = true;
  hardware.pulseaudio.enable = false;

  # rtkit is optional but recommended
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    audio.enable =true;
    alsa = {
      enable = true;
      #support32Bit = true;
    };
    pulse.enable = true;
    jack.enable = true;
    #media-session.enable = true;
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

    # graphics
    nvidia-offload
    linuxPackages.nvidia_x11

    # dev
    vim             # The most popular clone of the VI editor
    git             # Distributed version control system
    alacritty       # A cross-platform, GPU-accelerated terminal emulator

    # utilities
    bash
    bat             # A cat(1) clone with syntax highlighting and Git integration
    htop            # An interactive process viewer
    htop-vim        # An interactive process viewer for Linux, with vim-style keybindings
    jq              # A lightweight and flexible command-line JSON processor
    lshw            # Provide detailed information on the hardware configuration of the machine
    nmap            # Utility for network discovery and security auditing
    neofetch        # A fast, highly customizable system info script
    pciutils        # Programs for inspecting and manipulating configuration of PCI devices
    tree            # Command to produce a depth indented directory listing
    unzip           # An extraction utility for archives compressed in .zip format
    wget            # Tool for retrieving files using HTTP, HTTPS, and FTP

    gnumake         # A tool to control the generation of non-source files from sources
    gcc             # GNU Compiler Collection, version 11.3.0 (wrapper script)

    stow            # Simlinking farm on steroids!

  ];

  #programs.zsh = {
  #  enable = true;
  #};

  environment.variables = {
    EDITOR = "vim";
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


  networking = {
    hostName = "nixos"; # Define your hostname.

    # Pick only one of the below networking options.
    wireless.enable = false; # Enables wireless support via wpa_supplicant.
    networkmanager.enable = true; # Easiest to use and most distros use this by default.

    # Configure network proxy if necessary
    #proxy.default = "http://user:password@proxy:port/";
    #proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Open ports in the firewall.
    #firewall.allowedTCPPorts = [ ... ];
    #firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    #firewall.enable = false;
  };


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

}


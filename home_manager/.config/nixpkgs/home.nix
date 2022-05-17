{ config, pkgs, ... }:

let
  baseConfig = {
    allowUnfree = true;
    cudaSupport = true;
  };

  pkgsUnstable = import <nixpkgs-unstable> { config = baseConfig; };

in
{

  nixpkgs.config = baseConfig;

  fonts.fontconfig.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    username = "klaas";
    homeDirectory = "/home/klaas";

    packages = with pkgs; [
      # 3D
      pkgsUnstable.blender
      #blender

      # social media
      signal-desktop
      discord

      # base
      #arandr
      imagemagick
      keepassxc
      brave
      #pcmanfm
      libsForQt5.dolphin

      # development
      vscode

      pkgsUnstable.neovim
      python39Packages.pip
      nodePackages.npm
      nodejs
      cargo

      (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })

      ## Sway-related packages swaylock
      #swayidle
      #wl-clipboard
      #mako # notification daemon
      #alacritty # Alacritty is the default terminal in the config
      #wofi # Dmenu is the default in the config but i recommend wofi since its wayland native
    ];
  };

  #wayland.windowManager.sway = {
  #  enable = true;
  #  wrapperFeatures.gtk = true ;
  #};

  #  programs.git = {
  #    enable = true;
  #    userName = "Yasuaki Kudo";
  #    userEmail = "yasu@yasuaki.com";
  #  };

  programs.neovim = {
    enable = false;
    plugins = [
      pkgs.vimPlugins.vim-airline
      pkgs.vimPlugins.vim-nix
    ];
    #settings = { ignorecase = true; };
    extraConfig = ''
      set mouse=a
      set number
      set relativenumber
      set ignorecase
      set pastetoggle=<F2>
      set clipboard+=unnamedplus
    '';
  };


  home.sessionVariables = { EDITOR = "nvim"; };
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
      plugins = [ "git" "vi-mode" "z"];
      theme = "robbyrussell";
    };

    envExtra = ''
      export PATH="$PATH:$HOME/.local/bin"
    '';
  };


  services = {
    flameshot.enable = true;
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

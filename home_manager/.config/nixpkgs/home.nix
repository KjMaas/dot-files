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

  # Home Manag#em needs a bit of information about you and the
  # paths it should manage.
  home = {
    username = "klaasjan";
    homeDirectory = "/home/klaasjan";

    packages = with pkgs; [
      # 3D
      #pkgsUnstable.blender

      # social media
      #signal-desktop
      #discord

      # base
      #arandr
      #gimp
      #inkscape
      #imagemagick
      #keepassxc
      #brave
      #pcmanfm
      #gparted

      # development
      #alacritty
      #vscode

      #pkgsUnstable.neovim
      #python39Packages.pip
      #nodePackages.npm
      #nodejs
      #cargo

      #etcher
      stow                      # Simlinking on steroids!
      nix                       # Most Powerful package manager ever!!!
      direnv                    # A shell extension that manages your environment

      (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })

    ];
  };


  programs.neovim = {
    enable = true;
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
  home.sessionPath = [ "~/.profile" ];

  xsession = {
    enable = false;

    windowManager.i3 = {
      enable = false;
      config = let mod = "Mod4"; in
        {
          fonts = [ "DejaVu Sans 12" ];
          modifier = mod;
          keybindings = pkgs.lib.mkOptionDefault {
            "${mod}+m" = "exec ${pkgs.i3lock}/bin/i3lock -n -c 000000";
          };
        };
    };
  };

  programs.git = {
    enable = false;
    userName = "KjMaas";
    userEmail = "klaasjan.maas@laposte.net";
    aliases = {
      st = "status";
    };
  };

  programs.bash = {
    enable = false;

  };
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
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.5.0";
          sha256 = "0za4aiwwrlawnia4f29msk822rj9bgcygw6a8a6iikiwzjjz0g91";
        };
      }
    ];

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "vi-mode" "z" ];
      theme = "robbyrussell-nixified";
    };

    initExtra = ''
      # enable nix commands
      . /home/klaasjan/.nix-profile/etc/profile.d/nix.sh

      # enable direnv hooks
      eval "$(direnv hook zsh)"
    '';
    envExtra = ''
      export PATH="$PATH:$HOME/.local/bin" # needed to use lvim
    '';
  };


  # services = {
  #   flameshot.enable = true;
  # };


  # theme-ing
  gtk = {
    enable = false;
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

{ pkgs, lib, ... }:
let
  nixvim = import (lib.fetchGit {
    url = "https://github.com/pta2002/nixvim";
  });
in
{
  imports = [
    nixvim.homeManagerModules.nixvim
  ];

  programs.nixvim = {
    enable = true;
    colorschemes.gruvbox.enable = true;
    plugins.lightline.enable = true;
  };
}

# nvim_configurable.customize {
#   name = "neovim";

#   vimrcConfig.customRC = ''
#     syntax enable
#     set number
#     set relativenumber
#     set mouse=a
#     set ignorecase
#     set pastetoggle=<F2>
#     set clipboard+=unnamedplus
#   '';

#   # Use the default plugin list shipped with nixpkgs
#   vimrcConfig.vam.knownPlugins = pkgs.vimPlugins;
#   vimrcConfig.vam.pluginDictionaries = [{
#     names = [
#       "vim-airline"
#     ];
#   }];

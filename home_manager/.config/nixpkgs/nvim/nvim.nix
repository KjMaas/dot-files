{ pkgs, config, ... }:

let
  baseConfig = {
    allowUnfree = true;
    cudaSupport = true;
  };
  unstable = import <nixpkgs-unstable> { config = baseConfig; };

in
{

  home.packages = with pkgs; [

      neuron-notes  # Future-proof system for plain-text notes
      neovim-remote # A tool that helps controlling nvim processes from a terminal

      # Language servers for neovim; change these to whatever languages you code in
      cargo         # Downloads your Rust project's dependencies and builds your project (used for LSP - nix server)
      # rnix-lsp
      unstable.sumneko-lua-language-server # Lua Language Server coded by Lua

      shellcheck              # Shell script analysis tool
      luajitPackages.luarocks # A package manager for Lua
      stylua                  # An opinionated Lua code formatter
      ];

  programs.neovim = {
    enable = true;

    withPython3 = true;
    withNodeJs = true;
    withRuby = true;
    # vimAlias = true;

    extraConfig = 
      ''
      lua dofile("init.lua")
      '';

    plugins = with pkgs.vimPlugins; [
      # neuron-nvim
    ];
  };

}

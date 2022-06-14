{ config, pkgs, lib, ... }:

let 
  #npm set prefix ~/.npm-global;

in {
  programs.neovim = {
    enable = true;
    #package = pkgs.neovim;
    vimAlias = true;
    #defaultEditor = true;
    withPython3 = true;
    withNodeJs = true;
    withRuby = true;
    plugins = with pkgs.vimPlugins; [ 
      # (nvim-treesitter.withPlugins (plugins: pkgs.tree-sitter.allGrammars))
      (nvim-treesitter.withPlugins (
        plugins: with plugins; [
          tree-sitter-c
          tree-sitter-cpp
          tree-sitter-dockerfile
          tree-sitter-fish
          tree-sitter-go
          tree-sitter-html
          tree-sitter-json
          tree-sitter-latex
          tree-sitter-lua
          tree-sitter-nix
          tree-sitter-python
          tree-sitter-r
          tree-sitter-regex
          tree-sitter-rust
          tree-sitter-toml
          tree-sitter-vim
          tree-sitter-yaml
        ]
        ))
       # coc-nvim
       # coc-pyright
       # coc-rust-analyzer
       # coc-clangd
        dracula-vim
        nord-nvim
        vim-nix
        vim-airline
        vim-fugitive
        vim-commentary
      ];
      extraPackages = with pkgs; [
        (python3.withPackages (ps: with ps; [
          black
          flake8
        ]))
      ];
      extraPython3Packages = (ps: with ps; [
        jedi
      ]);
      extraConfig = ''
        :let mapleader = "<space>"

        set mouse=a
        set number
        set relativenumber
        set ignorecase
        set pastetoggle=<F2>
        set clipboard+=unnamedplus

        colorscheme nord
        syntax off

        " treesitter
        lua << EOF
        require'nvim-treesitter.configs'.setup {
        highlight = {
          enable = true,
        }
        }
        EOF
      '';
    };
  }

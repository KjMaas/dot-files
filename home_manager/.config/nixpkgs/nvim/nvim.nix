{ pkgs, config, ... }:

{
environment.systemPackages = with pkgs; [
    (neovim.override {
        configure = {
            packages.myPlugins = with pkgs.vimPlugins; {
                start = [ nvim-cmp cmp-path cmp-nvim-lsp cmp-buffer ];

                opt = [
                # File tree
                nvim-web-devicons 
                nvim-tree-lua

                nvim-lspconfig nvim-treesitter

                # Languages
                vim-nix

                # Eyecandy 
		dracula-vim
		nord-nvim
                lualine-nvim
                bufferline-nvim
                nvim-colorizer-lua
                nvim-autopairs
                TrueZen-nvim
                toggleterm-nvim
                stabilize-nvim
                # Telescope
                telescope-nvim

                # Indent lines
                indent-blankline-nvim

            ];
        };
        customRC = ''
            let g:loaded_matchit           = 1
            let g:loaded_logiPat           = 1
            let g:loaded_rrhelper          = 1
            let g:loaded_tarPlugin         = 1
            " let g:loaded_man               = 1
            let g:loaded_gzip              = 1
            let g:loaded_zipPlugin         = 1
            let g:loaded_2html_plugin      = 1
            let g:loaded_shada_plugin      = 1
            let g:loaded_spellfile_plugin  = 1
            let g:loaded_netrw             = 1
            let g:loaded_netrwPlugin       = 1
            let g:loaded_tutor_mode_plugin = 1
            let g:loaded_remote_plugins    = 1

            lua dofile("/home/klaasjan/dot-files/home_manager/.config/nixpkgs/nvim/lua/settings.lua")
        '';
        };
    }
)];
}

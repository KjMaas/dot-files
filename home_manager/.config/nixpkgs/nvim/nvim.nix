{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    cargo       # Downloads your Rust project's dependencies and builds your project (used for LSP - nix server)
    neovim-remote # A tool that helps controlling nvim processes from a terminal

    # Language servers for neovim; change these to whatever languages you code in
    # Please note: if you remove any of these, make sure to also remove them from nvim/config/nvim/lua/lsp.lua!!
    rnix-lsp
    sumneko-lua-language-server

    (neovim.override {
      withPython3 = true;
      withNodeJs = true;
      withRuby = true;
      vimAlias = true;
      configure = {

        packages.myPlugins = with pkgs.vimPlugins; {
        };

        customRC = ''
        '';

      };
    })
  ];
}

with import <nixpkgs> {};

vim_configurable.customize {
  name = "vim";

  vimrcConfig.customRC = ''
    syntax enable
    set number
    set relativenumber
    set mouse=a
  '';

  # Use the default plugin list shipped with nixpkgs
  vimrcConfig.vam.knownPlugins = pkgs.vimPlugins;
  vimrcConfig.vam.pluginDictionaries = [ {
    names = [
        "vim-airline"
    ]; }
 ];
}

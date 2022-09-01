{ pkgs ? (import <nixpkgs> { }).pkgs }:

with pkgs;

let
  my-python = python310;
  python-with-packages = my-python.withPackages (p: with p; [
    pip
    setuptools
    x256 # Find the nearest xterm 256 color index for an RGB (note: used for nnn mustache file)
  ]);
in

mkShell {
  name = "hex2xterm256";

  buildInputs = [
    python-with-packages
  ];

  shellHook = ''
    # fixes libstdc++ issues and libgl.so issues
    LD_LIBRARY_PATH=${stdenv.cc.cc.lib}/lib/:/run/opengl-driver/lib/

    # NIX_ENFORCE_PURITY=0
    # bashInteractive

    export PIP_PREFIX=$(pwd)/_build/pip_packages
    export PYTHONPATH="$PIP_PREFIX/${pkgs.python3.sitePackages}:$PYTHONPATH"
    export PATH="$PIP_PREFIX/bin:$PATH"

    # pip install --upgrade pip
    # pip install excel2img

    # this is where lvim binary is stored
    export PATH="$PATH:$HOME/.local/bin"
    alias v="lvim"

  '';

}

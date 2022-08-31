{ pkgs ? (import <nixpkgs> { }).pkgs }:

with pkgs;

mkShell {
  buildInputs = [
    python310
    poetry
    dbeaver
  ];
  shellHook = ''
    # fixes libstdc++ issues and libgl.so issues
    LD_LIBRARY_PATH=${stdenv.cc.cc.lib}/lib/:/run/opengl-driver/lib/
  '';

}



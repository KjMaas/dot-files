{ pkgs ? import <nixpkgs> { } }:

let
  my-python = pkgs.python39;
  python-with-packages = my-python.withPackages (p: with p; [
    jupyterlab
    pip

    requests
    pandas
    matplotlib
  ]);
in
pkgs.mkShell {
  buildInputs = [
    python-with-packages
  ];
  shellHook = ''
    export PIP_PREFIX=$(pwd)/_build/pip_packages
    export PYTHONPATH="$PIP_PREFIX/${pkgs.python3.sitePackages}:$PYTHONPATH"
    export PATH="$PIP_PREFIX/bin:$PATH"
  '';

}

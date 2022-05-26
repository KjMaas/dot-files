{ pkgs ? import <nixpkgs> { } }:

let
  HOME = "/home/klaasjan";

in
pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    neovim

    python310
    python310Packages.pip
    python310Packages.setuptools

    nodejs
    nodePackages.npm

    cargo
  ];

  # Resolving EACCES permissions errors when installing packages globally
  shellHook = ''
    mkdir ${HOME}/.npm-global
    npm set prefix ${HOME}/.npm-global
    export PATH="${HOME}/.npm-global:$PATH"
  '';
}



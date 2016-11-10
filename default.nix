{ nixpkgs ? <nixpkgs>, system ? builtins.currentSystem }:

with import nixpkgs { inherit system; };

stdenv.mkDerivation {
  name = "nix-parse";
  src = ./.;
  buildInputs = [ nix boost ];
}

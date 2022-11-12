
let
  sources = import ./nix/sources.nix;
  pkgs = import sources.nixpkgs {};
in
with pkgs;
pkgs.mkShell {
    buildInputs = [
    python39Full
    python39Packages.PyLD
    python39Packages.pipx
    python39Packages.pytest
    python39Packages.pyhocon
    python39Packages.pyparsing
    python39Packages.sphinx
    python39Packages.tox
    ];
}


{ pkgs }:
pkgs.stdenv.mkDerivation {
  name = "odroid-h4-plus-nas-installer";
  src = ./.;
  phases = [
    "unpackPhase"
    "installPhase"
  ];
  installPhase = ''
    mkdir -p $out/bin
    cp $src/install.sh $out/bin/install.sh
  '';
}

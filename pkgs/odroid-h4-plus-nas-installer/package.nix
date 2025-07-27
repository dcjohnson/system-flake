{ pkgs }:
pkgs.stdenv.mkDerivation {
  name = "odroid-h4-plus-nas-installer";
  src = ./.;
  phases = [
    "unpackPhase"
    "installPhase"
  ];
  installPhase = ''
    mkdir -p $out
    cp $src/install.sh $out
  '';
}

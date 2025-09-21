{ pkgs }:
pkgs.stdenv.mkDerivation {
  name = "odroid-h4-ultra-schwab-installer";
  src = ./.;
  phases = [
    "unpackPhase"
    "installPhase"
  ];
  installPhase = ''
    mkdir -p $out/bin
    cp $src/install-odroid-os.sh $out/bin/.
  '';
}

{}:
pkgs.stdenv.mkDerivation {
  name = "database";
  src = ./.;
  phases = [ "unpackPhase" "installPhase" ];
  installPhase = ''
    mkdir -p $out
    cp $src/install.sh $out
  '';
};

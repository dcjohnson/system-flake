{ pkgs }:
let
  installerScriptPackage =
    { pkgs, name }:
    pkgs.stdenv.mkDerivation {
      inherit name;
      src = ./${name}/.;
      phases = [
        "unpackPhase"
        "installPhase"
      ];
      installPhase = ''
        mkdir -p $out/bin
        cp $src/install-odroid-os.sh $out/bin/.
      '';
    };
in
{
  odroid-h4-plus-nas-installer = installerScriptPackage {
    name = "odroid-h4-plus-nas-installer";
    inherit pkgs;
  };

  odroid-h4-ultra-schwab-installer = installerScriptPackage {
    name = "odroid-h4-ultra-schwab-installer";
    inherit pkgs;
  };

  odroid-h4-ultra-adguard-installer = installerScriptPackage {
    name = "odroid-h4-ultra-adguard-installer";
    inherit pkgs;
  };
}

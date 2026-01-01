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

  custom-sddm-astro-mountain_night_sky = import ./custom-sddm-astro-package/package.nix {
    inherit pkgs;
    wallpaperFile = ../wallpapers/mountain_night_sky-wallpaper-3840x1200.jpg;
  };
  custom-sddm-astro-mountain_range_with_snow_dark = import ./custom-sddm-astro-package/package.nix {
    inherit pkgs;
    wallpaperFile = ../wallpapers/a_mountain_range_with_snow_on_top.jpeg;
  };

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

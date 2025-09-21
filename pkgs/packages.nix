{ pkgs }:
{
  odroid-h4-plus-nas-installer = import ./odroid-h4-plus-nas-installer/package.nix {
    inherit pkgs;
  };

  odroid-h4-ultra-schwab-installer = import ./odroid-h4-ultra-schwab-installer/package.nix {
    inherit pkgs;
  };
}

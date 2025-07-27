{ pkgs }:
      {
        odroid-h4-plus-nas-installer = import pkgs/odroid-h4-plus-nas-installer/package.nix {
	inherit pkgs;
	};
      };

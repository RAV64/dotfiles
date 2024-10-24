{
  lib,
  inputs,
  ...
}:
{
  imports = [
    inputs.home-manager.darwinModules.home-manager
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "bak";

    users.miki = {
      programs.home-manager.enable = true;
      home = {
        stateVersion = "24.05";
        homeDirectory = lib.mkForce "/Users/miki";

        activation = {
          enableDirectSymlinks = inputs.home-manager.lib.hm.dag.entryAfter [ "environment" ] ''
            ~/dotfiles/scripts/symlink
          '';
        };
      };
    };

  };
}

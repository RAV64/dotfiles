{
  description = "Example Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
    }:
    let
      configuration =
        { pkgs, ... }:
        {
          nix.settings.experimental-features = "nix-command flakes";
          programs.fish.enable = true;
          security.pam.enableSudoTouchIdAuth = true;

          environment = {
            # List packages installed in system profile. To search by name, run:
            # $ nix-env -qaP | grep wget
            systemPackages = [
              pkgs.nixd
              pkgs.nixfmt-rfc-style
            ];
          };

          # Auto upgrade nix package and the daemon service.
          services.nix-daemon.enable = true;
          # nix.package = pkgs.nix;

          system = {
            # Set Git commit hash for darwin-version.
            configurationRevision = self.rev or self.dirtyRev or null;

            # $ darwin-rebuild changelog
            stateVersion = 5;

            defaults = {
              dock = {
                autohide = true;
                mru-spaces = false;
              };
              trackpad = {
                Clicking = true;
                TrackpadThreeFingerDrag = true;
              };
              NSGlobalDomain = {
                "com.apple.sound.beep.volume" = 0.0;
                InitialKeyRepeat = 13;
                KeyRepeat = 2;
              };
              finder = {
                AppleShowAllExtensions = true;
                AppleShowAllFiles = true;
                CreateDesktop = false;
                FXDefaultSearchScope = "SCcf";
                FXEnableExtensionChangeWarning = false;
                QuitMenuItem = true;
                ShowStatusBar = true;
              };
            };
          };
        };
    in
    {
      darwinConfigurations."Mikis-MacBook-Pro" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          configuration
          ./machines/darwin
        ];
      };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations."Mikis-MacBook-Pro".pkgs;
    };
}

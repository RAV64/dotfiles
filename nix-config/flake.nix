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
          nixpkgs.hostPlatform = "aarch64-darwin";
          nix.settings.experimental-features = "nix-command flakes";

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

          # Create /etc/zshrc that loads the nix-darwin environment.
          # programs.zsh.enable = true;  # default shell on catalina
          programs.fish.enable = true;

          # The platform the configuration will be used on.

          security.pam.enableSudoTouchIdAuth = true;

          system = {
            # Set Git commit hash for darwin-version.
            configurationRevision = self.rev or self.dirtyRev or null;

            # Used for backwards compatibility, please read the changelog before changing.
            # $ darwin-rebuild changelog
            stateVersion = 5;

            defaults = {
              dock = {
                autohide = true;
                mru-spaces = false;
              };
            };
          };
        };
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#Mikis-MacBook-Pro
      darwinConfigurations."Mikis-MacBook-Pro" = nix-darwin.lib.darwinSystem {
        modules = [
          configuration
          ./machines/darwin
        ];
      };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations."Mikis-MacBook-Pro".pkgs;
    };
}

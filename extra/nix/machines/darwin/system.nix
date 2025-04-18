{ pkgs, ... }:
{
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

  services = {
    # Auto upgrade nix package and the daemon service.
    nix-daemon.enable = true;
    activate-system.enable = true;
  };

  system = {
    # TODO how to get access to self?
    # Set Git commit hash for darwin-version.
    # configurationRevision = self.rev or self.dirtyRev or null;

    # $ darwin-rebuild changelog
    stateVersion = 5;

    # activationScripts are executed every time you boot the system or run
    # `nixos-rebuild` / `darwin-rebuild`.
    activationScripts.postUserActivation.text = ''
      # activateSettings -u will reload the settings from the database and
      # apply them to the current session, so we do not need to logout and
      # login again to make the changes take effect.
      /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
      # launchctl stop com.apple.Dock.agent
      # launchctl start com.apple.Dock.agent
    '';

    defaults = {
      dock = {
        autohide = true;
        mru-spaces = false;
      };
      trackpad = {
        Clicking = true;
        TrackpadThreeFingerDrag = false;
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
      CustomUserPreferences = {
        "com.apple.desktopservices" = {
          # Avoid creating .DS_Store files on network or USB volumes
          DSDontWriteNetworkStores = true;
          DSDontWriteUSBStores = true;
        };
      };
    };
  };
}

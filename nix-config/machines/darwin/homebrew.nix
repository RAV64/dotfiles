{
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };
    brewPrefix = "/opt/homebrew/bin";
    caskArgs = {
      no_quarantine = true;
    };
    taps = [
      "nikitabobko/tap"
    ];
    casks = [
      "aerospace"
      "bitwarden"
      "firefox-developer-edition"
      "font-monaspace-nerd-font"
      "hammerspoon"
      "obsidian"
      "wezterm@nightly"
    ];
  };
}

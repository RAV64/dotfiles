{
  launchd.user.agents = {
    "hammerspoon" = {
      serviceConfig = {
        ProgramArguments = [
          "open"
          "/Applications/Hammerspoon.app"
        ];
        RunAtLoad = true;
      };
    };

    "aerospace" = {
      serviceConfig = {
        ProgramArguments = [
          "/Applications/AeroSpace.app/Contents/MacOS/AeroSpace"
        ];
        RunAtLoad = true;
      };
    };
  };
}

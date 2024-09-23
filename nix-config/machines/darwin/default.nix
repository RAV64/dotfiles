{
  # https://hidutil-generator.netlify.app/
  launchd.user.agents."key-remap" = {

    # caps-lock - escape
    # fn - f18
    # right-cmd - f17
    # escape - mute
    serviceConfig = {
      ProgramArguments = [
        "/usr/bin/hidutil"
        "property"
        "--set"
        ''
          {"UserKeyMapping":[
            {
              "HIDKeyboardModifierMappingSrc": 0x700000039,
              "HIDKeyboardModifierMappingDst": 0x700000029
            },
            {
              "HIDKeyboardModifierMappingSrc": 0xFF00000003,
              "HIDKeyboardModifierMappingDst": 0x70000006D
            },
            {
              "HIDKeyboardModifierMappingSrc": 0x7000000E7,
              "HIDKeyboardModifierMappingDst": 0x70000006C
            },
            {
              "HIDKeyboardModifierMappingSrc": 0x700000029,
              "HIDKeyboardModifierMappingDst": 0xC000000E2
            }
          ]}
        ''
      ];
      RunAtLoad = true;
    };
  };
}

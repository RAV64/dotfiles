{
  imports = [
    # ./homebrew.nix
    ./key-remap.nix
    ./launch-agent.nix
    ./system.nix
  ];

  nix = {
    settings = {
      experimental-features = "nix-command flakes";
      max-jobs = "auto";
      trusted-users = [
        "miki"
        "root"
        "@admin"
      ];
    };
  };
}

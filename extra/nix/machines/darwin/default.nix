{ inputs, ... }:
{
  imports = [
    # ./homebrew.nix
    ./key-remap.nix
    ./launch-agent.nix
    ./system.nix
  ];

  nix = {
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
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

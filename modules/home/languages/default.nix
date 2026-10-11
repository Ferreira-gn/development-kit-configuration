{ pkgs, ... }:

{
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    git
    gcc
    python312
    poetry
  ];

  imports = [
    ./go/configs.nix
    ./java/configs.nix
    ./node/configs.nix
    ./rust/configs.nix
    ./lua/configs.nix
    ./nix/configs.nix
  ];
}

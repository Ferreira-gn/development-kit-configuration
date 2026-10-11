{ pkgs, ... }:

{
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    git
    gcc
    python312
    poetry
  ];
}

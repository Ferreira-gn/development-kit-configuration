{ pkgs, ... }:

{
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    scrcpy
    android-tools
    eas-cli
  ];
}

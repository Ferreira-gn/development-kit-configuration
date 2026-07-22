{ pkgs, ... }:

{
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    wlogout
    grim
    imagemagick
  ];

  
  xdg.configFile."wlogout".source = ../wlogout;
}

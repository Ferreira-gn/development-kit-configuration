{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;

  programs.noctalia = {
    enable = true;
  };


  home.packages = with pkgs; [
    # Pacotes necessários para rodar o hyprland
    hyprland
    waybar
    wofi
    rofi
    playerctl
    polkit
    quickshell

    # Ferramentas de captura de tela
    hyprshot
    satty

    # Ferramentas de gerenciamento de wallpaper
    awww
    hyprpaper

    # Ferramentas de lock screen
    hyprlock
    hypridle
  ];

  xdg.configFile."hypr".source = ../hypr-lua;
}  




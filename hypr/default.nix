{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;

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
    swww
    hyprpaper

    # Ferramentas de lock screen
    hyprlock
    hypridle
  ];

  # Salva os arquivos do modulo hypr em ~/.config/hypr/
  xdg.configFile."hypr".source = ../hypr;
}

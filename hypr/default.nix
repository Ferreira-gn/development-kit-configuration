{ config, pkgs, ... }:


{
  programs.home-manager.enable = true;
  
  home.packages = with pkgs; [
    # Pacotes necessários para rodar o hyprland 
    hyprland
    waybar
    wofi
    rofi
    hyprpaper
    hypridle
    hyprlock
    playerctl
    polkit
    quickshell
    
    # Ferramentas de captura de tela 
    hyprshot
    satty
  ];
  
  
  
  # Configura arquivos do Hyprland em ~/.config/hypr/
  xdg.configFile."hypr/hyprland.conf".source = ./hyprland.conf;
  xdg.configFile."hypr/general.conf".source = ./general.conf;
  xdg.configFile."hypr/input.conf".source = ./input.conf;
  xdg.configFile."hypr/keybinds.conf".source = ./keybinds.conf;
  xdg.configFile."hypr/decoration.conf".source = ./decoration.conf;
  xdg.configFile."hypr/colors.conf".source = ./colors.conf;
  xdg.configFile."hypr/misc.conf".source = ./misc.conf;
  
  
  # Configura os papeis de parede
  xdg.configFile."hypr/execs.conf".source = ./execs.conf;
  
  # Configura os executaveis ao rodar o hypr 
  xdg.configFile."hypr/hyprpaper.conf".source = ./hyprpaper.conf;
  
  xdg.configFile."hypr/scripts/start-shell.sh".source = ./scripts/start-shell.sh;
  
  #xdg.configFile."hypr/animations.conf".source = ./animations.conf;
  #xdg.configFile."hypr/gestures.conf".source = ./gestures.conf;
}

{ pkgs, ... }:

{
  home.username = "ferreira-gn";
  home.homeDirectory = "/home/ferreira-gn";
  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
  fonts.fontconfig.enable = true;
  

  # Pacotes básicos
  home.packages = with pkgs; [
    bibata-cursors

    # pacotes necessários para rodar em conjunto com o hypr
    jq
    qt6.qtbase
    qt6.qtdeclarative
    qt6.qtwayland
    qt6.qtsvg
    qt6.qtmultimedia
    qt6.qtimageformats
    qt6.qtshadertools
    kdePackages.layer-shell-qt
    
    # ferramentas de chacagem do sistema
    wev
    evtest
    brightnessctl
    
    
    # desenvolviemnto mobile
    scrcpy
    android-tools
    eas-cli
  ];

  # Cursor
  home.pointerCursor = {
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };


  # Módulos
  imports = [
    ./hypr/default.nix
    ./terminal/default.nix
  ];
  
  wayland.windowManager.hyprland.settings.exec-once = [
    "quickshell -p /home/ferreira-gn/Downloads/myFlake/quickshell-topbar"
  ];
}

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

    # ferramentas de chacagem do sistema
    wev
    evtest
    brightnessctl
    lsof
    unzip
    wl-clipboard

    # desenvolviemnto mobile
    scrcpy
    android-tools
    eas-cli

    # ferramenta de criação de diagramas
    drawio
    
    biome
    air
    
    # Pacotes de requisições GRPC do Golang
    protobuf
    protoc-gen-go
    protoc-gen-go-grpc
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
    ./quickshell/default.nix
    ./wlogout/default.nix
    ./rofi/default.nix
    ./dev/default.nix
  ];
}

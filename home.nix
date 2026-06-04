{ pkgs, ... }:

{
  home.username = "ferreira-gn";
  home.homeDirectory = "/home/ferreira-gn";
  home.stateVersion = "26.05";
  programs.home-manager.enable = true;
  fonts.fontconfig.enable = true;

  # Basic packages
  home.packages = with pkgs; [
    bibata-cursors

  ];

  # Cursor
  home.pointerCursor = {
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  home.file.".local/share/hypr/stubs".source = "${pkgs.hyprland}/share/hypr/stubs";

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

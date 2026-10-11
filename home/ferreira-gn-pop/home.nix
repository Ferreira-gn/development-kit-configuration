{ pkgs, username, ... }:

{
  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    firefox
    krita
    bibata-cursors
  ];

  imports = [
    ../ferreira-gn/terminal/default.nix
    ../ferreira-gn/dev/default.nix

    # Language module
    ../../modules/home/development/languages/default.nix

    # Terminal module
    ../../modules/home/development/terminal/default.nix
    
  ];
}

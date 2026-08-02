{ pkgs, inputs, username, ... }:

{
  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "26.05";
  programs.home-manager.enable = true;
  fonts.fontconfig.enable = true;

  # Basic packages
  home.packages = with pkgs; [
    bibata-cursors
    krita
    firefox
  ];

  # Cursor
  home.pointerCursor = {
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
    enable = true;
  };

  # modulo para facilitar o lsp do hypr-lua
  home.file.".local/share/hypr/stubs".source = "${pkgs.hyprland}/share/hypr/stubs";


  # Módulos
  imports = [
    inputs.noctalia.homeModules.default
    ../../modules/home/development/github-workflow.nix
    ./hypr-lua/default.nix
    ./terminal/default.nix
    ./quickshell/default.nix
    ./wlogout/default.nix
    ./rofi/default.nix
    ./dev/default.nix
  ];
}

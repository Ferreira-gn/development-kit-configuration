{ pkgs, ... }:

{
  programs.home-manager.enable = true;
  home.packages = with pkgs; [
    krita
    gparted
    bibata-cursors
    obsidian
    obs-studio
    vscode
    zed-editor
    jetbrains.idea-oss
    firefox
    # (brave.override {
    #   commandLineArgs = [
    #     "--enable-features=VaapiVideoDecoder,UseOzonePlatform"
    #     "--ozone-platform=wayland"
    #     "--ignore-gpu-blocklist"
    #   ];
    # })
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

}

{ pkgs, ... }:

{
  programs.home-manager.enable = true;
  
  home.packages = with pkgs; [
    bun
    yt-dlp 
    ffmpeg
    pstree
    flutter
    gradle
    libGL
    libGLU
];

  imports = [
    ./java/configs.nix
    ./go/configs.nix
    ./mobile/configs.nix
    ./nvim/configs.nix
    ./tools/configs.nix
  ];
}

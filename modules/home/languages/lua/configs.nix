{ pkgs, ... }:
{
  programs.home-manager.enable = true;
  home.packages = with pkgs; [
    lua
    lua-language-server
    stylua
  ];
}

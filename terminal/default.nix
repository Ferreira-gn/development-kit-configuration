{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;
  
  imports = [
    ./packages/packages.nix
    ./shell/fish.nix
    ./shell/zsh.nix
    ./shell/starship.nix
    ./term/kitty.nix
    ./term/utils.nix
  ];
}
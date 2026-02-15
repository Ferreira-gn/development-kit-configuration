{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;
  
  imports = [
    ./cli/packages.nix
    ./shell/fish.nix
    ./shell/zsh.nix
    ./shell/starship.nix
    ./term/kitty.nix
  ];
}
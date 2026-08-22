{ pkgs, ... }:

{
  programs.home-manager.enable = true;
  
  home.packages = with pkgs; [
    bun
  ];

  imports = [
    ./java/configs.nix
    ./go/configs.nix
    ./mobile/configs.nix
    ./nvim/configs.nix
    ./tools/configs.nix
  ];
}

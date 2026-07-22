{ config, pkgs, ... }:

let
  nvimConfig = "${config.home.homeDirectory}/dev/development-kit-configuration/dev/nvim/conf";
in
{
  programs.home-manager.enable = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  xdg.configFile."nvim".source = ./conf;
}

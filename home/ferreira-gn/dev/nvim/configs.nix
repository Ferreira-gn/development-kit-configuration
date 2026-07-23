{ config, lib, repositoryPath, ... }:

let
  nvimConfig = "${repositoryPath}/home/${config.home.username}/dev/nvim/conf";
in
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  # A configuração completa do Neovim será gerenciada
  # diretamente pelo diretório presente no repositório.
  xdg.configFile."nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink nvimConfig;
    recursive = false;
  };

  # Evita que programs.neovim tente criar um init.lua
  xdg.configFile."nvim/init.lua".enable = lib.mkForce false;
}

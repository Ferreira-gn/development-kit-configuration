{ ... }:

{
  programs.home-manager.enable = true;

  imports = [
    ./java/configs.nix
    ./nvim/configs.nix
    ./tools/configs.nix
  ];
}

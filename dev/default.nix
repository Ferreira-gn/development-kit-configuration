{ ... }:

{
  programs.home-manager.enable = true;

  programs.noctalia = {
    enable = true;
  };
  
  imports = [
    ./java/configs.nix
    ./go/configs.nix
    ./mobile/configs.nix
    ./nvim/configs.nix
    ./tools/configs.nix
  ];
}

{ pkgs, ... }:

{
  programs.home-manager.enable = true;
  home.packages = with pkgs; [
    nodejs_24
    typescript
    typescript-language-server
    prettier
    biome
    bun
  ];
}

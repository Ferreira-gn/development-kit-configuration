{ pkgs , ... }:

{
  home.packages = with pkgs;[
    bat 
    eza
    zoxide
    fzf
    fd
    btop
    
    nil # lsp of nix
    nixd # Another lsp of nix
    nerd-fonts.zed-mono
    nerd-fonts.jetbrains-mono
  ];
}
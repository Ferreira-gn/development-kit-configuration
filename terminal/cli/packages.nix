{ pkgs , ... }:

{
  home.packages = with pkgs;[
    bat 
    eza
    zoxide
    fzf
    btop
  ];
}
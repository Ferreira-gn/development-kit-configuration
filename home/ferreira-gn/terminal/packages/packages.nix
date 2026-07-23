{ pkgs , ... }:

{
  home.packages = with pkgs;[
    bat 
    eza
    zoxide
    fzf
    fd
    btop

    nerd-fonts.zed-mono
    nerd-fonts.jetbrains-mono

    # lsps
    # Nix
    nil
    nixd
    nixfmt-rfc-style
    statix

    # Java
    jdt-language-server
    lemminx

    # Python
    basedpyright
    ruff
  ];
}

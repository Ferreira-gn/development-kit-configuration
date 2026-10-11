{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # terms
    kitty
    rio
    alacritty

    # terminal tools
    bat
    eza
    zoxide
    fzf
    fd

    # dev terminal tools
    lazygit
    lazydocker
    gh # github cli
    codex # codex cli

    # tools to management system
    wev
    evtest
    brightnessctl
    lsof
    unzip
    unrar
    wl-clipboard
    btop
    curl
    wget

    # fonts
    nerd-fonts.zed-mono
    nerd-fonts.jetbrains-mono

    # lsps
    # Nix
    nil
    nixd
    nixfmt-rfc-style
    statix

    # Xml
    lemminx

    # Python
    basedpyright
    ruff

    # vscode lsp
    vscode-langservers-extracted
  ];
}

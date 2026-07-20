{ pkgs, ... }:

{
  programs.home-manager.enable = true;

  home.packages = with pkgs; [

    # tools to management system
    codex # codex cli
    wev
    evtest
    brightnessctl
    lsof
    unzip
    unrar
    wl-clipboard

    # Core CLI tools
    git
    gh # github cli
    curl
    wget
    unzip

    # tool for creation for diagrams
    drawio

    # Build essentials
    gcc
    gnumake

    # Telescope dependencies
    ripgrep
    fd

    # Clipboard integration
    wl-clipboard
    xclip

    # Node.js / TypeScript
    nodejs
    typescript
    typescript-language-server
    prettier
    biome

    # Lua / Neovim
    lua
    lua-language-server
    stylua

    # Nix development
    nil
    nixd

    # Go
    go
    gopls

    # Rust
    cargo
    rust-analyzer

    # Java / Spring
    jdt-language-server

    # Web development
    vscode-langservers-extracted

    # Docker
    docker
    docker-compose
    dockerfile-language-server

    # Treesitter
    tree-sitter

    # Git UI
    lazygit
  ];
}

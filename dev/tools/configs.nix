{ pkgs, ... }:

{
  programs.home-manager.enable = true;

  home.packages = with pkgs; [

    # Core CLI tools
    git
    curl
    wget
    unzip

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
    nodePackages.typescript-language-server
    nodePackages.prettier

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

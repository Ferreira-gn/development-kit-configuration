{ pkgs, ... }:

{
  programs.home-manager.enable = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  
  # pacotes e lsps de dependência 
  home.packages = with pkgs; [

    # Core
    ripgrep
    fd

    # Node / TS
    nodePackages.typescript-language-server
    nodePackages.prettier

    # Go
    gopls

    # Java / Spring
    jdt-language-server

    # Web
    vscode-langservers-extracted

    # Docker
    dockerfile-language-server

    # Nix
    nil
  ];
  
  
    xdg.configFile."nvim".source = ./conf;

}

{ username, ... }:

{
  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "26.05";
  programs.home-manager.enable = true;
  fonts.fontconfig.enable = true;

  imports = [
    ./userPrograms.nix

    # Language module
    ../../modules/home/development/languages/default.nix

    # Terminal module
    ../../modules/home/development/terminal/default.nix

    # Workflow module
    ../../modules/home/development/workflows/android-workflow.nix
    ../../modules/home/development/workflows/github-workflow.nix
    
    # Tools module
    ../../modules/home/tools/devTools/default.nix
    ../../modules/home/tools/mobileTools/default.nix

    # Language module
    ../../modules/home/development/nvim/default.nix
  ];
}

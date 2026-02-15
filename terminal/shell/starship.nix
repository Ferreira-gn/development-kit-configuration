{ config, pkgs, ... }:

{
  programs.starship = {
    enable = true;

    enableFishIntegration = true;
    enableZshIntegration = true;

    settings = {
      add_newline = false;

      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[✗](bold red)";
      };

      git_branch = {
        symbol = " ";
      };

      nodejs = {
        format = "via [⬢ $version](bold green) ";
      };
    };
  };
}

{ config, pkgs, ... }:

{
  programs.fish = {
    enable = true;

    shellAliases = {
      cat = "bat";
      ls = "eza --icons";
      la = "eza -la --icons";
      tree = "eza --tree";
      top = "btop";
    };

    interactiveShellInit = ''
        # zoxide init
        zoxide init fish | source
    
        # fzf (opcional)
        set -gx FZF_DEFAULT_COMMAND 'fd --type f'
    '';
  };
}
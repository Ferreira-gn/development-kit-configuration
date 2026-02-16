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
    
    
    functions = {
      # Finder de algum arquivo ou pasta -> redireciona para o diretório
      fzf_cd = ''
        set file (fd --type f 2>/dev/null | fzf)
        if test -n "$file"
          cd (dirname "$file")
          commandline -f repaint
        end
      '';
    }; 
  };
}
{ config, pkgs, ...}:

{
  programs.zsh = {
    enable = true;

    shellAliases = {
      cat = "bat";
      ls = "eza --icons";
      la = "eza -la --icons";
      tree = "eza --tree";
      top = "btop";
    };

    initExtra = ''
      # zoxide
      eval "$(zoxide init zsh)"

      # fzf
      export FZF_DEFAULT_COMMAND='fd --type f'
    '';
  };
}
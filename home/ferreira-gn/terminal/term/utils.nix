{ pkgs, ... }:

{
  home.packages = [
    # Pacotes nix criados para fornecer funcionalidades de busca superiores ao terminal do kitty 
    # Finder do histórico -> executa o comando selecionado
    (pkgs.writeShellScriptBin "fzf-history" ''
      cmd=$(history | fzf --height=100%)
      if [ -n "$cmd" ]; then
        eval "$cmd"
      fi
    '')

    # Finder de algum arquivo ou pasta -> abre o arquivo ou pasta
    (pkgs.writeShellScriptBin "fzf-open" ''
      file=$(fd --type f 2>/dev/null | fzf --height=100%)
      if [ -n "$file" ]; then
        zeditor "$file"
      fi
    '')
  ];
}

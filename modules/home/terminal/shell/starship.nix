{ ... }:

{
  programs.starship = {
    enable = true;

    enableFishIntegration = true;
    enableZshIntegration = true;

    settings = {
      add_newline = true;

      format = "$username$directory$git_branch$git_status$cmd_duration$line_break$character";

      right_format = "$nodejs $python $golang $docker_context $custom $java";

      cmd_duration = {
        min_time = 500; # milissegundos
        format = "[⏱ $duration]($style) ";
        style = "bold fg:#F38BA8";
      };

      username = {
        show_always = true;
        style_user = "bold fg:#ABABAB";
        format = "[$user]($style) ";
      };

      directory = {
        style = "bold fg:#D4D4D4";
        truncation_length = 6;
        truncate_to_repo = false;
        format = "[ $path]($style) ";
      };

      git_branch = {
        symbol = " ";
        style = "bold purple";
        format = "[$symbol$branch]($style) ";
      };

      git_status = {
        style = "bold red";
      };

      nodejs = {
        symbol = " ";
        style = "bold green";
        format = "[$symbol Node( $version )]($style)";
      };

      python = {
        symbol = " ";
        style = "bold yellow";
        format = "[$symbol($version )]($style)";
      };

      golang = {
        symbol = " ";
        style = "bold cyan";
        format = "[$symbol Go( $version )]($style)";
      };

      docker_context = {
        symbol = " ";
        style = "bold blue";
        format = "[$symbol$context]($style)";
      };

      custom = {
        nix = {
          symbol = " ";
          style = "bold fg:#7EB1D3";
          format = "[$symbol Nix]($style)";
          when = "ls *.nix >/dev/null 2>&1";
        };

        docker = {
          symbol = " ";
          style = "bold blue";
          format = "[$symbol Docker]($style)";
          detect_files = [
            "Dockerfile"
            "Dockerfile.*"
            "dockerfile"
            "docker-compose"
            "docker-compose.*"
          ];
        };
      };

      nix_shell = {
        disabled = true;
      };

      java = {
        symbol = " ";
        style = "bold orange";
        format = "[$symbol($version )]($style)";
      };

      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[✗](bold red)";
      };
    };

  };
}

{ inputs, pkgs,  ... }:

let
  system = pkgs.stdenv.hostPlatform.system;
  tuicrPackage = inputs.tuicr.packages.${system}.default;
in
{
  programs.gh.enable = true;

  home.packages = [
    pkgs.gh-dash
    tuicrPackage
  ];

  xdg.configFile."gh-dash/config.yml".text = ''
    prSections:
      - title: "Minhas pull requests"
        filters: "is:open author:@me"

      - title: "Reviews solicitadas"
        filters: "is:open review-requested:@me"

      - title: "Participando"
        filters: "is:open involves:@me -author:@me"

    issuesSections:
      - title: "Issues atribuídas"
        filters: "is:open assignee:@me"

      - title: "Issues criadas por mim"
        filters: "is:open author:@me"

    repoPaths:
      "SEU_USUARIO/*": ~/dev/*
      "SUA_ORGANIZACAO/*": ~/dev/sua-organizacao/*

    keybindings:
      prs:
        - key: R
          name: review with tuicr
          command: >
            cd {{.RepoPath}} && tuicr pr {{.PrNumber}}

    defaults:
      view: prs
      refetchIntervalMinutes: 5
      preview:
        open: true
        width: 84
      prsLimit: 30
      issuesLimit: 30

    showAuthorIcons: true
    smartFilteringAtLaunch: true
  '';

  xdg.configFile."tuicr/config.toml".text = ''
    theme = "catppuccin-mocha"
    diff_view = "side-by-side"

    mouse = true
    comment_vim = true
    cursor_line = true
    transparent_background = true
    scroll_offset = 5

    # A atualização do executável é controlada pelo flake.lock.
    no_update_check = true
  '';
}

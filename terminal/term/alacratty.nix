{...}:


{
  home.file.".config/alacritty/alacritty.toml".text = ''
    ########################
    # Configuração geral
    ########################

    [general]
    live_config_reload = true
    ipc_socket = true

    ########################
    # Terminal e shell
    ########################

    [terminal.shell]
    program = "fish"

    ########################
    # Janela
    ########################

    [window]
    opacity = 0.80
    blur = true
    decorations = "None"
    dynamic_padding = false
    padding = { x = 8, y = 8 }

    dynamic_title = true
    decorations_theme_variant = "Dark"

    class = {
      instance = "Alacritty",
      general = "Alacritty"
    }

    ########################
    # Fonte
    ########################

    [font]
    size = 11.0
    builtin_box_drawing = true

    normal = {
      family = "JetBrainsMono Nerd Font",
      style = "Regular"
    }

    bold = {
      family = "JetBrainsMono Nerd Font",
      style = "Bold"
    }

    italic = {
      family = "JetBrainsMono Nerd Font",
      style = "Italic"
    }

    bold_italic = {
      family = "JetBrainsMono Nerd Font",
      style = "Bold Italic"
    }

    offset = {
      x = 0,
      y = 0
    }

    glyph_offset = {
      x = 0,
      y = 0
    }

    ########################
    # Cursor
    ########################

    [cursor]
    blink_interval = 500
    blink_timeout = 0
    unfocused_hollow = true
    thickness = 0.15

    [cursor.style]
    shape = "Beam"
    blinking = "On"

    [cursor.vi_mode_style]
    shape = "Block"
    blinking = "Off"

    ########################
    # Mouse
    ########################

    [mouse]
    hide_when_typing = true

    ########################
    # Histórico e rolagem
    ########################

    [scrolling]
    history = 10000
    multiplier = 3

    ########################
    # Cores principais
    ########################

    [colors.primary]
    background = "#15141C"
    foreground = "#E0DEF4"
    dim_foreground = "#A09FAF"
    bright_foreground = "#FFFFFF"

    ########################
    # Seleção
    ########################

    [colors.selection]
    text = "#FFFFFF"
    background = "#403D52"

    ########################
    # Cursor
    ########################

    [colors.cursor]
    text = "#15141C"
    cursor = "#E0DEF4"

    [colors.vi_mode_cursor]
    text = "#15141C"
    cursor = "#78A9FF"

    ########################
    # Pesquisa
    ########################

    [colors.search.matches]
    foreground = "#15141C"
    background = "#F1C21B"

    [colors.search.focused_match]
    foreground = "#15141C"
    background = "#78A9FF"

    ########################
    # Hints e barra inferior
    ########################

    [colors.hints.start]
    foreground = "#15141C"
    background = "#F1C21B"

    [colors.hints.end]
    foreground = "#15141C"
    background = "#78A9FF"

    [colors.footer_bar]
    foreground = "#E0DEF4"
    background = "#403D52"

    ########################
    # Paleta ANSI normal
    ########################

    [colors.normal]
    black   = "#26242F"
    red     = "#EE5396"
    green   = "#42BE65"
    yellow  = "#F1C21B"
    blue    = "#4589FF"
    magenta = "#BE95FF"
    cyan    = "#08BDBA"
    white   = "#C6C6C6"

    ########################
    # Paleta ANSI brilhante
    ########################

    [colors.bright]
    black   = "#52505E"
    red     = "#FF7EB6"
    green   = "#6FDC8C"
    yellow  = "#FDDC69"
    blue    = "#78A9FF"
    magenta = "#D4BBFF"
    cyan    = "#3DDBD9"
    white   = "#FFFFFF"

    ########################
    # Paleta ANSI reduzida
    ########################

    [colors.dim]
    black   = "#1E1D27"
    red     = "#A93A70"
    green   = "#2D8346"
    yellow  = "#A68613"
    blue    = "#315EAD"
    magenta = "#8065AD"
    cyan    = "#087F7D"
    white   = "#888693"

    ########################
    # Bell
    ########################

    [bell]
    animation = "EaseOutExpo"
    duration = 0
    color = "#FF7EB6"

    ########################
    # Hints para URLs
    ########################

    [[hints.enabled]]
    hyperlinks = true
    post_processing = true
    persist = false
    command = "xdg-open"

    mouse = {
      enabled = true,
      mods = "None"
    }

    binding = {
      key = "O",
      mods = "Control|Shift"
    }

    ########################
    # Atalhos - Instâncias
    ########################

    # abre outra janela do Alacritty.
    [[keyboard.bindings]]
    key = "T"
    mods = "Control|Shift"
    action = "SpawnNewInstance"

    # Fecha a janela atual do Alacritty.
    [[keyboard.bindings]]
    key = "W"
    mods = "Control|Shift"
    action = "Quit"

    ########################
    # Atalhos - Área de transferência
    ########################

    [[keyboard.bindings]]
    key = "C"
    mods = "Control|Shift"
    action = "Copy"

    [[keyboard.bindings]]
    key = "V"
    mods = "Control|Shift"
    action = "Paste"

    ########################
    # Atalhos - Pesquisa
    ########################

    [[keyboard.bindings]]
    key = "F"
    mods = "Control|Shift"
    action = "SearchForward"

    [[keyboard.bindings]]
    key = "B"
    mods = "Control|Shift"
    action = "SearchBackward"

    ########################
    # Atalhos - Comandos FZF
    ########################

    [[keyboard.bindings]]
    key = "F"
    mods = "Control|Alt"
    chars = "fzf_cd"

    [[keyboard.bindings]]
    key = "H"
    mods = "Control|Shift"
    command = {
      program = "fish",
      args = ["-c", "fzf-history"]
    }

    [[keyboard.bindings]]
    key = "O"
    mods = "Control|Alt"
    command = {
      program = "fish",
      args = ["-c", "fzf-open"]
    }

    ########################
    # Atalhos - Rolagem
    ########################

    [[keyboard.bindings]]
    key = "PageUp"
    action = "ScrollPageUp"

    [[keyboard.bindings]]
    key = "PageDown"
    action = "ScrollPageDown"

    [[keyboard.bindings]]
    key = "Home"
    mods = "Control|Shift"
    action = "ScrollToTop"

    [[keyboard.bindings]]
    key = "End"
    mods = "Control|Shift"
    action = "ScrollToBottom"

    ########################
    # Atalhos - Fonte
    ########################

    [[keyboard.bindings]]
    key = "+"
    mods = "Control"
    action = "IncreaseFontSize"

    [[keyboard.bindings]]
    key = "="
    mods = "Control"
    action = "IncreaseFontSize"

    [[keyboard.bindings]]
    key = "NumpadAdd"
    mods = "Control"
    action = "IncreaseFontSize"

    [[keyboard.bindings]]
    key = "-"
    mods = "Control"
    action = "DecreaseFontSize"

    [[keyboard.bindings]]
    key = "NumpadSubtract"
    mods = "Control"
    action = "DecreaseFontSize"

    [[keyboard.bindings]]
    key = "0"
    mods = "Control"
    action = "ResetFontSize"

    [[keyboard.bindings]]
    key = "Numpad0"
    mods = "Control"
    action = "ResetFontSize"

    ########################
    # Atalhos - Modo Vi
    ########################

    [[keyboard.bindings]]
    key = "Space"
    mods = "Control|Shift"
    action = "ToggleViMode"
  '';
}


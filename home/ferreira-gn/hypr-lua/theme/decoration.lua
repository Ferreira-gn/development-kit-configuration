hl.config({
    general = {
        gaps_in  = 4,
        gaps_out = 6,

        border_size = 0,

        col = {
            active_border   = "rgba(F7AADE39)",
            inactive_border = "rgba(A58A8D30)",
        },

        -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = true,

        -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
        allow_tearing = false,

        layout = "dwindle",
    },


    decoration = {
        rounding       = 12,
        rounding_power = 2.4,

        -- Change transparency of focused and unfocused windows
        active_opacity   = 1.0,
        inactive_opacity = 0.98,

        shadow = {
            enabled      = true,
            range        = 50,
            render_power = 10,
            color        = "rgba(00000027)",
        },

        blur = {
            enabled   = true,
            size      = 3,
            passes = 2,
            vibrancy = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },

    misc = {
        force_default_wallpaper = -1,    -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo   = false, -- If true disables the random hyprland logo / anime girl background. :(
    },

})


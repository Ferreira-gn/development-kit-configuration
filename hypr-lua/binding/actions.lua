local terminal = "kitty"
local secondaryTerminal = "alacrati"
local ide = "zeditor"
local browser = "brave"
local launcherCmd = "sh -c ~/.config/rofi/launchers/type-6/launcher.sh"
local walpaperCmd = "sh -c ~/.config/hypr/scripts/switch-wallpaper.sh"
local screenShotCmd = [[sh -c 'hyprshot -m region --freeze --raw | satty -f - --output-filename "/home/ferreira-gn/Images/ScreenShots/screenshot-$(date +%Y-%m-%d_%H-%M-%S).png"']]
local wlogout = [[sh -c '~/.config/hypr/scripts/run-wlogout.sh']]

-- essential apps
hl.bind("SUPER + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind("SUPER + T", hl.dsp.exec_cmd(secondaryTerminal))
hl.bind("SUPER + Z", hl.dsp.exec_cmd(ide))
hl.bind("SUPER + W", hl.dsp.exec_cmd(browser))

-- close app
hl.bind("SUPER + Q", hl.dsp.window.close())

-- launcher
hl.bind("SUPER + K", hl.dsp.exec_cmd(launcherCmd))

-- screenshoot
hl.bind("PRINT", hl.dsp.exec_cmd(screenShotCmd))


-- lockscreen and waylogout
hl.bind("SUPER + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind("SUPER + D", hl.dsp.exec_cmd(wlogout))

-- walpaper switch
hl.bind("SUPER + SHIFT + W", hl.dsp.exec_cmd(walpaperCmd))



-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

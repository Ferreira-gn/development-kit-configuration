hl.on("hyprland.start", function()
  hl.exec_cmd("hypridle & awww-daemon ")
  hl.exec_cmd("noctalia")

  --hl.exec_cmd([[ ~/.config/hypr/scripts/start-wallpaper.sh]])
end)

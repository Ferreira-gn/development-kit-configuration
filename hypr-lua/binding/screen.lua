
-- Menagement screens
hl.bind("SUPER + F", hl.dsp.window.fullscreen())
hl.bind("SUPER + SPACE", hl.dsp.window.float())
hl.bind("SUPER + P", hl.dsp.window.pseudo())

-- Focus between screens
hl.bind("SUPER + ALT + LEFT", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + ALT + RIGHT", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + ALT + UP", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + ALT + DOWN", hl.dsp.focus({ direction = "down" }))


-- Navigate between workspaces
hl.bind("SUPER + LEFT", hl.dsp.focus({ workspace = "-1" }))
hl.bind("SUPER + RIGHT", hl.dsp.focus({ workspace = "+1" }))


--Move screens between workspaces
hl.bind("SUPER + SHIFT + LEFT", hl.dsp.window.move({ direction = "left" }))
hl.bind("SUPER + SHIFT + RIGHT", hl.dsp.window.move({ direction = "right" }))
hl.bind("SUPER + SHIFT + UP", hl.dsp.window.move({ direction = "up" }))
hl.bind("SUPER + SHIFT + DOWN", hl.dsp.window.move({ direction = "down" }))


-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for workspace = 1, 10 do
    local key = workspace % 10 -- 10 maps to key 0
    hl.bind("SUPER + " .. key, hl.dsp.focus({ workspace = workspace}))
    hl.bind("SUPER + SHIFT + " .. key,hl.dsp.window.move({ workspace = workspace }))
end


-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })



-- Gesture -
hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})


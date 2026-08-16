local keyboard = libs.keyboard

-- Playback
actions.play_pause = function()
    keyboard.stroke("space")
end

actions.stop = function()
    keyboard.stroke("q")
end

-- File Navigation
actions.prev_file = function()
    keyboard.stroke("shift", ",")
end

actions.next_file = function()
    keyboard.stroke("shift", ".")
end

-- Chapter Navigation
actions.prev_chapter = function()
    keyboard.stroke("pageup")
end

actions.next_chapter = function()
    keyboard.stroke("pagedown")
end

-- MPV Volume
actions.volume_up = function()
    keyboard.press("volumeup");
end

actions.volume_down = function()
    keyboard.press("volumedown");
end

actions.mute = function()
    keyboard.press("volumemute");
end

-- System Volume via phone volume buttons
actions.volume_up_key = function()
    volume.up()
end

actions.volume_down_key = function()
    volume.down()
end

-- Fullscreen and Shader
actions.fullscreen = function()
    keyboard.stroke("f")
end

actions.toggle_shader = function()
    keyboard.stroke("g")
end

-- Seek
actions.seek_back_5 = function()
    keyboard.stroke("left")
end

actions.seek_forward_5 = function()
    keyboard.stroke("right")
end

actions.seek_back_60 = function()
    keyboard.stroke("down")
end

actions.seek_forward_60 = function()
    keyboard.stroke("up")
end

actions.cycle_sub = function()
    keyboard.stroke("s")
end

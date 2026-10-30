local keyboard = libs.keyboard;

-- Playback

--@help Toggle play / pause
actions.play_pause = function ()
    keyboard.stroke("space");
end

--@help Stop playback
actions.stop = function ()
    keyboard.stroke("q");
end

-- File Navigation

--@help Previous playlist item
actions.prev_file = function ()
    keyboard.stroke("shift", ",");
end

--@help Next playlist item
actions.next_file = function ()
    keyboard.stroke("shift", ".");
end

-- Chapter Navigation

--@help Previous chapter
actions.prev_chapter = function ()
    keyboard.stroke("pageup");
end

--@help Next chapter
actions.next_chapter = function ()
    keyboard.stroke("pagedown");
end

-- MPV Volume

--@help Increase volume
actions.volume_up = function ()
    keyboard.press("volumeup");
end

--@help Decrease volume
actions.volume_down = function ()
    keyboard.press("volumedown");
end

--@help Toggle mute
actions.mute = function ()
    keyboard.press("volumemute");
end

-- System Volume via phone volume buttons

--@help Increase volume (hardware key)
actions.volume_up_key = function ()
    keyboard.press("volumeup");
end

--@help Decrease volume (hardware key)
actions.volume_down_key = function ()
    keyboard.press("volumedown");
end

-- Fullscreen and Shader

--@help Toggle fullscreen
actions.fullscreen = function ()
    keyboard.stroke("f");
end

--@help Toggle custom shader
actions.toggle_shader = function ()
    keyboard.stroke("g");
end

-- Seek

--@help Seek backward 5 seconds
actions.seek_back_5 = function ()
    keyboard.stroke("left");
end

--@help Seek forward 5 seconds
actions.seek_forward_5 = function ()
    keyboard.stroke("right");
end

--@help Seek backward 60 seconds (down)
actions.seek_back_60 = function ()
    keyboard.stroke("down");
end

--@help Seek forward 60 seconds (up)
actions.seek_forward_60 = function ()
    keyboard.stroke("up");
end

-- Subtitles

--@help Cycle subtitle track
actions.cycle_sub = function ()
    keyboard.stroke("s");
end

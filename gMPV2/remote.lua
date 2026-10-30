local keyboard = libs.keyboard
local win = libs.win
local device = libs.device
local server = libs.server
local timer = libs.timer

-- Helper for haptic touch feedback
local function feedback()
    pcall(function() device.vibrate() end)
end

-------------------------------------------------------------------------------
-- Tab 1: Playback Actions
-------------------------------------------------------------------------------

--@help Toggle playback between play and pause
actions.play_pause = function()
    feedback()
    keyboard.stroke("space")
end

--@help Stop playback
actions.stop = function()
    feedback()
    keyboard.press("mediastop")
    keyboard.stroke("escape")
    keyboard.stroke("q")
end

--@help Toggle fullscreen mode
actions.fullscreen = function()
    feedback()
    keyboard.stroke("enter")
end

--@help Previous item in playlist
actions.prev_file = function()
    feedback()
    keyboard.stroke("shift", ",")
end

--@help Next item in playlist
actions.next_file = function()
    feedback()
    keyboard.stroke("shift", ".")
end

--@help Previous chapter (PGDWN: add chapter -1 per input.conf)
actions.prev_chapter = function()
    feedback()
    keyboard.stroke("pagedown")
end

--@help Next chapter (PGUP: add chapter 1 per input.conf)
actions.next_chapter = function()
    feedback()
    keyboard.stroke("pageup")
end

--@help Lower master volume
actions.vol_down = function()
    keyboard.press("volumedown")
end

--@help Raise master volume
actions.vol_up = function()
    keyboard.press("volumeup")
end

--@help Toggle master mute
actions.mute = function()
    feedback()
    keyboard.press("volumemute")
end

--@help Seek backward 30 seconds (Down arrow)
actions.seek_back_30 = function()
    feedback()
    keyboard.stroke("down")
end

--@help Seek backward 5 seconds (Left arrow)
actions.seek_back_5 = function()
    feedback()
    keyboard.stroke("left")
end

--@help Seek forward 5 seconds (Right arrow)
actions.seek_forward_5 = function()
    feedback()
    keyboard.stroke("right")
end

--@help Seek forward 30 seconds (Up arrow)
actions.seek_forward_30 = function()
    feedback()
    keyboard.stroke("up")
end

--@help Seek backward 5 minutes (Ctrl+Left)
actions.seek_back_300 = function()
    feedback()
    keyboard.stroke("ctrl", "left")
end

--@help Seek forward 5 minutes (Ctrl+Right)
actions.seek_forward_300 = function()
    feedback()
    keyboard.stroke("ctrl", "right")
end

-------------------------------------------------------------------------------
-- Tab 2: Audio & Subtitle Actions
-------------------------------------------------------------------------------

--@help Cycle to next audio track (KP7 per input.conf)
actions.cycle_audio = function()
    feedback()
    keyboard.stroke("num7")
    pcall(function() device.toast("Cycled audio track") end)
end

--@help Cycle to next subtitle track (s per input.conf)
actions.cycle_sub = function()
    feedback()
    keyboard.stroke("s")
    pcall(function() device.toast("Cycled subtitle track") end)
end

--@help Toggle subtitle visibility on or off (v per input.conf)
actions.toggle_sub_visibility = function()
    feedback()
    keyboard.stroke("v")
    pcall(function() device.toast("Toggled subtitle visibility") end)
end

--@help Decrease audio delay by 0.1s (KP9 per input.conf)
actions.audio_delay_down = function()
    feedback()
    keyboard.stroke("num9")
    pcall(function() device.toast("Audio delay -0.1s") end)
end

--@help Increase audio delay by 0.1s (KP6 per input.conf)
actions.audio_delay_up = function()
    feedback()
    keyboard.stroke("num6")
    pcall(function() device.toast("Audio delay +0.1s") end)
end

--@help Decrease subtitle delay by 0.1s (z per input.conf)
actions.sub_delay_down = function()
    feedback()
    keyboard.stroke("z")
    pcall(function() device.toast("Sub delay -0.1s") end)
end

--@help Increase subtitle delay by 0.1s (Shift+Z per input.conf)
actions.sub_delay_up = function()
    feedback()
    keyboard.stroke("shift", "z")
    pcall(function() device.toast("Sub delay +0.1s") end)
end

--@help Move subtitle position up (r per input.conf)
actions.sub_pos_up = function()
    feedback()
    keyboard.stroke("r")
    pcall(function() device.toast("Sub position up") end)
end

--@help Move subtitle position down (Shift+R per input.conf)
actions.sub_pos_down = function()
    feedback()
    keyboard.stroke("shift", "r")
    pcall(function() device.toast("Sub position down") end)
end

-------------------------------------------------------------------------------
-- Tab 3: Video & Playback Speed Actions
-------------------------------------------------------------------------------

--@help Set playback speed to half 0.5x ({ per input.conf)
actions.speed_half = function()
    feedback()
    keyboard.stroke("shift", "[")
    pcall(function() device.toast("Speed: 0.5x") end)
end

--@help Decrease playback speed by 10% ([ per input.conf)
actions.speed_down = function()
    feedback()
    keyboard.stroke("[")
    pcall(function() device.toast("Speed: -10%") end)
end

--@help Reset playback speed to 1.0x (Backspace per input.conf)
actions.speed_reset = function()
    feedback()
    keyboard.stroke("backspace")
    pcall(function() device.toast("Speed: 1.0x") end)
end

--@help Increase playback speed by 10% (] per input.conf)
actions.speed_up = function()
    feedback()
    keyboard.stroke("]")
    pcall(function() device.toast("Speed: +10%") end)
end

--@help Set playback speed to double 2.0x (} per input.conf)
actions.speed_double = function()
    feedback()
    keyboard.stroke("shift", "]")
    pcall(function() device.toast("Speed: 2.0x") end)
end

--@help Cycle video aspect ratio (a per input.conf)
actions.cycle_aspect = function()
    feedback()
    keyboard.stroke("a")
    pcall(function() device.toast("Cycled aspect ratio") end)
end

--@help Toggle video deinterlacing (d per input.conf)
actions.toggle_deinterlace = function()
    feedback()
    keyboard.stroke("d")
    pcall(function() device.toast("Toggled deinterlace") end)
end

--@help Take screenshot (Ctrl+S per input.conf)
actions.screenshot = function()
    feedback()
    keyboard.stroke("ctrl", "s")
    pcall(function() device.toast("Screenshot saved") end)
end

--@help Display playback statistics overlay (t per input.conf)
actions.show_stats = function()
    feedback()
    keyboard.stroke("t")
end

--@help Display file and stream info (i per input.conf)
actions.show_info = function()
    feedback()
    keyboard.stroke("i")
end

-------------------------------------------------------------------------------
-- Tab 4: Tools & Advanced OSD Actions
-------------------------------------------------------------------------------

--@help Focus MPV.NET player desktop window
actions.focus_mpv = function()
    feedback()
    local ok = pcall(function() win.switchtowait("mpvnet.exe") end)
    if not ok then
        pcall(function() win.switchto("mpvnet") end)
    end
    pcall(function() device.toast("Focused MPV window") end)
end

--@help Toggle or set A-B loop points (l per input.conf)
actions.ab_loop = function()
    feedback()
    keyboard.stroke("l")
    pcall(function() device.toast("A-B Loop set/cleared") end)
end

--@help Toggle infinite file looping (Shift+L per input.conf)
actions.loop_file = function()
    feedback()
    keyboard.stroke("shift", "l")
    pcall(function() device.toast("Toggled infinite loop") end)
end

--@help Step backward one video frame (, per input.conf)
actions.frame_back_step = function()
    feedback()
    keyboard.stroke(",")
end

--@help Step forward one video frame (. per input.conf)
actions.frame_step = function()
    feedback()
    keyboard.stroke(".")
end

--@help Open dialog to enter video or stream URL
actions.prompt_url = function()
    feedback()
    server.update({
        type = "input",
        title = "Open URL in MPV",
        message = "Enter video or stream URL:",
        ontap = "open_url"
    })
end

--@help Apply submitted URL and stream in MPV
--@param url:string Video or stream URL
actions.open_url = function(url)
    if url and #url > 0 then
        feedback()
        pcall(function() win.switchtowait("mpvnet.exe") end)
        keyboard.stroke("u")
        timer.timeout(function()
            keyboard.text(url)
            timer.timeout(function()
                keyboard.stroke("enter")
            end, 200)
        end, 300)
        pcall(function() device.toast("Loading URL in MPV...") end)
    end
end

local script = libs.script
local timer = libs.timer
local device = libs.device
local server = libs.server

-- Optional LuaJIT FFI for native Windows power calls
local ffi_ok, ffi = pcall(require, "ffi")
local PowrProf, user32
if ffi_ok and ffi then
    pcall(function()
        ffi.cdef[[
            bool LockWorkStation();
            bool SetSuspendState(bool hibernate, bool forceCritical, bool disableWakeEvent);
        ]]
        PowrProf = ffi.load("PowrProf")
        user32 = ffi.load("user32")
    end)
end

-- Active countdown state
local active_timer_id = nil
local total_seconds = 0
local remaining_seconds = 0

-- Helper to format seconds as human-readable string
local function format_time(secs)
    local h = math.floor(secs / 3600)
    local m = math.floor((secs % 3600) / 60)
    local s = secs % 60
    if h > 0 then
        return string.format("Shutting down in %dh %02dm %02ds", h, m, s)
    else
        return string.format("Shutting down in %02dm %02ds", m, s)
    end
end

-- Helper for haptic touch feedback
local function feedback()
    pcall(function() device.vibrate() end)
end

-- Core timer start and interval loop
local function start_timer(seconds)
    if active_timer_id then
        pcall(function() timer.cancel(active_timer_id) end)
        active_timer_id = nil
    end

    total_seconds = seconds
    remaining_seconds = seconds

    -- Clean collision avoidance
    script.default("shutdown -a")
    script.default("shutdown -s -t " .. seconds)

    -- Update UI immediately
    if layout and layout.countdown_lbl then
        layout.countdown_lbl.text = format_time(remaining_seconds)
        layout.countdown_lbl.color = "#00E676"
    end
    if layout and layout.progress_slider then
        layout.progress_slider.progress = 100
    end

    feedback()
    pcall(function()
        local mins = math.floor(seconds / 60)
        device.toast(string.format("Shutdown set for %d min", mins))
    end)

    -- Interval loop ticking every 1000ms
    active_timer_id = timer.interval(function()
        remaining_seconds = remaining_seconds - 1
        if remaining_seconds <= 0 then
            pcall(function() timer.cancel(active_timer_id) end)
            active_timer_id = nil
            if layout and layout.countdown_lbl then
                layout.countdown_lbl.text = "Timer expired"
                layout.countdown_lbl.color = "#FF5252"
            end
            if layout and layout.progress_slider then
                layout.progress_slider.progress = 0
            end
            return
        end

        if layout and layout.countdown_lbl then
            layout.countdown_lbl.text = format_time(remaining_seconds)
        end
        if layout and layout.progress_slider and total_seconds > 0 then
            local pct = math.floor((remaining_seconds / total_seconds) * 100)
            layout.progress_slider.progress = pct
        end
    end, 1000)
end

-- Core delta adjustment logic
local function adjust_timer(delta_seconds)
    if remaining_seconds > 0 then
        local new_remaining = remaining_seconds + delta_seconds
        if new_remaining < 10 then
            new_remaining = 10
        end
        remaining_seconds = new_remaining
        if remaining_seconds > total_seconds then
            total_seconds = remaining_seconds
        end

        script.default("shutdown -a")
        script.default("shutdown -s -t " .. remaining_seconds)

        if layout and layout.countdown_lbl then
            layout.countdown_lbl.text = format_time(remaining_seconds)
        end
        if layout and layout.progress_slider and total_seconds > 0 then
            layout.progress_slider.progress = math.floor((remaining_seconds / total_seconds) * 100)
        end

        feedback()
        pcall(function()
            device.toast(string.format("Adjusted: %d min remaining", math.floor(remaining_seconds / 60)))
        end)
    else
        if delta_seconds > 0 then
            start_timer(delta_seconds)
        else
            pcall(function() device.toast("No active timer to adjust") end)
        end
    end
end

-------------------------------------------------------------------------------
-- Preset Countdown Actions
-------------------------------------------------------------------------------

--@help Schedule shutdown in 15 minutes
actions.timer_15m = function()
    start_timer(900)
end

--@help Schedule shutdown in 30 minutes
actions.timer_30m = function()
    start_timer(1800)
end

--@help Schedule shutdown in 45 minutes
actions.timer_45m = function()
    start_timer(2700)
end

--@help Schedule shutdown in 1 hour
actions.timer_1h = function()
    start_timer(3600)
end

--@help Schedule shutdown in 2 hours
actions.timer_2h = function()
    start_timer(7200)
end

--@help Schedule shutdown in 3 hours
actions.timer_3h = function()
    start_timer(10800)
end

-------------------------------------------------------------------------------
-- Incremental Adjustments & Custom Input Dialog
-------------------------------------------------------------------------------

--@help Subtract 5 minutes from active countdown
actions.sub_5m = function()
    adjust_timer(-300)
end

--@help Add 5 minutes to active countdown
actions.add_5m = function()
    adjust_timer(300)
end

--@help Add 15 minutes to active countdown
actions.add_15m = function()
    adjust_timer(900)
end

--@help Open dialog to enter custom shutdown duration
actions.prompt_custom = function()
    feedback()
    server.update({
        type = "input",
        title = "Set Shutdown Timer",
        message = "Enter duration in minutes:",
        text = "45",
        ontap = "set_custom"
    })
end

--@help Apply custom minutes from input dialog
--@param text:string Duration in minutes
actions.set_custom = function(text)
    local mins = tonumber(text)
    if mins and mins > 0 and mins <= 1440 and mins == mins then
        start_timer(math.floor(mins * 60))
        pcall(function() device.toast("Custom timer set for " .. math.floor(mins) .. " min") end)
    else
        pcall(function() libs.device.toast("Please enter a valid duration (1-1440 min)") end)
    end
end

-------------------------------------------------------------------------------
-- Power & System Actions
--@help Suspend computer to sleep immediately
-------------------------------------------------------------------------------
actions.sleep_now = function()
    feedback()
    pcall(function() device.toast("Putting computer to sleep...") end)
    if PowrProf then
        PowrProf.SetSuspendState(false, true, false)
    else
        script.default("rundll32.exe powrprof.dll,SetSuspendState 0,1,0")
    end
end

--@help Hibernate computer immediately
actions.hibernate_now = function()
    feedback()
    pcall(function() device.toast("Hibernating computer...") end)
    if PowrProf then
        PowrProf.SetSuspendState(true, true, false)
    else
        script.default("shutdown -h")
    end
end

--@help Restart computer immediately
actions.restart_now = function()
    feedback()
    pcall(function() device.toast("Restarting computer...") end)
    script.default("shutdown -a")
    script.default("shutdown -r -t 0")
end

--@help Lock Windows workstation
actions.lock_workstation = function()
    feedback()
    pcall(function() device.toast("Locking workstation...") end)
    if user32 then
        user32.LockWorkStation()
    else
        script.default("rundll32.exe user32.dll,LockWorkStation")
    end
end

--@help Cancel active shutdown timer and reset status
actions.abort = function()
    if active_timer_id then
        pcall(function() timer.cancel(active_timer_id) end)
        active_timer_id = nil
    end
    total_seconds = 0
    remaining_seconds = 0
    script.default("shutdown -a")

    if layout and layout.countdown_lbl then
        layout.countdown_lbl.text = "No timer active"
        layout.countdown_lbl.color = "#888888"
    end
    if layout and layout.progress_slider then
        layout.progress_slider.progress = 0
    end

    feedback()
    pcall(function() device.toast("Shutdown timer cancelled") end)
end

-------------------------------------------------------------------------------
-- Lifecycle Events
-------------------------------------------------------------------------------
events.destroy = function()
    if active_timer_id then
        pcall(function() timer.cancel(active_timer_id) end)
        active_timer_id = nil
    end
end

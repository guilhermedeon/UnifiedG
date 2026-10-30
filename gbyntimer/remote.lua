local script = libs.script

local function schedule_shutdown(seconds)
    script.default("shutdown -a")
    script.default("shutdown -s -t " .. seconds)
end

--@help Shutdown computer in 10 minutes
actions.tenm = function()
    schedule_shutdown(600)
end

--@help Shutdown computer in 20 minutes
actions.twentym = function()
    schedule_shutdown(1200)
end

--@help Shutdown computer in 30 minutes
actions.thirtym = function()
    schedule_shutdown(1800)
end

--@help Shutdown computer in 1 hour
actions.oneh = function()
    schedule_shutdown(3600)
end

--@help Shutdown computer in 1 hour 30 minutes
actions.onehm = function()
    schedule_shutdown(5400)
end

--@help Shutdown computer in 2 hours
actions.twoh = function()
    schedule_shutdown(7200)
end

--@help Shutdown computer in 2 hours 30 minutes
actions.twohm = function()
    schedule_shutdown(9000)
end

--@help Shutdown computer in 3 hours
actions.threeh = function()
    schedule_shutdown(10800)
end

--@help Shutdown computer in 3 hours 30 minutes
actions.threehm = function()
    schedule_shutdown(12600)
end

--@help Shutdown computer in 4 hours
actions.fourh = function()
    schedule_shutdown(14400)
end

--@help Shutdown computer in 4 hours 30 minutes
actions.fourhm = function()
    schedule_shutdown(16200)
end

--@help Abort scheduled shutdown
actions.abort = function()
    script.default("shutdown -a")
end


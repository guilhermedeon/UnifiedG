local script = libs.script;


-- Documentation
-- http://www.unifiedremote.com/api

-- Script Library
-- http://www.unifiedremote.com/api/libs/script


--@help Command 1
actions.tenm = function ()
	script.default("shutdown -s -t 600");
end

actions.twentym = function ()
	script.default("shutdown -s -t 1200");
end

actions.thirtym = function ()
	script.default("shutdown -s -t 1800");
end




actions.oneh = function ()
	script.default("shutdown -s -t 3600");
end

actions.twoh = function ()
	script.default("shutdown -s -t 7200");
end

actions.threeh = function ()
	script.default("shutdown -s -t 10800");
end

actions.fourh = function ()
	script.default("shutdown -s -t 14400");
end




actions.onehm = function ()
	script.default("shutdown -s -t 5400");
end

actions.twohm = function ()
	script.default("shutdown -s -t 9000");
end

actions.threehm = function ()
	script.default("shutdown -s -t 12600");
end

actions.fourhm = function ()
	script.default("shutdown -s -t 16200");
end



actions.abort = function ()
	script.default("shutdown -a");
end


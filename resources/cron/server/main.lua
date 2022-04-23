local Jobs = {}
local LastTime = nil

function RunAt(h, m, ime, cb)
    local naso = false
    for i=1, #Jobs, 1 do
        if Jobs[i].ime == ime then
            naso = true
        end
    end
    if not naso then
        table.insert(Jobs, {
            h  = h,
            m  = m,
            ime = ime,
            cb = cb
        })
    end
end

function GetTime()
	local timestamp = os.time()
	local d = os.date('*t', timestamp).wday
	local h = tonumber(os.date('%H', timestamp))
	local m = tonumber(os.date('%M', timestamp))

	return {d = d, h = h, m = m}
end

function OnTime(d, h, m)

	for i=1, #Jobs, 1 do
		if Jobs[i].h == h and Jobs[i].m == m then
			Jobs[i].cb(d, h, m)
		end
	end
end

function Tick()
	local time = GetTime()

	if time.h ~= LastTime.h or time.m ~= LastTime.m then
		OnTime(time.d, time.h, time.m)
		LastTime = time
	end

	SetTimeout(60000, Tick)
end

LastTime = GetTime()

Tick()

AddEventHandler('cron:runAt', function(h, m, ime, cb)
    RunAt(h, m, ime, cb)
end)

AddEventHandler('cron:Edit', function(h, m, ime)
    for i=1, #Jobs, 1 do
        if Jobs[i].ime == ime then
            Jobs[i].h = h
            Jobs[i].m = m
        end
    end
end)
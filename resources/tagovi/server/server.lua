local staffTag = false
local staffTable = { 0 }
local duznost = {}
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

--print(table.unpack(staffTable))

function secondsToClock(seconds)
	local seconds, hours, mins, secs = tonumber(seconds), 0, 0, 0

	if seconds <= 0 then
		return 0, 0, 0
	else
		local hours = string.format("%02.f", math.floor(seconds / 3600))
		local mins = string.format("%02.f", math.floor(seconds / 60 - (hours * 60)))
		local secs = string.format("%02.f", math.floor(seconds - hours * 3600 - mins * 60))

		return hours, mins, secs
	end
end

RegisterNetEvent('tagovi:staffTag')
AddEventHandler('tagovi:staffTag', function(br)
	local src = source
	if has_value(staffTable, src) then
		removebyKey(staffTable, src)
	else
		table.insert(staffTable, src)
	end
	TriggerClientEvent("sendStaff", -1, staffTable)
    if br then
        for i = 1, #duznost do
            if duznost[i] ~= nil and duznost[i].src == src then
                table.remove(duznost, i)
            end
        end
        TriggerClientEvent('prodajoruzje:AdminChat', -1, "^1[ADMIN]", " ^7Admin "..GetPlayerName(src).." je na duznosti!")
        table.insert(duznost, {src = src, dat = os.time()})
    else
        TriggerClientEvent('prodajoruzje:AdminChat', -1, "^1[ADMIN]", " ^7Admin "..GetPlayerName(src).." je otisao s duznosti!")
        for i = 1, #duznost do
            if duznost[i] ~= nil and duznost[i].src == src then
                local dif = os.difftime(os.time(), duznost[i].dat)
                local hr, min, sec = secondsToClock(dif)
                TriggerEvent("DiscordBot:Aduty", "Admin "..GetPlayerName(src).." je bio na duznosti "..hr.." h, "..min.." min i "..sec.." sec!")
                table.remove(duznost, i)
                break
            end
        end
    end
end)

RegisterNetEvent('tagovi:hideTag')
AddEventHandler('tagovi:hideTag', function(br)
	local src = source
    if br then
        if has_value(staffTable, src) then
            removebyKey(staffTable, src)
        end
    else
        if not has_value(staffTable, src) then
            table.insert(staffTable, src)
        end
    end
	TriggerClientEvent("sendStaff", -1, staffTable)
end)

function has_value (tab, val)
    for i, v in ipairs (tab) do
        if (v == val) then
            return true
        end
    end
    return false
end

function removebyKey(tab, val)
    for i, v in ipairs (tab) do 
        if (v == val) then
          --tab[i] = nil
		  table.remove(tab, i)
        end
    end
end

AddEventHandler('playerDropped', function (reason)
    for i = 1, #duznost do
        if duznost[i] ~= nil and duznost[i].src == source then
            local dif = os.difftime(os.time(), duznost[i].dat)
            local hr, min, sec = secondsToClock(dif)
            TriggerEvent("DiscordBot:Aduty", "Admin "..GetPlayerName(src).." je bio na duznosti "..hr.." h, "..min.." min i "..sec.." sec!")
            table.remove(duznost, i)
            break
        end
    end
    removebyKey(staffTable, source)
end)

RegisterCommand("showTags", function(source, args, rawCommand)
    TriggerClientEvent("showTags", source)
end)
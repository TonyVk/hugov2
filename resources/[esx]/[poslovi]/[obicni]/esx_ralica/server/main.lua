ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local Radnici = {}

RegisterServerEvent('ralica:ZapoceoPosao')
AddEventHandler('ralica:ZapoceoPosao', function(br)
	local _source = source
	if br then
		Radnici[tostring(_source)] = true
	else
		Radnici[tostring(_source)] = nil
	end
end)

RegisterServerEvent('esx_ralica:platiTuljanu')
AddEventHandler('esx_ralica:platiTuljanu', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.posao.name == 'ralica' then
		if Radnici[tostring(_source)] then
			xPlayer.addMoney(10)
			TriggerEvent("biznis:StaviUSef", "ralica", math.ceil(10*0.30))
		else
			TriggerEvent("DiscordBot:Anticheat", GetPlayerName(_source).."[".._source.."] je pokusao pozvati event za novac cistaca snijega, a nije zapoceo posao!")
	    	TriggerEvent("AntiCheat:Citer", _source)
		end
	else
        TriggerEvent("DiscordBot:Anticheat", GetPlayerName(_source).."[".._source.."] je pokusao pozvati event za novac cistaca snijega, a nije zaposlen kao cistac snijega! ("..xPlayer.posao.name..")")
	    TriggerEvent("AntiCheat:Citer", _source)
    end
end)

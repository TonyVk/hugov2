ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local Radnici = {}

RegisterServerEvent('kosac:ZapoceoPosao')
AddEventHandler('kosac:ZapoceoPosao', function(br)
	local _source = source
	if br then
		Radnici[tostring(_source)] = true
	else
		Radnici[tostring(_source)] = nil
	end
end)

RegisterServerEvent('kosac:EoPlace')
AddEventHandler('kosac:EoPlace', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.posao.name == 'kosac' then
		if Radnici[tostring(_source)] then
			xPlayer.addMoney(5)
			local por = "["..os.date("%X").."] ("..GetCurrentResourceName()..") Igrac "..GetPlayerName(_source).."("..xPlayer.identifier..") je dobio $5"
			TriggerEvent("SpremiLog", por)
			TriggerEvent("biznis:StaviUSef", "kosac", math.ceil(14*0.30))
		else
			TriggerEvent("DiscordBot:Anticheat", GetPlayerName(_source).."[".._source.."] je pokusao pozvati event za novac kosaca, a nije zapoceo posao!")
			TriggerEvent("AntiCheat:Citer", _source)
		end
	else
        TriggerEvent("DiscordBot:Anticheat", GetPlayerName(_source).."[".._source.."] je pokusao pozvati event za novac kosaca, a nije zaposlen kao kosac! ("..xPlayer.posao.name..")")
	    TriggerEvent("AntiCheat:Citer", _source)
    end
end)

RegisterServerEvent('kosac:EoPlace2')
AddEventHandler('kosac:EoPlace2', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.posao.name == 'kosac' then
		if Radnici[tostring(_source)] then
			xPlayer.addMoney(3)
			local por = "["..os.date("%X").."] ("..GetCurrentResourceName()..") Igrac "..GetPlayerName(_source).."("..xPlayer.identifier..") je dobio $3"
			TriggerEvent("SpremiLog", por)
			TriggerEvent("biznis:StaviUSef", "kosac", math.ceil(7*0.30))
		else
			TriggerEvent("DiscordBot:Anticheat", GetPlayerName(_source).."[".._source.."] je pokusao pozvati event za novac kosaca, a nije zapoceo posao!")
			TriggerEvent("AntiCheat:Citer", _source)
		end
	else
        TriggerEvent("DiscordBot:Anticheat", GetPlayerName(_source).."[".._source.."] je pokusao pozvati event za novac kosaca, a nije zaposlen kao kosac! ("..xPlayer.posao.name..")")
	    TriggerEvent("AntiCheat:Citer", _source)
    end
end)
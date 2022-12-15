ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local Radnici = {}

RegisterServerEvent('kran:ZapoceoPosao')
AddEventHandler('kran:ZapoceoPosao', function(br)
	local _source = source
	if br then
		Radnici[tostring(_source)] = true
	else
		Radnici[tostring(_source)] = nil
	end
end)

RegisterServerEvent('kran:EoPlace')
AddEventHandler('kran:EoPlace', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.posao.name == Config.Posao then
		if Radnici[tostring(_source)] then
			xPlayer.addMoney(150)
			local por = "["..os.date("%X").."] ("..GetCurrentResourceName()..") Igrac "..GetPlayerName(_source).."("..xPlayer.identifier..") je dobio $150"
			TriggerEvent("SpremiLog", por)
			TriggerEvent("biznis:StaviUSef", Config.Posao, math.ceil(150*0.30))
		else
			TriggerEvent("DiscordBot:Anticheat", GetPlayerName(_source).."[".._source.."] je pokusao pozvati event za novac kraniste, a nije zapoceo posao!")
			TriggerEvent("AntiCheat:Citer", _source)
		end
	else
        TriggerEvent("DiscordBot:Anticheat", GetPlayerName(_source).."[".._source.."] je pokusao pozvati event za novac kraniste, a nije zaposlen kao kranista! ("..xPlayer.posao.name..")")
	    TriggerEvent("AntiCheat:Citer", _source)
    end
end)
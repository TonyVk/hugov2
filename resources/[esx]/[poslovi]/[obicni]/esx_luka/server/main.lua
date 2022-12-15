ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local Radnici = {}

RegisterServerEvent('luka:ZapoceoPosao')
AddEventHandler('luka:ZapoceoPosao', function(br)
	local _source = source
	if br then
		Radnici[tostring(_source)] = true
	else
		Radnici[tostring(_source)] = nil
	end
end)

RegisterServerEvent('luka:EoPlace')
AddEventHandler('luka:EoPlace', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.posao.name == Config.Posao then
		if Radnici[tostring(_source)] then
			xPlayer.addMoney(150)
			local por = "["..os.date("%X").."] ("..GetCurrentResourceName()..") Igrac "..GetPlayerName(_source).."("..xPlayer.identifier..") je dobio $150"
			TriggerEvent("SpremiLog", por)
			TriggerEvent("biznis:StaviUSef", Config.Posao, math.ceil(350*0.30))
		else
			TriggerEvent("DiscordBot:Anticheat", GetPlayerName(_source).."[".._source.."] je pokusao pozvati event za novac luckog radnika, a nije zapoceo posao!")
			TriggerEvent("AntiCheat:Citer", _source)
		end
	else
        TriggerEvent("DiscordBot:Anticheat", GetPlayerName(_source).."[".._source.."] je pokusao pozvati event za novac luckog radnika, a nije zaposlen kao lucki radnik! ("..xPlayer.posao.name..")")
	    TriggerEvent("AntiCheat:Citer", _source)
    end
end)
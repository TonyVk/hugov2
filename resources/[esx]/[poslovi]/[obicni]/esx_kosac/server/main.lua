ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('kosac:EoPlace')
AddEventHandler('kosac:EoPlace', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.posao.name == 'kosac' then
		xPlayer.addMoney(14)
		TriggerEvent("biznis:StaviUSef", "kosac", math.ceil(14*0.30))
	else
        TriggerEvent("DiscordBot:Anticheat", GetPlayerName(_source).."[".._source.."] je pokusao pozvati event za novac kosaca, a nije zaposlen kao kosac!")
	    TriggerEvent("AntiCheat:Citer", _source)
    end
end)

RegisterServerEvent('kosac:EoPlace2')
AddEventHandler('kosac:EoPlace2', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.posao.name == 'kosac' then
		xPlayer.addMoney(7)
		TriggerEvent("biznis:StaviUSef", "kosac", math.ceil(7*0.30))
	else
        TriggerEvent("DiscordBot:Anticheat", GetPlayerName(_source).."[".._source.."] je pokusao pozvati event za novac kosaca, a nije zaposlen kao kosac!")
	    TriggerEvent("AntiCheat:Citer", _source)
    end
end)
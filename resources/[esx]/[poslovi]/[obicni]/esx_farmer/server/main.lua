ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local Radnici = {}

RegisterServerEvent('farmer:EoPlace')
AddEventHandler('farmer:EoPlace', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.posao.name == Config.Posao then
		if Radnici[tostring(_source)] then
			xPlayer.addMoney(2)
			local por = "["..os.date("%X").."] ("..GetCurrentResourceName()..") Igrac "..GetPlayerName(_source).."("..xPlayer.identifier..") je dobio $2"
			TriggerEvent("SpremiLog", por)
			TriggerEvent("biznis:StaviUSef", Config.Posao, math.ceil(2*0.30))
		else
			TriggerEvent("DiscordBot:Anticheat", GetPlayerName(_source).."(".._source..") je pokusao dobiti novac od farmera, a nije zapoceo posao!")
			TriggerEvent("AntiCheat:Citer", _source)
		end
	else
		TriggerEvent("DiscordBot:Anticheat", GetPlayerName(_source).."(".._source..") je pokusao dobiti novac od farmera, a nije farmer! ("..xPlayer.posao.name..")")
		TriggerEvent("AntiCheat:Citer", _source)
    end
end)

RegisterServerEvent('farmer:EoPlace2')
AddEventHandler('farmer:EoPlace2', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.posao.name == Config.Posao then
		if Radnici[tostring(_source)] then
			xPlayer.addMoney(4)
			local por = "["..os.date("%X").."] ("..GetCurrentResourceName()..") Igrac "..GetPlayerName(_source).."("..xPlayer.identifier..") je dobio $4"
			TriggerEvent("SpremiLog", por)
			TriggerEvent("biznis:StaviUSef", Config.Posao, math.ceil(4*0.30))
		else
			TriggerEvent("DiscordBot:Anticheat", GetPlayerName(_source).."(".._source..") je pokusao dobiti novac od farmera, a nije zapoceo posao!")
			TriggerEvent("AntiCheat:Citer", _source)
		end
	else
		TriggerEvent("DiscordBot:Anticheat", GetPlayerName(_source).."(".._source..") je pokusao dobiti novac od farmera, a nije farmer! ("..xPlayer.posao.name..")")
		TriggerEvent("AntiCheat:Citer", _source)
    end
end)

RegisterServerEvent('farmer:ZapoceoPosao')
AddEventHandler('farmer:ZapoceoPosao', function(br)
	local _source = source
	if br then
		Radnici[tostring(_source)] = true
	else
		Radnici[tostring(_source)] = nil
	end
end)
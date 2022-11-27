ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('farmer:EoPlace')
AddEventHandler('farmer:EoPlace', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.posao.name == Config.Posao then
		xPlayer.addMoney(2)
		local por = "["..os.date("%X").."] ("..GetCurrentResourceName()..") Igrac "..GetPlayerName(_source).."("..xPlayer.identifier..") je dobio $2"
		TriggerEvent("SpremiLog", por)
		TriggerEvent("biznis:StaviUSef", Config.Posao, math.ceil(2*0.30))
    end
end)

RegisterServerEvent('farmer:EoPlace2')
AddEventHandler('farmer:EoPlace2', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.posao.name == Config.Posao then
		xPlayer.addMoney(4)
		local por = "["..os.date("%X").."] ("..GetCurrentResourceName()..") Igrac "..GetPlayerName(_source).."("..xPlayer.identifier..") je dobio $4"
		TriggerEvent("SpremiLog", por)
		TriggerEvent("biznis:StaviUSef", Config.Posao, math.ceil(4*0.30))
    end
end)

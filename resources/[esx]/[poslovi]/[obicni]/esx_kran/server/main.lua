ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('kran:EoPlace')
AddEventHandler('kran:EoPlace', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.posao.name == Config.Posao then
		xPlayer.addMoney(15)
		local por = "["..os.date("%X").."] ("..GetCurrentResourceName()..") Igrac "..GetPlayerName(_source).."("..xPlayer.identifier..") je dobio $15"
		TriggerEvent("SpremiLog", por)
		TriggerEvent("biznis:StaviUSef", Config.Posao, math.ceil(150*0.30))
    end
end)
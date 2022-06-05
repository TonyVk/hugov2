ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('farmer:EoPlace')
AddEventHandler('farmer:EoPlace', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.posao.name == Config.Posao then
		xPlayer.addMoney(15)
		TriggerEvent("biznis:StaviUSef", Config.Posao, math.ceil(15*0.30))
    end
end)

RegisterServerEvent('farmer:EoPlace2')
AddEventHandler('farmer:EoPlace2', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.posao.name == Config.Posao then
		xPlayer.addMoney(26)
		TriggerEvent("biznis:StaviUSef", Config.Posao, math.ceil(26*0.30))
    end
end)

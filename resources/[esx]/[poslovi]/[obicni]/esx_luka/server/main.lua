ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('luka:EoPlace')
AddEventHandler('luka:EoPlace', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.posao.name == Config.Posao then
		xPlayer.addMoney(150)
		TriggerEvent("biznis:StaviUSef", Config.Posao, math.ceil(350*0.30))
    end
end)
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('oglasi:DohvatiPodatke', function(source, cb)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    cb(xPlayer.getFirstname(), xPlayer.getLastname(), xPlayer.getNumber())
end)

ESX.RegisterUsableItem('novine', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local item = xPlayer.getInventoryItem("novine")
    if item.count >= 1 then
        TriggerClientEvent("esx_invh:closeinv", _source)
        TriggerClientEvent("oglasi:OtvoriNovine", _source)
        xPlayer.removeInventoryItem("novine", 1)
    end
end)
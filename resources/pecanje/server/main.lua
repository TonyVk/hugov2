ESX = nil
local Pecanje = {}

local Prodaja = {coord = vector3(-510.88455200196, -40.816955566406, 44.579372406006), heading = 86.66}

TriggerEvent("esx:getSharedObject", function(library) 
	ESX = library 
end)

ESX.RegisterUsableItem(Config.FishingItems["rod"]["name"], function(source)
	table.insert(Pecanje, {ID = source})
	TriggerClientEvent("pecanje:StartFish", source)
end)

ESX.RegisterServerCallback("pecanje:DohvatiKoord", function(source, callback)
	callback(Prodaja)
end)

ESX.RegisterServerCallback('ribar:Prodaj', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem("fish")
	if xItem.count > 0 then
		local cij = xItem.count*Config.Prodaja
		xPlayer.removeInventoryItem("fish", xItem.count)
		xPlayer.addMoney(cij)
		cb(true, xItem.count, cij)
	else
		cb(false, nil, nil)
	end
end)

AddEventHandler('playerDropped', function()
	for i=1, #Pecanje, 1 do
		if Pecanje[i] ~= nil and Pecanje[i].ID == source then
			table.remove(Pecanje, i)
			break
		end
	end
end)

ESX.RegisterServerCallback("pecanje:receiveFish", function(source, callback, rewardtype)
	local player = ESX.GetPlayerFromId(source)

	if not player then return callback(false) end
	local naso = false
	for i=1, #Pecanje, 1 do
		if Pecanje[i] ~= nil and Pecanje[i].ID == source then
			naso = true
			table.remove(Pecanje, i)
			player.addInventoryItem(rewardtype, 1)
			callback(true)
			break
		end
	end
	if not naso then
		callback(false)
	end
end)

ESX.RegisterServerCallback("pecanje:getItems", function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local item = xPlayer.getInventoryItem(Config.FishingItems["bait"]["name"])
	if item == nil then 
		cb(false)
	elseif item.count > 0 then 
		xPlayer.removeInventoryItem(Config.FishingItems["bait"]["name"], 1)
		cb(true)
	else 
		cb(false)
	end
end)

RegisterServerEvent('pecanje:ObrisiStap')
AddEventHandler('pecanje:ObrisiStap', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local item = xPlayer.getInventoryItem(Config.FishingItems["rod"]["name"])
	if item.count > 0 then 
		xPlayer.removeInventoryItem(Config.FishingItems["rod"]["name"], 1)
	end
end)

RegisterServerEvent('pecanje:BackFish')
AddEventHandler('pecanje:BackFish', function()
	for i=1, #Pecanje, 1 do
		if Pecanje[i] ~= nil and Pecanje[i].ID == source then
			table.remove(Pecanje, i)
			local xPlayer = ESX.GetPlayerFromId(source)
			xPlayer.addInventoryItem('fishbait', 1)
			break
		end
	end
end)
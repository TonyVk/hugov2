ESX = nil
local Pecanje = {}

TriggerEvent("esx:getSharedObject", function(library) 
	ESX = library 
end)

ESX.RegisterUsableItem(Config.FishingItems["rod"]["name"], function(source)
	table.insert(Pecanje, {ID = source})
	TriggerClientEvent("pecanje:StartFish", source)
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
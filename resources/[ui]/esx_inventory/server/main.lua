ESX = nil

TriggerEvent(
	"esx:getSharedObject",
	function(obj)
		ESX = obj
	end
)

ESX.RegisterServerCallback(
	"esx_inventoryhud:getPlayerInventory",
	function(source, cb, target)
		local targetXPlayer = ESX.GetPlayerFromId(target)

		if targetXPlayer ~= nil then
			cb({inventory = targetXPlayer.inventory, money = targetXPlayer.getMoney(), accounts = targetXPlayer.accounts, weapons = targetXPlayer.loadout})
		else
			cb(nil)
		end
	end
)

RegisterServerEvent("esx_inventoryhud:tradePlayerItem")
AddEventHandler(
	"esx_inventoryhud:tradePlayerItem",
	function(from, target, type, itemName, itemCount)
		local _source = from

		local sourceXPlayer = ESX.GetPlayerFromId(_source)
		local targetXPlayer = ESX.GetPlayerFromId(target)

		if type == "item_standard" then
			local sourceItem = sourceXPlayer.getInventoryItem(itemName)
			local targetItem = targetXPlayer.getInventoryItem(itemName)

			if itemCount > 0 and sourceItem.count >= itemCount then
				if targetItem.limit ~= -1 and (targetItem.count + itemCount) > targetItem.limit then
				else
					sourceXPlayer.removeInventoryItem(itemName, itemCount)
					targetXPlayer.addInventoryItem(itemName, itemCount)
				end
			end
		elseif type == "item_account" then
			if itemCount > 0 and sourceXPlayer.getAccount(itemName).money >= itemCount then
				sourceXPlayer.removeAccountMoney(itemName, itemCount)
				targetXPlayer.addAccountMoney(itemName, itemCount)
			end
		elseif type == "item_weapon" then
			if not targetXPlayer.hasWeapon(itemName) then
				sourceXPlayer.removeWeapon(itemName)
				targetXPlayer.addWeapon(itemName, itemCount)
			end
		end
	end
)

RegisterCommand("pogledajinv", function(source, args, rawCommand)
	local target = tonumber(args[1])
	local targetXPlayer = ESX.GetPlayerFromId(target)
	local xPlayer = ESX.GetPlayerFromId(source)
	local steamime = GetPlayerName(xPlayer.source)--Logovi

	if xPlayer.getGroup()=="superadmin" or xPlayer.getGroup()=="admin" then
		local targetId = tonumber(args[1])
		local xTarget = ESX.GetPlayerFromId(targetId)
	    if targetXPlayer ~= nil then
			local steamimeTarget = GetPlayerName(xTarget.source)
			TriggerClientEvent("esx_inventoryhud:openPlayerInventory", source, target, targetXPlayer.name)
			komandelog("Komanda Pogledajinv 🖥️", "\n Steam Admina: **"  .. steamime  .. "\n **Steam Igrača: **"  .. steamimeTarget  .."**\n ID Igraca: **" .. args[1] .."**")
	    else
			xPlayer.showNotification('Koristite : /pogledajinv ID')
		end
	else
		xPlayer.showNotification('Nemate dozvolu!')
	end
end)

----------------------Logovi
function komandelog(name, message)
	local vrijeme = os.date('*t')
	local poruka = {
		{
			["color"] = 16449301,
			["title"] = "".. name .."",
			["description"] = message,
			}
		}
	PerformHttpRequest("https://discord.com/api/webhooks/872076260090707968/CZRKrFApgUePLMiL3L7aILAbXj2yQE1QaTAGFqQADCspYPjjZpKaJzm4JcAz6_n7s71Y", function(err, text, headers) end, 'POST', json.encode({username = "Logovi", embeds = poruka, avatar_url = ""}), { ['Content-Type'] = 'application/json' })
end






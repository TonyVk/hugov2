local ESX = nil
local Markeri = {}

TriggerEvent('esx:getSharedObject', function(obj) 
    ESX = obj 
end)

TriggerEvent('es:addGroupCommand', 'kazna', 'admin', function(source, args, user)
	if args[1] and GetPlayerName(args[1]) ~= nil and tonumber(args[2]) and args[3] ~= nil then
		local _source = source
		local razlog = table.concat(args, " ", 3)
		TriggerEvent('esx_markeras:sendToCommunityService', tonumber(args[1]), tonumber(args[2]), razlog)
		TriggerEvent("DiscordBot:Markeri", GetPlayerName(args[1]).."["..args[1].."] je stavljen na "..args[2].." markera od admina "..GetPlayerName(_source)..". Razlog: "..razlog)
	else
		TriggerClientEvent('chat:addMessage', source, { args = { _U('system_msn'), _U('invalid_player_id_or_actions') } } )
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { _U('system_msn'), _U('insufficient_permissions') } })
end, {help = 'Dati igracu dobrotvorni rad', params = {{name = "id", help = 'ID igraca'}, {name = "actions", help = 'Kolicina markera [Predlozeno: 100-1000]'}, {name = "reason", help = 'Razlog markera'}}})


TriggerEvent('es:addGroupCommand', 'maknikaznu', 'admin', function(source, args, user)
	if args[1] then
		if GetPlayerName(args[1]) ~= nil then
			local _source = source
			TriggerEvent('esx_markeras:endCommunityServiceCommand', tonumber(args[1]))
			TriggerEvent("DiscordBot:Markeri", GetPlayerName(args[1]).."["..args[1].."] su maknuti markeri od admina "..GetPlayerName(_source))
		else
			TriggerClientEvent('chat:addMessage', source, { args = { _U('system_msn'), _U('invalid_player_id')  } } )
		end
	else
		TriggerEvent('esx_markeras:endCommunityServiceCommand', source)
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { _U('system_msn'), _U('insufficient_permissions') } })
end, {help = 'Pustiti igraca iz kazne', params = {{name = "id", help = 'ID igraca'}}})

AddEventHandler('playerDropped', function()
	local src = source
	for i=1, #Markeri, 1 do
		if Markeri[i] ~= nil then
			if Markeri[i].ID == src then
				table.remove(Markeri, i)
				break
			end
		end
	end
end)

RegisterServerEvent('esx_markeras:endCommunityServiceCommand')
AddEventHandler('esx_markeras:endCommunityServiceCommand', function(source)
	if source ~= nil then
		releaseFromCommunityService(source)
	end
end)

---------CARRY PEOPLE
RegisterServerEvent('CarryPeople:sync')
AddEventHandler('CarryPeople:sync', function(target, animationLib,animationLib2, animation, animation2, distans, distans2, height,targetSrc,length,spin,controlFlagSrc,controlFlagTarget,animFlagTarget)
	TriggerClientEvent('CarryPeople:syncTarget', targetSrc, source, animationLib2, animation2, distans, distans2, height, length,spin,controlFlagTarget,animFlagTarget)
	TriggerClientEvent('CarryPeople:syncMe', source, animationLib, animation,length,controlFlagSrc,animFlagTarget)
end)

RegisterServerEvent('CarryPeople:stop')
AddEventHandler('CarryPeople:stop', function(targetSrc)
	TriggerClientEvent('CarryPeople:cl_stop', targetSrc)
end)

-- unjail after time served
RegisterServerEvent('esx_markeras:finishCommunityService')
AddEventHandler('esx_markeras:finishCommunityService', function()
	releaseFromCommunityService(source)
end)

RegisterServerEvent('esx_markeras:completeService')
AddEventHandler('esx_markeras:completeService', function()

	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	local br = 0
	local naso = false
	
	for i=1, #Markeri, 1 do
		if Markeri[i] ~= nil then
			if Markeri[i].ID == _source then
				naso = true
				Markeri[i].Broj = Markeri[i].Broj-1
				br = Markeri[i].Broj
				break
			end
		end
	end

	if naso then
		MySQL.Async.fetchScalar('SELECT actions_remaining FROM communityservice WHERE identifier = @identifier', {
			['@identifier'] = xPlayer.getID()
		}, function(result)

			if result then
				MySQL.Async.execute('UPDATE communityservice SET actions_remaining = @broj WHERE identifier = @identifier', {
					['@broj'] = br,
					['@identifier'] = xPlayer.getID()
				})
			else
				print ("esx_markeras :: Problem matching player identifier in database to reduce actions.")
			end
		end)
	else
		print("Markeri: Problem sa pronalaskom igraca u tablici: "..xPlayer.getID())
	end
end)

RegisterServerEvent('esx_markeras:extendService')
AddEventHandler('esx_markeras:extendService', function()

	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	MySQL.Async.fetchScalar('SELECT actions_remaining FROM communityservice WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.getID()
	}, function(result)

		if result then
			MySQL.Async.execute('UPDATE communityservice SET actions_remaining = actions_remaining + @extension_value WHERE identifier = @identifier', {
				['@identifier'] = xPlayer.getID(),
				['@extension_value'] = 500
			})
		else
			print ("esx_markeras :: Problem matching player identifier in database to reduce actions.")
		end
	end)
end)

RegisterServerEvent('esx_markeras:sendToCommunityService')
AddEventHandler('esx_markeras:sendToCommunityService', function(target, actions_count, razlog)

	local xPlayer = ESX.GetPlayerFromId(target)

	MySQL.Async.fetchScalar('SELECT actions_remaining FROM communityservice WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.getID()
	}, function(result)
		if result then
			MySQL.Async.execute('UPDATE communityservice SET actions_remaining = @actions_remaining WHERE identifier = @identifier', {
				['@identifier'] = xPlayer.getID(),
				['@actions_remaining'] = actions_count
			})
		else
			MySQL.Async.execute('INSERT INTO communityservice (identifier, actions_remaining) VALUES (@identifier, @actions_remaining)', {
				['@identifier'] = xPlayer.getID(),
				['@actions_remaining'] = actions_count
			})
		end
	end)

	TriggerClientEvent('chat:addMessage', -1, { args = { _U('judge'), _U('comserv_msg', GetPlayerName(target), actions_count) }, color = { 147, 196, 109 } })
	TriggerClientEvent('chat:addMessage', target, { args = { _U('judge'), "Razlog osudjivanja: "..razlog }, color = { 147, 196, 109 } })
	TriggerClientEvent('esx_policejob:unrestrain', target)
	TriggerClientEvent('esx_markeras:inCommunityService', target, actions_count)
	local naso = false
	for i=1, #Markeri, 1 do
		if Markeri[i] ~= nil then
			if Markeri[i].ID == target then
				Markeri[i].Broj = actions_count
				naso = true
				break
			end
		end
	end
	if not naso then
		table.insert(Markeri, {ID = target, Broj = actions_count})
	end
end)

RegisterServerEvent('esx_markeras:checkIfSentenced')
AddEventHandler('esx_markeras:checkIfSentenced', function()
	local _source = source -- cannot parse source to client trigger for some weird reason
	local xPlayer = ESX.GetPlayerFromId(_source)

	MySQL.Async.fetchScalar('SELECT actions_remaining FROM communityservice WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.getID()
	}, function(result)
		if result ~= nil and result > 0 then
			--TriggerClientEvent('chat:addMessage', -1, { args = { _U('judge'), _U('jailed_msg', GetPlayerName(_source), ESX.Math.Round(result[1].jail_time / 60)) }, color = { 147, 196, 109 } })
			local naso = false
			for i=1, #Markeri, 1 do
				if Markeri[i] ~= nil then
					if Markeri[i].ID == _source then
						Markeri[i].Broj = tonumber(result)
						naso = true
						break
					end
				end
			end
			if not naso then
				table.insert(Markeri, {ID = _source, Broj = tonumber(result)})
			end
			TriggerClientEvent('esx_markeras:inCommunityService', _source, tonumber(result))
		end
	end)
end)

ESX.RegisterServerCallback('esx_markeras:ProvjeriMarkere', function(source, cb)
	local _source = source -- cannot parse source to client trigger for some weird reason

	for i=1, #Markeri, 1 do
		if Markeri[i] ~= nil then
			if Markeri[i].ID == _source then
				cb(Markeri[i].Broj)
				break
			end
		end
	end
end)

ESX.RegisterServerCallback('esx_markeras:DohvatiMarkere', function(source, cb)
	local _source = source -- cannot parse source to client trigger for some weird reason
	local xPlayer = ESX.GetPlayerFromId(_source)

	MySQL.Async.fetchScalar('SELECT actions_remaining FROM communityservice WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.getID()
	}, function(result)
		if result ~= nil then
			cb(result)
		else
			cb(nil)
		end
	end)
end)

function releaseFromCommunityService(target)

	local xPlayer = ESX.GetPlayerFromId(target)
	MySQL.Async.fetchScalar('SELECT actions_remaining FROM communityservice WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.getID()
	}, function(result)
		if result then
			MySQL.Async.execute('DELETE from communityservice WHERE identifier = @identifier', {
				['@identifier'] = xPlayer.getID()
			})

			TriggerClientEvent('chat:addMessage', -1, { args = { _U('judge'), _U('comserv_finished', GetPlayerName(target)) }, color = { 147, 196, 109 } })
		end
	end)

	TriggerClientEvent('esx_markeras:finishCommunityService', target)
	
	for i=1, #Markeri, 1 do
		if Markeri[i] ~= nil then
			if Markeri[i].ID == target then
				table.remove(Markeri, i)
				break
			end
		end
	end
end

--discord
ESX.RegisterServerCallback("discord:DohvatiIgrace", function(source, cb)
	cb(#GetPlayers())
end)

RegisterServerEvent("kickForBeingAnAFKDouchebag")
AddEventHandler("kickForBeingAnAFKDouchebag", function()
	DropPlayer(source, "Bili ste AFK predugo.")
end)

-- OBJ : transform a table into a string (using spaces)
-- PARAMETERS :
--		- tab : the table to transform
local function TableToString(tab)
	local str = ""
	for i = 1, #tab do
		str = str .. " " .. tab[i]
	end
	return str
end

RegisterServerEvent('cmg3_animations:sync')
AddEventHandler('cmg3_animations:sync', function(target, animationLib,animationLib2, animation, animation2, distans, distans2, height,targetSrc,length,spin,controlFlagSrc,controlFlagTarget,animFlagTarget,attachFlag)
	print("got to srv cmg3_animations:sync")
	print("got that fucking attach flag as: " .. tostring(attachFlag))
	TriggerClientEvent('cmg3_animations:syncTarget', targetSrc, source, animationLib2, animation2, distans, distans2, height, length,spin,controlFlagTarget,animFlagTarget,attachFlag)
	print("triggering to target: " .. tostring(targetSrc))
	TriggerClientEvent('cmg3_animations:syncMe', source, animationLib, animation,length,controlFlagSrc,animFlagTarget)
end)

RegisterServerEvent('cmg3_animations:stop')
AddEventHandler('cmg3_animations:stop', function(targetSrc)
	TriggerClientEvent('cmg3_animations:cl_stop', targetSrc)
end)

RegisterServerEvent('jsfour-idcard:open')
AddEventHandler('jsfour-idcard:open', function(ID, targetID, type)
	local xPlayer = ESX.GetPlayerFromId(ID)
	local _source 	 = ESX.GetPlayerFromId(targetID).source
	local show       = false

	MySQL.Async.fetchAll('SELECT firstname, lastname, dateofbirth, sex, height FROM users WHERE ID = @identifier', {['@identifier'] = xPlayer.getID()},
	function (user)
		if (user[1] ~= nil) then
			MySQL.Async.fetchAll('SELECT type FROM user_licenses WHERE owner = @identifier', {['@identifier'] = xPlayer.getID()},
			function (licenses)
				if type ~= nil then
					for i=1, #licenses, 1 do
						if type == 'driver' then
							if licenses[i].type == 'drive' or licenses[i].type == 'drive_bike' or licenses[i].type == 'drive_truck' then
								show = true
							end
						elseif type =='weapon' then
							if licenses[i].type == 'weapon' then
								show = true
							end
						end
					end
				else
					show = true
				end

				if show then
					local array = {
						user = user,
						licenses = licenses
					}
					TriggerClientEvent('jsfour-idcard:open', _source, array, type)
				else
					TriggerClientEvent('esx:showNotification', _source, "Nemate tu dozvolu..")
				end
			end)
		end
	end)
end)

-- --------------------------------------------
-- Commands
-- --------------------------------------------

RegisterCommand('me', function(source, args)
    local text = "*" .. TableToString(args) .. " *"
	local player = source
	local ped = GetPlayerPed(player)
	local koord = GetEntityCoords(ped)
    TriggerClientEvent('3dme:shareDisplay', -1, text, source, koord)
end)

RegisterCommand("restartsrw", function(source, args, rawCommandString)
	local Source = source
	local Vrati = 0
	if Source ~= 0 then
		local id = Source
		local xPlayer = ESX.GetPlayerFromId(id)
		local Vrati = 0
		local result = MySQL.Sync.fetchAll('SELECT permission_level FROM users WHERE ID = @id', {
			['@id'] = xPlayer.getID()
		})
		local vr = result[1].permission_level
		if vr > 0 then
			Vrati = 1
		else
			Vrati = 0
		end
	else
		Vrati = 1
	end
	if Vrati == 1 then
		ESX.SavePlayers()
		if Source == 0 then
			print("Spremili ste sve")
		else
			TriggerClientEvent('esx:showNotification', source, "Spremili ste sve!")
		end
	end
end, false)

-- Make the kit usable!
ESX.RegisterUsableItem('repairkit', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if Config.AllowMecano then
		TriggerClientEvent('esx_repairkit:onUse', _source)
	else
		if xPlayer.job.name ~= 'mecano' then
			TriggerClientEvent('esx_repairkit:onUse', _source)
		end
	end
end)

RegisterNetEvent('skriptice:SpremiLogin')
AddEventHandler('skriptice:SpremiLogin', function()
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	MySQL.Async.execute("UPDATE users SET zadnji_login=@datum WHERE ID=@id", {['@id'] = xPlayer.getID(), ['@datum'] = os.date("%d/%m/%Y %X")})
end)

RegisterNetEvent('esx_repairkit:removeKit')
AddEventHandler('esx_repairkit:removeKit', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if not Config.InfiniteRepairs then
		xPlayer.removeInventoryItem('repairkit', 1)
		TriggerClientEvent('esx:showNotification', _source, _U('used_kit'))
	end
end)

--esx_getout
ESX.RegisterServerCallback('esx_getout:DohvatiPermisiju', function(source, cb)
    local id = source
    local xPlayer = ESX.GetPlayerFromId(id)
	local Vrati = 0
	local result = MySQL.Sync.fetchAll('SELECT permission_level FROM users WHERE ID = @id', {
		['@id'] = xPlayer.getID()
	})
	local vr = result[1].permission_level
	if vr > 0 then
		Vrati = 1
	else
		Vrati = 0
	end
	cb(Vrati)
end)

RegisterServerEvent("esx_getout:DajAdmina")
AddEventHandler("esx_getout:DajAdmina", function()
	local id = source
    local xPlayer = ESX.GetPlayerFromId(id)
	local Vrati = 0
	local result = MySQL.Sync.fetchAll('SELECT permission_level FROM users WHERE ID = @id', {
		['@id'] = xPlayer.getID()
	})
	local vr = result[1].permission_level
	if vr > 0 then
		Vrati = 1
	else
		Vrati = 0
	end
	TriggerClientEvent("esx_getout:VratiAdmina", source, Vrati)
end)
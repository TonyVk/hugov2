TriggerEvent("es:addGroup", "mod", "user", function(group) end)
ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local Mutan = {}
-- Modify if you want, btw the _admin_ needs to be able to target the group and it will work
local groupsRequired = {
	slay = "mod",
	noclip = "admin",
	fix = "admin",
	clean = "admin",
	crash = "owner",
	freeze = "mod",
	bring = "mod",
	["goto"] = "mod",
	slap = "mod",
	slay = "mod",
	kick = "mod"
}

local banned = ""
local bannedTable = {}

function loadBans()
	banned = LoadResourceFile(GetCurrentResourceName(), "bans.json") or ""
	if banned ~= "" then
		bannedTable = json.decode(banned)
	else
		bannedTable = {}
	end
end

RegisterCommand("refresh_bans", function()
	loadBans()
end, true)

function loadExistingPlayers()
	TriggerEvent("es:getPlayers", function(curPlayers)
		for k,v in pairs(curPlayers)do
			TriggerClientEvent("es_admin:setGroup", v.get('source'), v.get('group'))
		end
	end)
end

loadExistingPlayers()

function removeBan(id)
	bannedTable[id] = nil
	SaveResourceFile(GetCurrentResourceName(), "bans.json", json.encode(bannedTable), -1)
end

ESX.RegisterServerCallback('es_admin:DohvatiIgrace', function(source, cb)
	local igraci = {}
	for _, playerId in ipairs(GetPlayers()) do
		local name = GetPlayerName(playerId)
		table.insert(igraci, {ID = playerId, Ime = Sanitize(name)})
	end
	cb(igraci)
end)

function Sanitize(str)
	local replacements = {
		['&' ] = '&amp;',
		['<' ] = '&lt;',
		['>' ] = '&gt;',
		['\n'] = '<br/>'
	}

	return str
		:gsub('[&<>\n]', replacements)
		:gsub(' +', function(s)
			return ' '..('&nbsp;'):rep(#s-1)
		end)
end

function isBanned(id)
	if bannedTable[id] ~= nil then
		if bannedTable[id].expire < os.time() then
			removeBan(id)
			return false
		else
			return bannedTable[id]
		end
	else
		return false
	end
end

function permBanUser(bannedBy, id)
	bannedTable[id] = {
		banner = bannedBy,
		reason = "Zauvijek banan sa servera",
		expire = 0
	}

	SaveResourceFile(GetCurrentResourceName(), "bans.json", json.encode(bannedTable), -1)
end

function banUser(expireSeconds, bannedBy, id, re)
	bannedTable[id] = {
		banner = bannedBy,
		reason = re,
		expire = (os.time() + expireSeconds)
	}

	SaveResourceFile(GetCurrentResourceName(), "bans.json", json.encode(bannedTable), -1)
end

AddEventHandler('playerConnecting', function(user, set)
	for k,v in ipairs(GetPlayerIdentifiers(source))do
		local banData = isBanned(v)
		if banData ~= false then
			set("Banan zbog: " .. banData.reason .. "\nIstice: " .. (os.date("%c", banData.expire)))
			CancelEvent()
			break
		end
	end
end)

AddEventHandler('es:incorrectAmountOfArguments', function(source, wantedArguments, passedArguments, user, command)
	if(source == 0)then
		print("Argument count mismatch (passed " .. passedArguments .. ", wanted " .. wantedArguments .. ")")
	else
		TriggerClientEvent('chat:addMessage', source, {
			args = {"^1SYSTEM", "Netocan broj agrumenata! (" .. passedArguments .. " upisano, " .. requiredArguments .. " trazeno)"}
		})
	end
end)

RegisterServerEvent('report:Mutan')
AddEventHandler('report:Mutan', function(id, mi)
	Mutan[id] = mi
end)

RegisterServerEvent('es_admin:all')
AddEventHandler('es_admin:all', function(type)
	local Source = source
	local xPlayer = ESX.GetPlayerFromId(Source)
	if xPlayer.getPerm() >= 69 then
		TriggerEvent('es:getPlayerFromId', source, function(user)
			TriggerEvent('es:canGroupTarget', user.getGroup(), "admin", function(available)
				if available or user.getGroup() == "superadmin" then
					if type == "slay_all" then TriggerClientEvent('es_admin:quick', -1, 'slay') end
					if type == "bring_all" then TriggerClientEvent('es_admin:quick', -1, 'bring', Source) end
					if type == "slap_all" then TriggerClientEvent('es_admin:quick', -1, 'slap') end
				else
					TriggerClientEvent('chat:addMessage', Source, {
						args = {"^1SYSTEM", "Nemate ovlasti!"}
					})
				end
			end)
		end)
	else
		TriggerClientEvent('chat:addMessage', Source, {
			args = {"^1SYSTEM", "Vlasnik potreban za ovo!"}
		})
	end
end)

RegisterServerEvent('es_admin:quick')
AddEventHandler('es_admin:quick', function(id, type)
	local Source = source
	TriggerEvent('es:getPlayerFromId', source, function(user)
		TriggerEvent('es:getPlayerFromId', id, function(target)
			TriggerEvent('es:canGroupTarget', user.getGroup(), "admin", function(available)
				TriggerEvent('es:canGroupTarget', user.getGroup(), target.getGroup(), function(canTarget)
					if canTarget and available then
						local cord = GetEntityCoords(GetPlayerPed(id))
						local corda = GetEntityCoords(GetPlayerPed(Source))
						if type == "slay" then TriggerClientEvent('es_admin:quick', id, type) end
						if type == "noclip" then TriggerClientEvent('es_admin:quick', id, type) end
						if type == "freeze" then TriggerClientEvent('es_admin:quick', id, type) end
						if type == "crash" then TriggerClientEvent('es_admin:quick', id, type) end
						if type == "bring" then TriggerClientEvent('es_admin:quick', id, type, Source, corda) end
						if type == "goto" then TriggerClientEvent('es_admin:quick', Source, type, id, cord) end
						if type == "slap" then TriggerClientEvent('es_admin:quick', id, type) end
						if type == "slay" then TriggerClientEvent('es_admin:quick', id, type) end
						if type == "kick" then DropPlayer(id, 'Kikan od es_admin GUI') end

						if type == "ban" then
							local id
							local ip
							for k,v in ipairs(GetPlayerIdentifiers(source))do
								if string.sub(v, 1, string.len("steam:")) == "steam:" then
									permBanUser(user.identifier, v)
								elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
									permBanUser(user.identifier, v)
								end
							end

							DropPlayer(id, GetConvar("es_admin_banreason", "Banani ste sa servera"))
						end
					else
						if not available then
							TriggerClientEvent('chat:addMessage', Source, {
								args = {"^1SYSTEM", "Nemate ovlasti[grupa]!"}
							})
						else
							TriggerClientEvent('chat:addMessage', Source, {
								args = {"^1SYSTEM", "Nemate ovlasti!"}
							})
						end
					end
				end)
			end)
		end)
	end)
end)

AddEventHandler('es:playerLoaded', function(Source, user)
	TriggerClientEvent('es_admin:setGroup', Source, user.getGroup())
end)

RegisterNetEvent('amenu:Kick')
AddEventHandler('amenu:Kick', function(igr, reas)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	if xPlayer.getPerm() > 0 then
		local yPlayer = ESX.GetPlayerFromId(igr)
		if yPlayer then
			DropPlayer(igr, reas)
			TriggerClientEvent('chat:addMessage', src, {
				args = {"^1SYSTEM", "Izbacili ste igraca ^2" .. GetPlayerName(igr) .. "^0 sa servera (^2" .. reas .. "^0)"}
			})
		else
			xPlayer.showNotification("Igrac nije online!")
		end
	end
end)

RegisterNetEvent('amenu:Announce')
AddEventHandler('amenu:Announce', function(args)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	if xPlayer.getPerm() > 0 then
		TriggerClientEvent('amenu:PrikaziObavijest', -1, table.concat(args, " "))
		-- TriggerClientEvent('chat:addMessage', -1, {
		-- 	template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(255, 0, 0, 0.6); border-radius: 3px;"><i class="fas fa-bullhorn"></i> {0}:<br> {1}</div>',
		-- 	args = {"OBAVIJEST", table.concat(args, " ")}
		-- })
	end
end)

local frozen = {}
RegisterNetEvent('amenu:Freeze')
AddEventHandler('amenu:Freeze', function(player)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	if xPlayer.getPerm() > 0 then
		local yPlayer = ESX.GetPlayerFromId(player)
		if yPlayer then
			if(frozen[player])then
				frozen[player] = false
			else
				frozen[player] = true
			end

			TriggerClientEvent('es_admin:freezePlayer', player, frozen[player])

			local state = "odmrznut"
			if(frozen[player])then
				state = "zamrznut"
			end

			TriggerClientEvent('chat:addMessage', player, { args = {"^1SYSTEM", "Vi ste " .. state .. " od admina ^2" .. GetPlayerName(source)} })
			TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Igrac ^2" .. GetPlayerName(player) .. "^0 je " .. state} })
		else
			xPlayer.showNotification("Igrac nije online!")
		end
	end
end)

RegisterNetEvent('amenu:Bring')
AddEventHandler('amenu:Bring', function(igr)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	if xPlayer.getPerm() > 0 then
		local yPlayer = ESX.GetPlayerFromId(igr)
		if yPlayer then
			local kord = GetEntityCoords(GetPlayerPed(src))
			TriggerClientEvent('es_admin:teleportUser', igr, kord.x, kord.y, kord.z)

			TriggerClientEvent('chat:addMessage', igr, { args = {"^1SYSTEM", "Portani ste do admina ^2" .. GetPlayerName(src)} })
			TriggerClientEvent('chat:addMessage', src, { args = {"^1SYSTEM", "Igrac ^2" .. GetPlayerName(igr) .. "^0 je portan do vas"} })
		else
			xPlayer.showNotification("Igrac nije online!")
		end
	end
end)

RegisterNetEvent('amenu:Slap')
AddEventHandler('amenu:Slap', function(igr)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	if xPlayer.getPerm() > 0 then
		local yPlayer = ESX.GetPlayerFromId(igr)
		if yPlayer then
			TriggerClientEvent('es_admin:slap', igr)
			TriggerClientEvent('chat:addMessage', igr, { args = {"^1SYSTEM", "Slapani ste od ^2" .. GetPlayerName(src)} })
			TriggerClientEvent('chat:addMessage', src, { args = {"^1SYSTEM", "Igrac ^2" .. GetPlayerName(igr) .. "^0 je slapan"} })
		else
			xPlayer.showNotification("Igrac nije online!")
		end
	end
end)

RegisterNetEvent('amenu:Goto')
AddEventHandler('amenu:Goto', function(igr)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	if xPlayer.getPerm() > 0 then
		local yPlayer = ESX.GetPlayerFromId(igr)
		if yPlayer then
			local kord = GetEntityCoords(GetPlayerPed(igr))
			TriggerClientEvent('es_admin:teleportUser', src, kord.x, kord.y, kord.z)
			--TriggerClientEvent('chat:addMessage', player, { args = {"^1SYSTEM", "Do vas se portao admin ^2" .. GetPlayerName(source)} })
			TriggerClientEvent('chat:addMessage', src, { args = {"^1SYSTEM", "Portani ste do igraca ^2" .. GetPlayerName(igr) .. ""} })
		else
			xPlayer.showNotification("Igrac nije online!")
		end
	end
end)

RegisterNetEvent('amenu:Slay')
AddEventHandler('amenu:Slay', function(igr)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	if xPlayer.getPerm() > 0 then
		local yPlayer = ESX.GetPlayerFromId(igr)
		if yPlayer then
			TriggerClientEvent('es_admin:kill', igr)
			TriggerClientEvent('chat:addMessage', igr, { args = {"^1SYSTEM", "Ubijeni ste od ^2" .. GetPlayerName(src)} })
			TriggerClientEvent('chat:addMessage', src, { args = {"^1SYSTEM", "Igrac ^2" .. GetPlayerName(igr) .. "^0 je ubijen."} })
		else
			xPlayer.showNotification("Igrac nije online!")
		end
	end
end)

RegisterNetEvent('amenu:Crash')
AddEventHandler('amenu:Crash', function(igr)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	if xPlayer.getPerm() >= 69 then
		local yPlayer = ESX.GetPlayerFromId(igr)
		if yPlayer then
			TriggerClientEvent('es_admin:crash', igr)
			TriggerClientEvent('chat:addMessage', src, { args = {"^1SYSTEM", "Igrac ^2" .. GetPlayerName(igr) .. "^0 je crashan."} })
		else
			xPlayer.showNotification("Igrac nije online!")
		end
	end
end)

RegisterNetEvent('amenu:SetAdmin')
AddEventHandler('amenu:SetAdmin', function(igr, lvl)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	if xPlayer.getPerm() >= 69 then
		local yPlayer = ESX.GetPlayerFromId(igr)
		if yPlayer then
			TriggerEvent("es:setPlayerData", igr, "permission_level", lvl, function(response, success)
				RconPrint(response)
	
				TriggerClientEvent('es:setPlayerDecorator', igr, 'rank', lvl, true)
				TriggerClientEvent('chat:addMessage', igr, {
					args = {"^1KONZOLA", "Level permisije igracu ^2" .. GetPlayerName(igr) .. "^0 je postavljen na ^2 " .. lvl}
				})
				yPlayer.showNotification("Postavljen vam je admin level "..lvl.."!")
			end)
		else
			xPlayer.showNotification("Igrac nije online!")
		end
	end
end)

RegisterNetEvent('amenu:SetGroup')
AddEventHandler('amenu:SetGroup', function(igr, gr)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	if xPlayer.getPerm() >= 69 then
		local yPlayer = ESX.GetPlayerFromId(igr)
		if yPlayer then
			TriggerEvent("es:getAllGroups", function(groups)
				if(groups[gr])then
					TriggerEvent("es:getPlayerFromId", igr, function(user)
						ExecuteCommand('remove_principal identifier.' .. user.getIdentifier() .. " group." .. user.getGroup())

						TriggerEvent("es:setPlayerData", igr, "group", gr, function(response, success)
							TriggerClientEvent('es:setPlayerDecorator', igr, 'group', gr, true)
							TriggerClientEvent('chat:addMessage', src, {
								args = {"^1KONZOLA", "Grupa igracu ^2^*" .. GetPlayerName(igr) .. "^r^0 je postavljena na ^2^*" .. gr}
							})

							ExecuteCommand('add_principal identifier.' .. user.getIdentifier() .. " group." .. user.getGroup())
						end)
					end)
				else
					RconPrint("Ova grupa ne postoji.\n")
				end
			end)
		else
			xPlayer.showNotification("Igrac nije online!")
		end
	end
end)

RegisterServerEvent('es_admin:set')
AddEventHandler('es_admin:set', function(t, USER, GROUP)
	local Source = source
	local xPlayer = ESX.GetPlayerFromId(Source)
	if xPlayer.getPerm() >= 69 then
		TriggerEvent('es:getPlayerFromId', Source, function(user)
			TriggerEvent('es:canGroupTarget', user.getGroup(), "admin", function(available)
				if available then
				if t == "group" then
					if(GetPlayerName(USER) == nil)then
						TriggerClientEvent('chat:addMessage', source, {
							args = {"^1SYSTEM", "Igrac nije pronadjen"}
						})
					else
						TriggerEvent("es:getAllGroups", function(groups)
							if(groups[GROUP])then
								TriggerEvent("es:setPlayerData", USER, "group", GROUP, function(response, success)
									TriggerClientEvent('es_admin:setGroup', USER, GROUP)
									TriggerClientEvent('chat:addMessage', USER, {
										args = {"^1KONZOLA", "Grupa igracu ^2^*" .. GetPlayerName(tonumber(USER)) .. "^r^0 je postavljena na ^2^*" .. GROUP}
									})
								end)
							else
								TriggerClientEvent('chat:addMessage', Source, {
									args = {"^1SYSTEM", "Grupa nije pronadjena"}
								})
							end
						end)
					end
				elseif t == "level" then
					if(GetPlayerName(USER) == nil)then
						TriggerClientEvent('chat:addMessage', Source, {
							args = {"^1SYSTEM", "Igrac nije pronadjen"}
						})
					else
						GROUP = tonumber(GROUP)
						if(GROUP ~= nil and GROUP > -1)then
							TriggerEvent("es:setPlayerData", USER, "permission_level", GROUP, function(response, success)
								if(true)then
									TriggerClientEvent('chat:addMessage', USER, {
										args = {"^1KONZOLA", "Level permisije igracu ^2" .. GetPlayerName(tonumber(USER)) .. "^0 je postavljen na ^2 " .. tostring(GROUP)}
									})
								end
							end)
							
							TriggerClientEvent('es_admin:setPerm', USER)

							TriggerClientEvent('chat:addMessage', Source, {
								args = {"^1SYSTEM", "Level permisije igracu ^2" .. GetPlayerName(tonumber(USER)) .. "^0 je postavljen na ^2 " .. tostring(GROUP)}
							})
						else
							TriggerClientEvent('chat:addMessage', Source, {
								args = {"^1SYSTEM", "Krivi broj!"}
							})
						end
					end
				elseif t == "money" then
					if(GetPlayerName(USER) == nil)then
						TriggerClientEvent('chat:addMessage', Source, {
							args = {"^1SYSTEM", "Igrac nije pronadjen"}
						})
					else
						GROUP = tonumber(GROUP)
						if(GROUP ~= nil and GROUP > -1)then
							TriggerEvent('es:getPlayerFromId', USER, function(target)
								target.setMoney(GROUP)
							end)
						else
							TriggerClientEvent('chat:addMessage', Source, {
								args = {"^1SYSTEM", "Krivi broj!"}
							})
						end
					end
				elseif t == "bank" then
					if(GetPlayerName(USER) == nil)then
						TriggerClientEvent('chat:addMessage', Source, {
							args = {"^1SYSTEM", "Igrac nije pronadjen"}
						})
					else
						GROUP = tonumber(GROUP)
						if(GROUP ~= nil and GROUP > -1)then
							TriggerEvent('es:getPlayerFromId', USER, function(target)
								target.setBankBalance(GROUP)
								TriggerEvent("bank:balance", USER)
							end)
						else
							TriggerClientEvent('chat:addMessage', Source, {
								args = {"^1SYSTEM", "Krivi broj!"}
							})
						end
					end
				end
				else
					TriggerClientEvent('chat:addMessage', Source, {
						args = {"^1SYSTEM", "Superadmin potreban za ovo!"}
					})
				end
			end)
		end)
	else
		TriggerClientEvent('chat:addMessage', Source, {
			args = {"^1SYSTEM", "Vlasnik potreban za ovo!"}
		})
	end
end)

-- RegisterCommand('giverole', function(source, args, raw)
-- 	local player = tonumber(args[1])
-- 	local role = table.concat(args, " ", 2)
-- 	if args[1] then
-- 		if (player and GetPlayerName(player)) then
-- 			if args[2] then
-- 				TriggerEvent("es:getPlayerFromId", player, function(user)
-- 					user.giveRole(role)
-- 					TriggerClientEvent('chat:addMessage', user.get('source'), {
-- 						args = {"^1SYSTEM", "Dobili ste ulogu: ^2" .. role}
-- 					})
-- 				end)
-- 			else
-- 				RconPrint("Koristi: giverole [user-id] [uloga]\n")
-- 			end
-- 		else
-- 			RconPrint("Igrac nije u igri\n")
-- 		end
-- 	else
-- 		RconPrint("Koristi: giverole [user-id] [uloga]\n")
-- 	end
-- end, true)

-- RegisterCommand('removerole', function(source, args, raw)
-- 	local player = tonumber(args[1])
-- 	local role = table.concat(args, " ", 2)
-- 	if args[1] then
-- 		if (player and GetPlayerName(player)) then
-- 			if args[2] then
-- 				TriggerEvent("es:getPlayerFromId", tonumber(args[1]), function(user)
-- 					user.removeRole(role)
-- 					TriggerClientEvent('chat:addMessage', user.get('source'), {
-- 						args = {"^1SYSTEM", "Obrisani ste iz uloge: ^2" .. role}
-- 					})
-- 				end)
-- 			else
-- 				RconPrint("Koristi: removerole [user-id] [uloga]\n")
-- 			end
-- 		else
-- 			RconPrint("Igrac nije u igri\n")
-- 		end
-- 	else
-- 		RconPrint("Koristi: removerole [user-id] [uloga]\n")
-- 	end
-- end, true)

ESX.RegisterServerCallback("esx_marker:fetchUserRank", function(source, cb)
    local player = ESX.GetPlayerFromId(source)

    if player ~= nil then
        local playerGroup = player.getGroup()

        if playerGroup ~= nil then 
            cb(playerGroup)
        else
            cb("user")
        end
    else
        cb("user")
    end
end)

-- Default commands
TriggerEvent('es:addCommand', 'admin', function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, {
		args = {"^1SYSTEM", "Level: ^*^2 " .. tostring(user.get('permission_level'))}
	})
	TriggerClientEvent('chat:addMessage', source, {
		args = {"^1SYSTEM", "Grupa: ^*^2 " .. user.getGroup()}
	})
end, {help = "Pokazuje koji ste level admina i koja ste grupa"})
---test
TriggerEvent('es:addGroupCommand', 'viewname', "admin", function(source, args, user)
    TriggerClientEvent("es_admin:viewname", source)
end, function(source, args, user)
    TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Nemate ovlasti!")
end)
--test
-- Report to admins
TriggerEvent('es:addCommand', 'report', function(source, args, user)
	if Mutan[source] == nil or Mutan[source] == 0 then
		if args[1] ~= nil then
		TriggerClientEvent('chat:addMessage', source, {
			args = {"^1REPORT", " (^2" .. GetPlayerName(source) .. " | " .. source .. "^0) " .. table.concat(args, " ")}
		})

		TriggerEvent("es:getPlayers", function(pl)
			for k,v in pairs(pl) do
				TriggerEvent("es:getPlayerFromId", k, function(user)
					if(user.getPermissions() > 0 and k ~= source)then
						TriggerClientEvent('chat:addMessage', k, {
							args = {"^1REPORT", " (^2" .. GetPlayerName(source) .." | "..source.."^0) " .. table.concat(args, " ")}
						})
					end
				end)
			end
		end)
		else
			TriggerClientEvent('chat:addMessage', source, {
				args = {"^1SYSTEM", " /report [Tekst]"}
			})
		end
	else
		TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM ', " Morate pricekati jos "..Mutan[source].." minuta do unmutea!" } })
	end
end, {help = "Prijavite igraca ili problem", params = {{name = "report", help = "Sta zelite report"}}})

-- Noclip
TriggerEvent('es:addGroupCommand', 'noclip', "admin", function(source, args, user)
	TriggerClientEvent("es_admin:noclip", source)
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Nemate ovlasti!"} })
end, {help = "Upali ili ugasi noclip"})

TriggerEvent('es:addGroupCommand', 'fix', "admin", function(source, args, user)
	TriggerClientEvent("es_admin:fix", source)
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Nemate ovlasti!"} })
end, {help = "Popravak vozila"})

TriggerEvent('es:addGroupCommand', 'clean', "admin", function(source, args, user)
	TriggerClientEvent("es_admin:clean", source)
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Nemate ovlasti!"} })
end, {help = "Ciscenje vozila"})

function stringsplit(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t={} ; i=1
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		t[i] = str
		i = i + 1
	end
	return t
end

loadBans()

local id = 0
local ShowTag = false
local showTags = true
local seeTags = false
local isDriver = false
local staffTable = { 0 }
local TagDistance = 25
local Igraci = {}

ESX                             = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	ESX.TriggerServerCallback('tagovi:DajStaff', function(br)
		staffTable = br
	end)
end)

RegisterCommand("seeTags", function(source, args, rawCommand)
	ESX.TriggerServerCallback('esx-races:DohvatiPermisiju', function(br)
		if br == 1 then
			TriggerEvent("seeTags")
		else
			TriggerEvent('chat:addMessage', {color = { 0, 125, 255},multiline = false,args = {"[Greska]", "Nemate permisiju za ovu komandu!"}})
		end
	end)
end)

RegisterCommand("tagRange", function(source, args, rawCommand)
	TagDistance = tonumber(args[1])
	TriggerEvent('chat:addMessage', {color = { 0, 125, 255},multiline = false,args = {"[JD_PlayerID]", "Player tag distance set to: ^*^2"..TagDistance.."^0"}})
end)

RegisterNetEvent('sendStaff')
AddEventHandler('sendStaff', function(_staffTable)
	staffTable = _staffTable
end)


RegisterNetEvent('showTags')
AddEventHandler('showTags', function()
	if showTags then
		showTags = false
		TriggerEvent('chat:addMessage', {color = { 0, 125, 255},multiline = false,args = {"[JD_PlayerID]", "Player tags ^*^1Disabled^0"}})
	else
		showTags =  true
		TriggerEvent('chat:addMessage', {color = { 0, 125, 255},multiline = false,args = {"[JD_PlayerID]", "Player tags ^*^2Enabled^0"}})
	end
end)

RegisterNetEvent('seeTags')
AddEventHandler('seeTags', function()
	if seeTags then
		seeTags = false
		TriggerEvent('chat:addMessage', {color = { 0, 125, 255},multiline = false,args = {"[JD_PlayerID]", "Player tags trough walls ^*^1Disabled^0"}})
	else
		seeTags =  true
		TriggerEvent('chat:addMessage', {color = { 0, 125, 255},multiline = false,args = {"[JD_PlayerID]", "Player tags trough walls ^*^2Enabled^0"}})
	end
end)

RegisterNetEvent('tagovi:Igraci')
AddEventHandler('tagovi:Igraci', function(igr)
	Igraci = igr
end)

function ManageHeadLabels()
	for _,player in ipairs(GetActivePlayers()) do
		if NetworkIsPlayerActive(player) then
			local iPed = GetPlayerPed(player)
			local lPed = PlayerPedId()
			if iPed ~= lPed then
				if DoesEntityExist(iPed) then
					distance = math.ceil(GetDistanceBetweenCoords(GetEntityCoords(lPed), GetEntityCoords(iPed)))
					if HasEntityClearLosToEntity(lPed, iPed, 17) or seeTags then
						if distance < TagDistance and showTags then
							if NetworkIsPlayerTalking(player) then
								headDisplayId = N_0xbfefe3321a3f5015(iPed, "", false, false, "", false )
								SetMpGamerTagAlpha(headDisplayId, 4, 225)							
								SetMpGamerTagVisibility(headDisplayId, 4, true)
							else
								if has_value(staffTable,GetPlayerServerId(player)) then 
									headDisplayId = N_0xbfefe3321a3f5015(iPed, "", false, false, "Admin", false )
									SetMpGamerTagBigText(headDisplayId, "Admin")
									SetMpGamerTagVisibility(headDisplayId, 3, true)
									SetMpGamerTagColour(headDisplayId, 3, 6)
								else
									SetMpGamerTagVisibility(headDisplayId, 3, false)
								end
								SetMpGamerTagVisibility(headDisplayId, 4, false)
							end
						else
							SetMpGamerTagVisibility(headDisplayId, 3, false)
						end
					else
						SetMpGamerTagVisibility(headDisplayId, 3, false)
					end
				end
			end
		end
	end
end

function has_value (tab, val)
    for i, v in ipairs (tab) do
        if (v == val) then
            return true
        end
    end
    return false
end


Citizen.CreateThread(function()
	while true do
		ManageHeadLabels()
		Citizen.Wait(500)
	end
end)
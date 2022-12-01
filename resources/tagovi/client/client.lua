local staffTable = { 0 }
local TagDistance = 25

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

RegisterNetEvent('sendStaff')
AddEventHandler('sendStaff', function(_staffTable)
	staffTable = _staffTable
end)

function ManageHeadLabels()
	for _,player in ipairs(GetActivePlayers()) do
		if NetworkIsPlayerActive(player) then
			local iPed = GetPlayerPed(player)
			local lPed = PlayerPedId()
			if iPed ~= lPed then
				if DoesEntityExist(iPed) then
					distance = math.ceil(GetDistanceBetweenCoords(GetEntityCoords(lPed), GetEntityCoords(iPed)))
					if HasEntityClearLosToEntity(lPed, iPed, 17) then
						if distance < TagDistance then
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
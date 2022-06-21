ESX = nil
GLOBAL_PED, GLOBAL_COORDS = nil, nil

Citizen.CreateThread(function()
	while not ESX do
		TriggerEvent("esx:getSharedObject", function(library) 
			ESX = library 
		end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent("pecanje:StartFish")
AddEventHandler("pecanje:StartFish", function()
	InitFishing(false)
end)

Citizen.CreateThread(function()
	GLOBAL_PED = PlayerPedId()
	GLOBAL_COORDS = GetEntityCoords(GLOBAL_PED, true)
end)
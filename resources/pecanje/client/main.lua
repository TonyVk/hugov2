ESX = nil
GLOBAL_PED, GLOBAL_COORDS = nil, nil
local pedara = nil

Citizen.CreateThread(function()
	while not ESX do
		TriggerEvent("esx:getSharedObject", function(library) 
			ESX = library 
		end)
		Citizen.Wait(0)
	end
	ESX.TriggerServerCallback("pecanje:DohvatiKoord", function(kord)
		SpawnPeda(kord)
		SpawnBlip(kord)
	end)
end)

function SpawnPeda(kord)
	local pedmodel = GetHashKey("s_m_y_dealer_01")
	RequestModel(pedmodel)
	while not HasModelLoaded(pedmodel) do
		Wait(10)
	end
	pedara = CreatePed(0, pedmodel, kord.coord-vector3(0.0, 0.0, 1.0), kord.heading, false, true)
	SetEntityInvincible(pedara, true)
	SetBlockingOfNonTemporaryEvents(pedara, true)
	SetPedDiesWhenInjured(pedara, false)
	SetPedFleeAttributes(pedara, 2)
	FreezeEntityPosition(pedara, true)
	SetPedCanPlayAmbientAnims(pedara, false)
	SetPedCanRagdollFromPlayerImpact(pedara, false)
	exports.qtarget:AddEntityZone("ribar_prodaja", pedara, 
	{
		name="prodajar_ped",
		debugPoly=false,
		useZ = true
	}, {
		options = {
			{
				event = "ribar:ProdajRibu",
				icon = "far fa-comment",
				label = "Prodaj ribu ($"..Config.Prodaja..")"
			}
		},
		distance = 2.5
	})
	SetModelAsNoLongerNeeded(pedmodel)
end

function SpawnBlip(kord)
	local blip = AddBlipForCoord(kord.coord)
	SetBlipSprite(blip, 780)
	SetBlipDisplay(blip, 4)
	SetBlipScale(blip, 0.7)
	SetBlipCategory(blip, 3)
	SetBlipColour(blip, 5)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Prodaja ribe")
	EndTextCommandSetBlipName(blip)
end

RegisterNetEvent("ribar:ProdajRibu")
AddEventHandler('ribar:ProdajRibu', function(data)
	ESX.TriggerServerCallback('ribar:Prodaj', function(br, kol, cij)
		if br then
			ESX.ShowNotification("Prodali ste "..kol.."x riba za $"..cij)
		else
			ESX.ShowNotification("Nemate ribe za prodati!")
		end
	end)
end)

RegisterNetEvent("pecanje:StartFish")
AddEventHandler("pecanje:StartFish", function()
	InitFishing(false)
end)

Citizen.CreateThread(function()
	GLOBAL_PED = PlayerPedId()
	GLOBAL_COORDS = GetEntityCoords(GLOBAL_PED, true)
end)
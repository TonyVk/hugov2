ESX = nil
local PosaoPed = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData().posao == nil do
		Citizen.Wait(100)
	end
	ProvjeriPosao()
end)

local isInService = false
local hasAlreadyEnteredMarker = false
local lastZone                = nil
local DuznostPed              = nil
local VoziloPed 			  = nil

local tablicaVozila = ""
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}
--------------------------------------------------------------------------------
function ProvjeriPosao()
	ESX.PlayerData = ESX.GetPlayerData()
	DodajBlip()
	SpawnNpcove()
end

function DodajBlip()
	local blip = AddBlipForCoord(Config.ZaposliSe.Pos.x, Config.ZaposliSe.Pos.y, Config.ZaposliSe.Pos.z)
	SetBlipSprite  (blip, Config.ZaposliSe.Sprite)
	SetBlipDisplay (blip, 4)
	SetBlipScale   (blip, 1.2)
	SetBlipCategory(blip, 3)
	SetBlipColour  (blip, Config.ZaposliSe.BColor)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Kosac")
	EndTextCommandSetBlipName(blip)
end

function SpawnNpcove()
	if DuznostPed ~= nil then
		DeleteEntity(DuznostPed)
		exports.qtarget:RemoveZone('luka_duznost')
		DuznostPed = nil
	end
	if ESX.PlayerData.posao.name == Config.Posao then
		local pedmodel = GetHashKey("s_m_m_trucker_01")
		LoadModel(pedmodel)
		DuznostPed = CreatePed(0, pedmodel, Config.Oprema.Koord - vector3(0.0, 0.0, 1.0), Config.Oprema.Heading, false, true)
		SetEntityInvincible(DuznostPed, true)
		SetBlockingOfNonTemporaryEvents(DuznostPed, true)
		SetPedDiesWhenInjured(DuznostPed, false)
		SetPedFleeAttributes(DuznostPed, 2)
		FreezeEntityPosition(DuznostPed, true)
		SetPedCanPlayAmbientAnims(DuznostPed, false)
		SetPedCanRagdollFromPlayerImpact(DuznostPed, false)

		exports.qtarget:AddEntityZone("luka", DuznostPed, 
		{
			name="luka_duznost",
			debugPoly=false,
			useZ = true
		}, {
			options = {
				{
					event = "luka:UzmiDuznost",
					icon = "far fa-comment",
					label = _U('job_wear'),
					posao = Config.Posao
				},
				{
					event = "luka:OstaviDuznost",
					icon = "fas fa-sign-out-alt",
					label = _U('citizen_wear'),
					posao = Config.Posao
				},
			},
			distance = 2.5
		})
	else
		local pedmodel = GetHashKey("s_m_m_trucker_01")
		LoadModel(pedmodel)
		DuznostPed = CreatePed(0, pedmodel, Config.Oprema.Koord - vector3(0.0, 0.0, 1.0), Config.Oprema.Heading, false, true)
		SetEntityInvincible(DuznostPed, true)
		SetBlockingOfNonTemporaryEvents(DuznostPed, true)
		SetPedDiesWhenInjured(DuznostPed, false)
		SetPedFleeAttributes(DuznostPed, 2)
		FreezeEntityPosition(DuznostPed, true)
		SetPedCanPlayAmbientAnims(DuznostPed, false)
		SetPedCanRagdollFromPlayerImpact(DuznostPed, false)
		SetModelAsNoLongerNeeded(pedmodel)

		exports.qtarget:AddEntityZone("luka", DuznostPed, 
		{
			name="luka_duznost",
			debugPoly=false,
			useZ = true
		}, {
			options = {
				{
					event = "luka:ZaposliSe",
					icon = "far fa-comment",
					label = "Zaposlite se",
					posao ~= Config.Posao
				}
			},
			distance = 2.5
		})
	end
end

RegisterNetEvent('luka:UzmiDuznost')
AddEventHandler('luka:UzmiDuznost', function()
	isInService = true
	setUniform(PlayerPedId())
	if VoziloPed ~= nil then
		DeleteEntity(VoziloPed)
		exports.qtarget:RemoveZone('luka_vozila')
		VoziloPed = nil
	end
	local pedmodel = GetHashKey("s_m_m_trucker_01")
	VoziloPed = CreatePed(0, pedmodel, Config.SpawnVozilaPed.Koord - vector3(0.0, 0.0, 1.0), Config.SpawnVozilaPed.Heading, false, true)
	SetEntityInvincible(VoziloPed, true)
	SetBlockingOfNonTemporaryEvents(VoziloPed, true)
	SetPedDiesWhenInjured(VoziloPed, false)
	SetPedFleeAttributes(VoziloPed, 2)
	FreezeEntityPosition(VoziloPed, true)
	SetPedCanPlayAmbientAnims(VoziloPed, false)
	SetPedCanRagdollFromPlayerImpact(VoziloPed, false)
	SetModelAsNoLongerNeeded(pedmodel)

	exports.qtarget:AddEntityZone("luka2", VoziloPed, 
	{
		name="luka_vozila",
		debugPoly=false,
		useZ = true
	}, {
		options = {
			{
				event = "luka:Vozilo",
				icon = "fa fa-car",
				label = "Istovar kontenjera",
				broj = 1,
				canInteract = function(entity) return isInService end
			}
		},
		distance = 2.5,
	})
end)

RegisterNetEvent('luka:OstaviDuznost')
AddEventHandler('luka:OstaviDuznost', function()
	isInService = false
	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
		TriggerEvent('skinchanger:loadSkin', skin)
	end)
	ZavrsiPosao()
	if VoziloPed ~= nil then
		DeleteEntity(VoziloPed)
		exports.qtarget:RemoveZone('luka_vozila')
		VoziloPed = nil
	end
end)

RegisterNetEvent('luka:ZaposliSe')
AddEventHandler('luka:ZaposliSe', function()
	TriggerEvent("upit:OtvoriPitanje", "esx_luka", "Upit za posao", "Dali se zelite zaposliti kao lučki radnik?")
end)

RegisterNetEvent('luka:Vozilo')
AddEventHandler('luka:Vozilo', function(data)
	if data.broj == 1 then
		
	end
end)

LoadModel = function(model)
	RequestModel(model)

	while not HasModelLoaded(model) do
		Wait(10)
	end
end

-- MENUS
function MenuCloakRoom()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'cloakroom',
		{
			title    = _U('cloakroom'),
			elements = {
				{label = _U('job_wear'), value = 'job_wear'},
				{label = _U('citizen_wear'), value = 'citizen_wear'}
			}
		},
		function(data, menu)
			if data.current.value == 'citizen_wear' then
				if isInService then
					isInService = false
					ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
						TriggerEvent('skinchanger:loadSkin', skin)
					end)
					TriggerEvent("dpemotes:Radim", false)
				end
			end
			if data.current.value == 'job_wear' then
				if not isInService then
					isInService = true
					setUniform(PlayerPedId())
				end
			end
			menu.close()
		end,
		function(data, menu)
			menu.close()
		end
	)
end

RegisterCommand('zavrsiistovar', function(source, args, rawCommand)
	if Radis ~= nil then
		ZavrsiPosao()
	else
		ESX.ShowNotification("Ne istovarate kontenjere!")
	end
end, false)

function setUniform(playerPed)
	TriggerEvent('skinchanger:getSkin', function(skin)
		if skin.sex == 0 then
			if Config.Uniforms.EUP == false or Config.Uniforms.EUP == nil then
				if Config.Uniforms["uniforma"].male then
					TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms["uniforma"].male)
				else
					ESX.ShowNotification("Nema postavljene uniforme!")
				end
			else
				local jobic = "EUPuniforma"
				local outfit = Config.Uniforms[jobic].male
				local ped = playerPed

				RequestModel(outfit.ped)

				while not HasModelLoaded(outfit.ped) do
					Wait(0)
				end

				if GetEntityModel(ped) ~= GetHashKey(outfit.ped) then
					SetPlayerModel(PlayerId(), outfit.ped)
				end

				ped = PlayerPedId()

				for _, comp in ipairs(outfit.components) do
				   SetPedComponentVariation(ped, comp[1], comp[2] - 1, comp[3] - 1, 0)
				end

				for _, comp in ipairs(outfit.props) do
					if comp[2] == 0 then
						ClearPedProp(ped, comp[1])
					else
						SetPedPropIndex(ped, comp[1], comp[2] - 1, comp[3] - 1, true)
					end
				end
			end
			
		else
			if Config.Uniforms.EUP == false then
				if Config.Uniforms["uniforma"].female then
					TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms["uniforma"].female)
				else
					ESX.ShowNotification(_U('no_outfit'))
				end
			else
				local jobic = "EUPuniforma"
				local outfit = Config.Uniforms[jobic].female
				local ped = playerPed

				RequestModel(outfit.ped)

				while not HasModelLoaded(outfit.ped) do
					Wait(0)
				end

				if GetEntityModel(ped) ~= GetHashKey(outfit.ped) then
					SetPlayerModel(PlayerId(), outfit.ped)
				end

				ped = PlayerPedId()

				for _, comp in ipairs(outfit.components) do
				   SetPedComponentVariation(ped, comp[1], comp[2] - 1, comp[3] - 1, 0)
				end

				for _, comp in ipairs(outfit.props) do
					if comp[2] == 0 then
						ClearPedProp(ped, comp[1])
					else
						SetPedPropIndex(ped, comp[1], comp[2] - 1, comp[3] - 1, true)
					end
				end
			end


		end
	end)
end

RegisterNUICallback(
    "zatvoriupit",
    function(data, cb)
		local br = data.br
		if br == 1 then
			TriggerServerEvent('esx_joblisting:setJob', 5)
			ESX.ShowNotification("Zaposlio si se kao lucki radnik!")
		end
    end
)

function ZavrsiPosao()
	Radis = false
    isInService = false
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setPosao')
AddEventHandler('esx:setPosao', function(job)
	ESX.PlayerData.posao = job
	SpawnNpcove()
	ZavrsiPosao()
end)
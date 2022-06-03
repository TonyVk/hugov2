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
local Radis					  = false
local ScaleForm 			  = nil
Scaleforms    = mLibs:Scaleforms()

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
		local pedmodel = GetHashKey("s_m_m_dockwork_01")
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
					label = _U('radna_odjeca'),
					posao = Config.Posao
				},
				{
					event = "luka:OstaviDuznost",
					icon = "fas fa-sign-out-alt",
					label = _U('civilna_odjeca'),
					posao = Config.Posao
				},
			},
			distance = 2.5
		})
	else
		local pedmodel = GetHashKey("s_m_m_dockwork_01")
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
	if not isInService then
		isInService = true
		setUniform(PlayerPedId())
		if VoziloPed ~= nil then
			DeleteEntity(VoziloPed)
			exports.qtarget:RemoveZone('luka_vozila')
			VoziloPed = nil
		end
		local pedmodel = GetHashKey("s_m_y_dockwork_01")
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
	end
end)

RegisterNetEvent('luka:OstaviDuznost')
AddEventHandler('luka:OstaviDuznost', function()
	if isInService then
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
	end
end)

RegisterNetEvent('luka:ZaposliSe')
AddEventHandler('luka:ZaposliSe', function()
	TriggerEvent("upit:OtvoriPitanje", "esx_luka", "Upit za posao", "Dali se zelite zaposliti kao lučki radnik?")
end)

RegisterNetEvent('luka:Vozilo')
AddEventHandler('luka:Vozilo', function(data)
	if data.broj == 1 then
		ZapocniPosao()
	end
end)

function ZapocniPosao()
	Radis = true
	local removeprops = {
		"prop_dock_crane_01",
		"prop_crane_01_truck1",
		"prop_crane_01_truck2",
		"prop_dock_crane_lift"
	}
	for i = 1, #removeprops do
		CreateModelHide(991.01458740234, -2922.1516113281, 5.9021344184875, 300.0, GetHashKey(removeprops[i]), true)
	end
	local model = GetHashKey("prop_dock_crane_03")
	RequestModel(model)

	while not HasModelLoaded(model) do
		Citizen.Wait(1)
	end
	kran = CreateObjectNoOffset(model, 936.3496, -2919.401, 4.76712, false, false, false)
	SetModelAsNoLongerNeeded(model)
	FreezeEntityPosition(kran, true)
	SetEntityHeading(kran, -90.0)
	model = GetHashKey("prop_crane_01_truck2")
	RequestModel(model)

	while not HasModelLoaded(model) do
		Citizen.Wait(1)
	end
	lTocak1 = CreateObjectNoOffset(model, 929.4009, -2933.829, 7.437534, false, false, false)
	FreezeEntityPosition(lTocak1, true)
	SetEntityHeading(lTocak1, -90.0)
	lTocak2 = CreateObjectNoOffset(model, 929.4009, -2906.186, 7.437534, false, false, false)
	FreezeEntityPosition(lTocak2, true)
	SetEntityHeading(lTocak2, -90.0)
	SetModelAsNoLongerNeeded(model)

	model = GetHashKey("prop_crane_01_truck1")
	RequestModel(model)

	while not HasModelLoaded(model) do
		Citizen.Wait(1)
	end
	rTocak1 = CreateObjectNoOffset(model, 943.5405, -2933.829, 7.437534, false, false, false)
	FreezeEntityPosition(rTocak1, true)
	SetEntityHeading(rTocak1, -90.0)
	rTocak2 = CreateObjectNoOffset(model, 943.5405, -2906.186, 7.437534, false, false, false)
	FreezeEntityPosition(rTocak2, true)
	SetEntityHeading(rTocak2, -90.0)
	SetModelAsNoLongerNeeded(model)

	model = GetHashKey("prop_dock_crane_lift")
	RequestModel(model)

	while not HasModelLoaded(model) do
		Citizen.Wait(1)
	end
	lift = CreateObjectNoOffset(model, 945.3201, -2934.776, 11.34235, false, false, false)
	FreezeEntityPosition(lift, true)
	SetEntityHeading(lift, -90.0)
	SetModelAsNoLongerNeeded(model)

	model = GetHashKey("p_dock_crane_sld_s")
	RequestModel(model)

	while not HasModelLoaded(model) do
		Citizen.Wait(1)
	end
	kDizalica = CreateObjectNoOffset(model, 936.3939, -2914.303, 23.07479, false, false, false)
	FreezeEntityPosition(kDizalica, true)
	SetEntityHeading(kDizalica, -90.0)
	SetModelAsNoLongerNeeded(model)

	model = GetHashKey("port_xr_cont_03")
	RequestModel(model)

	while not HasModelLoaded(model) do
		Citizen.Wait(1)
	end
	kKont = CreateObjectNoOffset(model, 948.4851, -2889.608, 20.62049, false, false, false)
	FreezeEntityPosition(kKont, true)
	SetEntityHeading(kKont, 0.0)
	SetModelAsNoLongerNeeded(model)

	ESX.ShowNotification("Udjite u lift kako bih ste se popeli do kontrola krana!")

	local usoULift = false
	local liftKord = vector3(945.46, -2935.65, 11.19)
	while not usoULift and Radis do
		DrawMarker(0, 945.46, -2935.65, 11.19, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 3.0, 3.0, 1.0, 204, 204, 0, 100, false, true, 2, false, false, false, false)
		local kord = GetEntityCoords(PlayerPedId())
		if #(kord-liftKord) <= 1.5 then
			usoULift = true
		end
		Wait(1)
	end
	if Radis then
		while not SlideObject(
			lift, 
			945.3201,
			-2934.776,
			47.37572,
			0.01, 
			0.01, 
			0.01, 
			false
		) and Radis do
			Wait(1)
		end
		if Radis then
			TriggerEvent("MakniHud", true)
			ESX.ShowNotification("Pomjerite kran do kontenjera kako bih ste ga zakacili!")
			FreezeEntityPosition(PlayerPedId(), true)
			kamerica = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 936.3939, -2914.303, 23.07479, -20.62686, -0, -61.17438, 50.0, true, 2)
			AttachCamToEntity(
				kamerica, 
				kDizalica, 
				10.0, 
				0.0, 
				0.0, 
				true
			)
			PointCamAtEntity(kamerica, kDizalica, 0.0, 0.0, 0.0, true)
			RenderScriptCams(true, false, 0, 1, 0)
			local controls = CreateControls()
			ScaleForm = Instructional.Create(controls)
			Citizen.CreateThread(function()
				while kran ~= nil and Radis do
					DrawScaleformMovieFullscreen(ScaleForm,255,255,255,255,0)
					if IsControlPressed(0, 172) then --strelica gore
						local kord = GetOffsetFromEntityInWorldCoords(kDizalica, -0.01, 0.0, 0.0)
						--SetEntityCoords(kDizalica, kord)
						if kord.y <= -2867.357 then
							ActivatePhysics(kDizalica)
							SlideObject(
								kDizalica, 
								kord.x, 
								kord.y, 
								kord.z, 
								0.01, 
								0.01, 
								0.01, 
								true
							)
						end
					end
					if IsControlPressed(0, 173) then --strelica dolje
						local kord = GetOffsetFromEntityInWorldCoords(kDizalica, 0.01, 0.0, 0.0)
						--SetEntityCoords(kDizalica, kord)
						if kord.y >= -2926.825 then
							ActivatePhysics(kDizalica)
							SlideObject(
								kDizalica, 
								kord.x, 
								kord.y, 
								kord.z, 
								0.01, 
								0.01, 
								0.01, 
								true
							)
						end
					end
					if IsControlPressed(0, 208) then --page up
						local kord = GetOffsetFromEntityInWorldCoords(kDizalica, 0.0, 0.0, 0.01)
						--SetEntityCoords(kDizalica, kord)
						if kord.z <= 30.42496 then
							ActivatePhysics(kDizalica)
							SlideObject(
								kDizalica, 
								kord.x, 
								kord.y, 
								kord.z, 
								0.01, 
								0.01, 
								0.01, 
								true
							)
						end
					end
					if IsControlPressed(0, 207) then --page down
						local kord = GetOffsetFromEntityInWorldCoords(kDizalica, 0.0, 0.0, -0.01)
						--SetEntityCoords(kDizalica, kord)
						if kord.z >= 7.864441 then
							ActivatePhysics(kDizalica)
							SlideObject(
								kDizalica, 
								kord.x, 
								kord.y, 
								kord.z, 
								0.01, 
								0.01, 
								0.01, 
								true
							)
						end
					end
					if IsControlPressed(0, 174) then --lijevo
						local kord = GetOffsetFromEntityInWorldCoords(kDizalica, 0.0, -0.01, 0.0)
						if kord.x >= 843.3131 then
							SetEntityCoords(kDizalica, kord)
							local kord = GetOffsetFromEntityInWorldCoords(kran, 0.0, -0.01, 0.0)
							SetEntityCoords(kran, kord)

							local kord = GetOffsetFromEntityInWorldCoords(lTocak1, 0.0, -0.01, 0.0)
							SetEntityCoords(lTocak1, kord)
							local kord = GetOffsetFromEntityInWorldCoords(lTocak2, 0.0, -0.01, 0.0)
							SetEntityCoords(lTocak2, kord)
							local kord = GetOffsetFromEntityInWorldCoords(rTocak1, 0.0, -0.01, 0.0)
							SetEntityCoords(rTocak1, kord)
							local kord = GetOffsetFromEntityInWorldCoords(rTocak2, 0.0, -0.01, 0.0)
							SetEntityCoords(rTocak2, kord)

							local kord = GetOffsetFromEntityInWorldCoords(lift, 0.0, -0.01, 0.0)
							SetEntityCoords(lift, kord)
						end
					end
					if IsControlPressed(0, 175) then --desno
						local kord = GetOffsetFromEntityInWorldCoords(kDizalica, 0.0, 0.01, 0.0)
						if kord.x <= 998.7247 then
							SetEntityCoords(kDizalica, kord)
							local kord = GetOffsetFromEntityInWorldCoords(kran, 0.0, 0.01, 0.0)
							SetEntityCoords(kran, kord)

							local kord = GetOffsetFromEntityInWorldCoords(lTocak1, 0.0, 0.01, 0.0)
							SetEntityCoords(lTocak1, kord)
							local kord = GetOffsetFromEntityInWorldCoords(lTocak2, 0.0, 0.01, 0.0)
							SetEntityCoords(lTocak2, kord)
							local kord = GetOffsetFromEntityInWorldCoords(rTocak1, 0.0, 0.01, 0.0)
							SetEntityCoords(rTocak1, kord)
							local kord = GetOffsetFromEntityInWorldCoords(rTocak2, 0.0, 0.01, 0.0)
							SetEntityCoords(rTocak2, kord)

							local kord = GetOffsetFromEntityInWorldCoords(lift, 0.0, 0.01, 0.0)
							SetEntityCoords(lift, kord)
						end
					end
					Wait(1)
				end
			end)
			local KKord = GetOffsetFromEntityInWorldCoords(kKont, -7.0, 1.1, 3.5)
			local pokupio = false
			local prebacioKameru = false
			while not pokupio and Radis do
				local pKord = GetEntityCoords(kDizalica)
				DrawMarker(0, KKord, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 3.0, 3.0, 1.0, 204, 204, 0, 100, false, true, 2, false, false, false, false)
				if #(pKord-KKord) <= 10.0 and not prebacioKameru then
					prebacioKameru = true
					kamerica2 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 936.3939, -2914.303, 23.07479, -20.62686, -0, -61.17438, 50.0, true, 2)
					AttachCamToEntity(
						kamerica2, 
						kDizalica, 
						0.0, 
						0.0, 
						10.0, 
						true
					)
					PointCamAtEntity(kamerica2, kDizalica, 0.0, 0.0, 0.0, true)
					SetCamActive(kamerica2, true)
					DestroyCam(kamerica)
				end
				if #(pKord-KKord) <= 1.5 then
					pokupio = true
				end
				Wait(1)
			end
			if Radis then
				ESX.ShowNotification("Spustite kontenjer ispod krana na asfalt!")
				AttachEntityToEntity(kKont, kDizalica, GetPedBoneIndex(PlayerPedId(), 60309), 1.2, 6.0, -3.0, 0.0, 0.0, 90.0, true, true, false, true, 1, true)
				local ostavio = false
				KKord = vector3(935.86126708984, -2921.3920898438, 5.902135848999)
				while not ostavio and Radis do
					local pKord = GetOffsetFromEntityInWorldCoords(kKont, -7.0, 1.1, 3.5)
					DrawMarker(0, KKord, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 3.0, 3.0, 1.0, 204, 204, 0, 100, false, true, 2, false, false, false, false)
					if #(pKord-KKord) <= 3.0 then
						ostavio = true
					end
					Wait(1)
				end
				if Radis then
					DetachEntity(kKont, true, true)
					PlaceObjectOnGroundProperly(kKont)
					
					kamerica = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 936.3939, -2914.303, 23.07479, -20.62686, -0, -61.17438, 50.0, true, 2)
					AttachCamToEntity(
						kamerica, 
						kDizalica, 
						10.0, 
						0.0, 
						0.0, 
						true
					)
					PointCamAtEntity(kamerica, kDizalica, 0.0, 0.0, 0.0, true)
					SetCamActive(kamerica, true)
					DestroyCam(kamerica2)
					ESX.ShowNotification("Uspješno istovaren kontenjer!")
					ZavrsiPosao()
				end
			end
		end
	end
end

CreateControls = function()
	local controls
	controls = {
		[1] = Config.Controls["direction"],
		[2] = Config.Controls["height"]
	}
	return controls
  end
  
  Instructional = {}
  
  Instructional.Init = function()
	local scaleform = Scaleforms.LoadMovie('INSTRUCTIONAL_BUTTONS')
  
	Scaleforms.PopVoid(scaleform,'CLEAR_ALL')
	Scaleforms.PopInt(scaleform,'SET_CLEAR_SPACE',200) 
  
	return scaleform
  end
  
  Instructional.SetControls = function(scaleform,controls)
	for i=1,#controls,1 do
	  PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
	  PushScaleformMovieFunctionParameterInt(i-1)
	  for k=1,#controls[i].codes,1 do
		ScaleformMovieMethodAddParamPlayerNameString(GetControlInstructionalButton(0, controls[i].codes[k], true))
	  end
	  BeginTextCommandScaleformString("STRING")
	  AddTextComponentScaleform(controls[i].text)
	  EndTextCommandScaleformString()
	  PopScaleformMovieFunctionVoid()
	end
  
	Scaleforms.PopVoid(scaleform,'DRAW_INSTRUCTIONAL_BUTTONS')
	--Scaleforms.PopMulti(scaleform,'SET_BACKGROUND_COLOUR',1,1,1,1)
  end
  
  Instructional.Create = function(controls)
	local scaleform = Instructional.Init()
	Instructional.SetControls(scaleform,controls)
	return scaleform
  end

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
	if Radis ~= false then
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
	if Radis then
		Radis = false
		TriggerEvent("MakniHud", false)
		local removeprops = {
			"prop_dock_crane_01",
			"prop_crane_01_truck1",
			"prop_crane_01_truck2",
			"prop_dock_crane_lift"
		}
		DeleteEntity(kran)
		kran = nil
		DeleteEntity(rTocak1)
		DeleteEntity(rTocak2)
		DeleteEntity(lTocak1)
		DeleteEntity(lTocak2)
		DeleteEntity(lift)
		DeleteEntity(kDizalica)
		DeleteEntity(kKont)
		kKont = nil
		for i = 1, #removeprops do 
			-- This will make all hidden entities with the hash "1437508529" within 1.0 gta units visible.
			RemoveModelHide(991.01458740234, -2922.1516113281, 5.9021344184875, 300.0, GetHashKey(removeprops[i]), false)
		end
		SetEntityCoords(PlayerPedId(), 933.39813232422, -2935.7475585938, 5.9011635780334)
		FreezeEntityPosition(PlayerPedId(), false)
		RenderScriptCams(false, false, 0, 1, 0)
		DestroyCam(kamerica, false)
		DestroyCam(kamerica2, false)
	end
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
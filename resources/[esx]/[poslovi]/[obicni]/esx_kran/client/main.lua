ESX = nil

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
local DuznostPed              = nil
local VoziloPed 			  = nil
local Radis					  = false
local ScaleForm 			  = nil
Scaleforms    = mLibs:Scaleforms()

local rope = nil
local kurac = nil
local prop = nil
local attObj = nil
local attObj2 = nil
local soundID = nil
local soundID2 = nil
local soundID3 = nil
local zadnjaCoord = nil
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
	AddTextComponentString("Kranista")
	EndTextCommandSetBlipName(blip)
end

function SpawnNpcove()
	if DuznostPed ~= nil then
		DeleteEntity(DuznostPed)
		exports.qtarget:RemoveZone('kran_duznost')
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
		SetModelAsNoLongerNeeded(pedmodel)

		exports.qtarget:AddEntityZone("kran", DuznostPed, 
		{
			name="kran_duznost",
			debugPoly=false,
			useZ = true
		}, {
			options = {
				{
					event = "kran:UzmiDuznost",
					icon = "far fa-comment",
					label = _U('radna_odjeca'),
					posao = Config.Posao
				},
				{
					event = "kran:OstaviDuznost",
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

		exports.qtarget:AddEntityZone("kran", DuznostPed, 
		{
			name="kran_duznost",
			debugPoly=false,
			useZ = true
		}, {
			options = {
				{
					event = "kran:ZaposliSe",
					icon = "far fa-comment",
					label = "Zaposlite se",
					posao ~= Config.Posao
				}
			},
			distance = 2.5
		})
	end
end

RegisterNetEvent('kran:UzmiDuznost')
AddEventHandler('kran:UzmiDuznost', function()
	if not isInService then
		isInService = true
		setUniform(PlayerPedId())
		if VoziloPed ~= nil then
			DeleteEntity(VoziloPed)
			exports.qtarget:RemoveZone('kran_vozila')
			VoziloPed = nil
		end
		local pedmodel = GetHashKey("s_m_y_dockwork_01")
		LoadModel(pedmodel)
		VoziloPed = CreatePed(0, pedmodel, Config.SpawnVozilaPed.Koord - vector3(0.0, 0.0, 1.0), Config.SpawnVozilaPed.Heading, false, true)
		SetEntityInvincible(VoziloPed, true)
		SetBlockingOfNonTemporaryEvents(VoziloPed, true)
		SetPedDiesWhenInjured(VoziloPed, false)
		SetPedFleeAttributes(VoziloPed, 2)
		FreezeEntityPosition(VoziloPed, true)
		SetPedCanPlayAmbientAnims(VoziloPed, false)
		SetPedCanRagdollFromPlayerImpact(VoziloPed, false)
		SetModelAsNoLongerNeeded(pedmodel)

		exports.qtarget:AddEntityZone("kran2", VoziloPed, 
		{
			name="kran_vozila",
			debugPoly=false,
			useZ = true
		}, {
			options = {
				{
					event = "kran:Vozilo",
					icon = "fa fa-car",
					label = "Kran",
					broj = 1,
					canInteract = function(entity) return isInService end
				}
			},
			distance = 2.5,
		})
	end
end)

RegisterNetEvent('kran:OstaviDuznost')
AddEventHandler('kran:OstaviDuznost', function()
	if isInService then
		isInService = false
		ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
			TriggerEvent('skinchanger:loadSkin', skin)
		end)
		ZavrsiPosao()
		if VoziloPed ~= nil then
			DeleteEntity(VoziloPed)
			exports.qtarget:RemoveZone('kran_vozila')
			VoziloPed = nil
		end
	end
end)

RegisterNetEvent('kran:ZaposliSe')
AddEventHandler('kran:ZaposliSe', function()
	TriggerEvent("upit:OtvoriPitanje", "esx_kran", "Upit za posao", "Dali se zelite zaposliti kao kranista?")
end)

RegisterNetEvent('kran:Vozilo')
AddEventHandler('kran:Vozilo', function(data)
	if data.broj == 1 then
		ZapocniPosao()
	end
end)

function ZapocniPosao()
	if not Radis then
		TriggerEvent("NeKickaj", true)
		zadnjaCoord = GetEntityCoords(PlayerPedId())
		ESX.ShowNotification("Ukoliko zelite zavrsiti ranije upisite /zavrsikran", 5000)
		Radis = true
		soundID = GetSoundId()
		soundID2 = GetSoundId()
		soundID3 = GetSoundId()
		local AMBIENT_AUDIO_BANK = "Crane"
		local SCRIPT_AUDIO_BANK = "Container_Lifter"
		local AUDIO_SCENE = "DOCKS_HEIST_USING_CRANE"
		RequestAmbientAudioBank(AMBIENT_AUDIO_BANK, false)
		RequestScriptAudioBank(SCRIPT_AUDIO_BANK, false)

		if not IsAudioSceneActive(AUDIO_SCENE) then
			StartAudioScene(AUDIO_SCENE)
		end
		local ped = GetPlayerPed(PlayerId())
		local pedPos = GetEntityCoords(ped, false)
		TriggerEvent("MakniHud", true)
		RopeLoadTextures()
		rope = AddRope(pedPos.x, pedPos.y, pedPos.z, 0.0, 0.0, 0.0, 100.0, 2, 10.0, 1.0, 0, 0, 0, 0, 0, 0, 0)
		CreateModelHide(128.0898, -347.8978, 97.47646, 50.0, GetHashKey("prop_towercrane_02d"), true)
		local modele = "prop_dock_crane_02_hook"
		ESX.Streaming.RequestModel(modele)
		local x,y,z = table.unpack(GetEntityCoords(ped))
		prop = CreateObject(GetHashKey(modele), x, y, z+5.2, false, false, false)
		SetModelAsNoLongerNeeded(GetHashKey(modele))
		local modele2 = "prop_towercrane_03d"
		ESX.Streaming.RequestModel(modele2)
		kurac = CreateObjectNoOffset(GetHashKey(modele2), 128.0898, -347.8978, 97.47646, false, false, false)
		SetModelAsNoLongerNeeded(GetHashKey(modele2))
		FreezeEntityPosition(kurac, true)
		local x2,y2,z2 = table.unpack(GetEntityCoords(kurac))
		x,y,z = table.unpack(GetEntityCoords(prop))
		local rot = GetEntityRotation(prop, 2)
		y2 = y2-8.0
		local head = GetEntityHeading(kurac)
		AttachEntitiesToRope(
			rope, 
			kurac, 
			prop, 
			x2, 
			y2, 
			z2+4.0, 
			x, 
			y, 
			z+0.8,
			100
		)
		Wait(500)
		local len = 10.0
		StopRopeUnwindingFront(rope)
		StartRopeWinding(rope)
		RopeForceLength(rope, len)
		local koric = -8.0

		local modele3 = "prop_woodpile_02a"
		ESX.Streaming.RequestModel(modele3)
		local attKord = vector3(133.76933288574, -379.18542480469, 42.25696182251)
		attObj = CreateObject(GetHashKey(modele3), attKord.x, attKord.y, attKord.z, false, false, false)
		SetModelAsNoLongerNeeded(GetHashKey(modele3))
		SetEntityVisible(PlayerPedId(), false, 0)
		FreezeEntityPosition(PlayerPedId(), true)
		AttachEntityToEntity(PlayerPedId(), kurac, 0, -2.0, -2.0, 1.7, 0.0, 0.0, 200.0, false, false, true, false, 2, false)
		SetFollowPedCamViewMode(4)
		local controls = CreateControls()
		ScaleForm = Instructional.Create(controls)
		Citizen.CreateThread(function()
			while rope ~= nil do
				DrawScaleformMovieFullscreen(ScaleForm,255,255,255,255,0)
				DisableAllControlActions(0)
				EnableControlAction(0, 1, true) -- Enable looking horizontally
				EnableControlAction(0, 2, true) -- Enable looking vertically
				EnableControlAction(0, 245, true) -- Enable chat
				Wait(0)
			end
		end)
		Citizen.CreateThread(function()
			while rope ~= nil do
				if IsDisabledControlPressed(0, 21) then 
					if (len-0.1) > 2.2 then
						len = len-0.1
						StopRopeUnwindingFront(rope)
						StartRopeWinding(rope)
						RopeForceLength(rope, len)
						SetEntityRotation(prop, rot, 2)
						if HasSoundFinished(soundID2) then
							PlaySoundFromEntity(soundID2, "Move_U_D", kurac, "CRANE_SOUNDS", 0, 0)
							Citizen.CreateThread(function()
								while IsDisabledControlPressed(0, 21) do
									--cekam
									Wait(10)
								end
								StopSound(soundID2)
							end)
						end
					end
				end
				if IsDisabledControlPressed(0, 36) then 
					len = len+0.1
					x,y,z = table.unpack(GetEntityCoords(prop))
					StopRopeUnwindingFront(rope)
					StartRopeWinding(rope)
					RopeForceLength(rope, len)
					SetEntityRotation(prop, rot, 2)
					SetEntityCoords(prop, x, y, z-0.1)
					if HasSoundFinished(soundID2) then
						PlaySoundFromEntity(soundID2, "Move_U_D", kurac, "CRANE_SOUNDS", 0, 0)
						Citizen.CreateThread(function()
							while IsDisabledControlPressed(0, 36) do
								--cekam
								Wait(10)
							end
							StopSound(soundID2)
						end)
					end
					Wait(5)
				end
				if IsDisabledControlPressed(0, 32) then 
					if (koric-0.1) > -59.60 then
						koric = koric-0.1
						local kor = GetOffsetFromEntityInWorldCoords(kurac, 0.0, koric, 0.0)
						x,y,z = table.unpack(GetEntityCoords(prop))
						SetEntityRotation(prop, rot, 2)
						AttachEntitiesToRope(
							rope,
							kurac,
							prop,
							kor.x,
							kor.y,
							kor.z+4.0,
							x,
							y,
							z+0.8,
							100
						)
						if HasSoundFinished(soundID3) then
							PlaySoundFromEntity(soundID3, "Move_Base", kurac, "CRANE_SOUNDS", 0, 0)
							Citizen.CreateThread(function()
								while IsDisabledControlPressed(0, 32) do
									--cekam
									Wait(10)
								end
								StopSound(soundID3)
							end)
						end
						Wait(10)
						StopRopeUnwindingFront(rope)
						StartRopeWinding(rope)
						RopeForceLength(rope, len)
					end
				end
				if IsDisabledControlPressed(0, 33) then 
					if (koric+0.1) < -2.8 then
						koric = koric+0.1
						local kor = GetOffsetFromEntityInWorldCoords(kurac, 0.0, koric, 0.0)
						x,y,z = table.unpack(GetEntityCoords(prop))
						SetEntityRotation(prop, rot, 2)
						AttachEntitiesToRope(
							rope,
							kurac,
							prop,
							kor.x,
							kor.y,
							kor.z+4.0,
							x,
							y,
							z+0.8,
							100
						)
						if HasSoundFinished(soundID3) then
							PlaySoundFromEntity(soundID3, "Move_Base", kurac, "CRANE_SOUNDS", 0, 0)
							Citizen.CreateThread(function()
								while IsDisabledControlPressed(0, 33) do
									--cekam
									Wait(10)
								end
								StopSound(soundID3)
							end)
						end
						Wait(10)
						StopRopeUnwindingFront(rope)
						StartRopeWinding(rope)
						RopeForceLength(rope, len)
					end
				end
				if IsDisabledControlPressed(0, 30) then --E
					head = GetEntityHeading(kurac)
					SetEntityHeading(kurac, head-0.1)
					x2,y2,z2 = table.unpack(GetEntityCoords(kurac))
					if HasSoundFinished(soundID) then
						PlaySoundFromEntity(soundID, "Move_L_R", kurac, "CRANE_SOUNDS", 0, 0)
						Citizen.CreateThread(function()
							while IsDisabledControlPressed(0, 30) do
								--cekam
								Wait(10)
							end
							StopSound(soundID)
						end)
					end
				end
				if IsDisabledControlPressed(0, 34) then --Q
					head = GetEntityHeading(kurac)
					SetEntityHeading(kurac, head+0.1)
					x2,y2,z2 = table.unpack(GetEntityCoords(kurac))
					if HasSoundFinished(soundID) then
						PlaySoundFromEntity(soundID, "Move_L_R", kurac, "CRANE_SOUNDS", 0, 0)
						Citizen.CreateThread(function()
							while IsDisabledControlPressed(0, 34) do
								--cekam
								Wait(10)
							end
							StopSound(soundID)
						end)
					end
				end
				Citizen.Wait(0)
			end
		end)
		Citizen.CreateThread(function()
			ESX.ShowNotification("Zakacite oznaceni materijal na zemlji.")
			local ostKoord = vector3(82.227653503418, -350.54452514648, 66.197128295898)
			while #(GetEntityCoords(prop)-attKord) > 4.0 and Radis do
				DrawMarker(1, attKord.x, attKord.y, attKord.z+1.0, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 3.0, 3.0, 1.0, 204, 204, 0, 100, false, true, 2, false, false, false, false)
				Wait(1)
			end
			if Radis then
				AttachEntityToEntity(attObj, prop, 0, 0.0, 0.0, -1.5, 0.0, 0.0, 0.0, false, false, true, false, 20, false)
				ESX.ShowNotification("Otkacite materijal na oznaceno mjesto na zgradi.")
				while #(GetEntityCoords(attObj)-ostKoord) > 4.0 and Radis do
					DrawMarker(1, ostKoord.x, ostKoord.y, ostKoord.z+1.0, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 3.0, 3.0, 1.0, 204, 204, 0, 100, false, true, 2, false, false, false, false)
					Wait(1)
				end
				if Radis then
					TriggerServerEvent("kran:EoPlace")
					DetachEntity(attObj, true, true)
					SetEntityCoords(attObj, ostKoord.x, ostKoord.y, ostKoord.z)
					local modele3 = "prop_pipes_01a"
					ESX.Streaming.RequestModel(modele3)
					local attKord = vector3(133.76933288574, -379.18542480469, 42.25696182251)
					attObj2 = CreateObject(GetHashKey(modele3), attKord.x, attKord.y, attKord.z, false, false, false)
					SetModelAsNoLongerNeeded(GetHashKey(modele3))
					ESX.ShowNotification("Zakacite oznaceni materijal na zemlji.")
					ostKoord = vector3(65.93253326416, -343.82238769531, 66.197219848633)
					while #(GetEntityCoords(prop)-attKord) > 4.0 and Radis do
						DrawMarker(1, attKord.x, attKord.y, attKord.z+1.0, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 3.0, 3.0, 1.0, 204, 204, 0, 100, false, true, 2, false, false, false, false)
						Wait(1)
					end
					if Radis then
						AttachEntityToEntity(attObj2, prop, 0, 0.0, 0.0, -3.0, 0.0, 0.0, 0.0, false, false, true, false, 20, false)
						ESX.ShowNotification("Otkacite materijal na oznaceno mjesto na zgradi.")
						while #(GetEntityCoords(attObj2)-ostKoord) > 4.0 and Radis do
							DrawMarker(1, ostKoord.x, ostKoord.y, ostKoord.z+1.0, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 3.0, 3.0, 1.0, 204, 204, 0, 100, false, true, 2, false, false, false, false)
							Wait(1)
						end
						if Radis then
							TriggerServerEvent("kran:EoPlace")
							ZavrsiPosao()
						end
					end
				end
			end
		end)
	end
end

function ZavrsiPosao()
	if Radis then
		TriggerEvent("NeKickaj", false)
		Radis = false
		DetachEntity(attObj2, true, true)
		SetEntityCoords(attObj2, zadnjaCoord.x, zadnjaCoord.y, zadnjaCoord.z)
		ESX.ShowNotification("Uspjesno zavrsen posao.")
		Wait(3000)
		DetachEntity(PlayerPedId(), true, true)
		SetEntityCoords(PlayerPedId(), 123.66793823242, -353.75646972656, 42.596115112305)
		RopeUnloadTextures()
		DeleteRope(rope)
		DeleteObject(kurac)
		DeleteObject(prop)
		DeleteObject(attObj)
		DeleteObject(attObj2)
		RemoveModelHide(128.0898, -347.8978, 97.47646, 50.0, GetHashKey("prop_towercrane_02d"), false)
		SetEntityVisible(PlayerPedId(), true, 0)
		FreezeEntityPosition(PlayerPedId(), false)
		StopSound(soundID)
		ReleaseSoundId(soundID)
		StopSound(soundID2)
		ReleaseSoundId(soundID2)
		StopSound(soundID3)
		ReleaseSoundId(soundID3)
		StopAudioScene(AUDIO_SCENE)
		ReleaseAmbientAudioBank(AMBIENT_AUDIO_BANK)
		ReleaseScriptAudioBank(SCRIPT_AUDIO_BANK)
		SetFollowPedCamViewMode(1)
		TriggerEvent("MakniHud", false)
		rope = nil
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

RegisterCommand('zavrsikran', function(source, args, rawCommand)
	if Radis ~= false then
		ZavrsiPosao()
	else
		ESX.ShowNotification("Niste na kranu!")
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
				SetModelAsNoLongerNeeded(outfit.ped)
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
				SetModelAsNoLongerNeeded(outfit.ped)
			end


		end
	end)
end

RegisterNUICallback(
    "zatvoriupit",
    function(data, cb)
		local br = data.br
		if br == 1 then
			TriggerServerEvent('esx_joblisting:setJob', 6)
			ESX.ShowNotification("Zaposlio si se kao kranista!")
		end
    end
)

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
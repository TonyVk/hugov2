local TrajeVoznja = 0

local enable = false
local heading = 360.00
local signmodel = GetHashKey("prop_police_id_board")
local textmodel = GetHashKey("prop_police_id_text")
local scaleform = {}
local text = {}
local cam = nil
local cam2 = nil
local SignProp1 = {}
local SignProp2 = {}

RegisterCommand("jailmenu", function(source, args)

	if PlayerData.job.name == "police" or PlayerData.job.name == "sipa" then
		OpenJailMenu()
	else
		ESX.ShowNotification("Niste policajac!")
	end
end)

function LoadAnim(animDict)
	RequestAnimDict(animDict)

	while not HasAnimDictLoaded(animDict) do
		Citizen.Wait(10)
	end
end

function LoadModel(model)
	RequestModel(model)

	while not HasModelLoaded(model) do
		Citizen.Wait(10)
	end
end

function HideHUDThisFrame()
	HideHelpTextThisFrame()
	HideHudAndRadarThisFrame()
	HideHudComponentThisFrame(1)
	HideHudComponentThisFrame(2)
	HideHudComponentThisFrame(3)
	HideHudComponentThisFrame(4)
	HideHudComponentThisFrame(6)
	HideHudComponentThisFrame(7)
	HideHudComponentThisFrame(8)
	HideHudComponentThisFrame(9)
	HideHudComponentThisFrame(13)
	HideHudComponentThisFrame(11)
	HideHudComponentThisFrame(12)
	HideHudComponentThisFrame(15)
	HideHudComponentThisFrame(18)
	HideHudComponentThisFrame(19)
end

Citizen.CreateThread(function()
	scaleform = LoadScaleform("mugshot_board_01")
	text = CreateNamedRenderTargetForModel("ID_TEXT", textmodel)
  
	while text do
		Citizen.Wait(1)
		SetTextRenderId(text) -- set render target
		Set_2dLayer(4)
		Citizen.InvokeNative(0xC6372ECD45D73BCD, 1)
		Citizen.InvokeNative(0xC6372ECD45D73BCD, 0)
		Citizen.InvokeNative(0xC6372ECD45D73BCD, 1)
		DrawScaleformMovie(scaleform, 0.40, 0.35, 0.80, 0.75, 255, 255, 255, 255, 0)
		Citizen.InvokeNative(0xC6372ECD45D73BCD, 0)
		SetTextRenderId(GetDefaultScriptRendertargetRenderId())
	end
end)

function LoadScaleform (scaleform)
    local text = RequestScaleformMovie(scaleform)

    if text ~= 0 then
        while not HasScaleformMovieLoaded(text) do
            Citizen.Wait(0)
        end
    end

    return text
end

function CreateNamedRenderTargetForModel(name, model)
    local text = 0
    if not IsNamedRendertargetRegistered(name) then
        RegisterNamedRendertarget(name, 0)
    end
    if not IsNamedRendertargetLinked(model) then
        LinkNamedRendertarget(model)
    end
    if IsNamedRendertargetRegistered(name) then
        text = GetNamedRendertargetRenderId(name)
    end

    return text
end

function Cutscene2()
	TriggerServerEvent("jail:PostaviBucket", GetPlayerServerId(PlayerId()))
	Visible()
	TriggerEvent("charselect:animation", true)
end

function Visible()
    while enable == true do
        Citizen.Wait(0)
        Collision()
    end
end

RegisterNetEvent("charselect:animation")
AddEventHandler("charselect:animation", function(status)
    Citizen.CreateThread(function()
        local ped = PlayerPedId()
        enable = true
        Session()
        CreateCam()
        TriggerServerEvent("charselect:createsign") 
        AnimationIntro()
        SpawnCharacter()   
        Citizen.Wait(5000)
        if status == true then
			RequestAnimDict("mp_character_creation@customise@male_a")
			TaskPlayAnim(PlayerPedId(), "mp_character_creation@customise@male_a", "loop", 8.0, -8.0, -1, 0, 1, 0, 0, 0)
			Citizen.Wait(5000)
			SpawnEntity()
        end
    end)
end)

function Session()
    Citizen.Wait(1000)
    DoScreenFadeOut(1000)
    Citizen.Wait(10000)
	SetEntityCoords(PlayerPedId(), 409.42, -1001.14, -99.90, 0.0, 0.0, 0.0, true)
    SetEntityHeading(PlayerPedId(), 350.0)
    DisplayRadar(false) 
    DoScreenFadeIn(1000)
end

function SpawnEntity()
    RequestAnimDict("mp_character_creation@lineup@male_a")
    TaskPlayAnim(PlayerPedId(), "mp_character_creation@lineup@male_a", "outro", 1.0, 1.0, 9000, 0, 1, 0, 0, 0)
    Citizen.Wait(8000)
    DoScreenFadeOut(1000)
    Citizen.Wait(1000)
    DeleteObject(SignProp1)
    DeleteObject(SignProp2)
	TriggerServerEvent("jail:PostaviBucket", 0)
	local JailPosition = Config.JailPositions["Cell"]
	SetEntityCoords(PlayerPed, JailPosition["x"], JailPosition["y"], JailPosition["z"])
	InJail()
	SetEntityInvincible(PlayerPedId(), false)
	SetEntityHealth(PlayerPedId(), GetEntityMaxHealth(PlayerPedId()))
	Citizen.Wait(1000)
	DoScreenFadeIn(250)
	TriggerServerEvent("InteractSound_SV:PlayOnSource", "cell", 0.3)
    RenderScriptCams(false, true, 500, true, true)                                              
    enable = false
    DisplayRadar(true)
    Collision(false)
end

function Collision()
    for i=1,256 do
        if NetworkIsPlayerActive(i) then
            SetEntityVisible(GetPlayerPed(i), false, false)
            SetEntityVisible(PlayerPedId(), true, true)
            SetEntityNoCollisionEntity(GetPlayerPed(i), GetPlayerPed(-1), false)
        end
    end
end

function AnimationIntro()
    RequestAnimDict("mp_character_creation@lineup@male_a")
    Citizen.Wait(100)
    TaskPlayAnim(PlayerPedId(), "mp_character_creation@lineup@male_a", "intro", 1.0, 1.0, 5900, 0, 1, 0, 0, 0)
    Citizen.Wait(5700)
    RequestAnimDict("mp_character_creation@customise@male_a")
    Citizen.Wait(100)
    TaskPlayAnim(PlayerPedId(), "mp_character_creation@customise@male_a", "loop", 1.0, 1.0, -1, 0, 1, 0, 0, 0)
end

function SpawnCharacter()
    cam2 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 413.40, -998.43, -99.01, 0.00, 0.00, 89.75, 50.00, false, 0)
    PointCamAtCoord(cam2, 413.40, -998.43, -99.01)
    SetCamActiveWithInterp(cam2, cam, 5000, true, true)
end

function CreateCam()
    cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 415.55, -998.50, -99.29, 0.00, 0.00, 89.75, 50.00, false, 0)
    SetCamActive(cam, true)
    RenderScriptCams(true, false, 2000, true, true) 
end

RegisterNetEvent("charselect:createsign")
AddEventHandler("charselect:createsign", function(name, job, money) 
    SignProp1 = CreateObject(signmodel, 1, 1, 1, false, true, false)
    SignProp2 = CreateObject(textmodel, 1, 1, 1, false, true, false)

    AttachEntityToEntity(SignProp1, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 58868), 0.12, 0.24, 0.0, 5.0, 0.0, 70.0, true, true, false, false, 2, true);
    AttachEntityToEntity(SignProp2, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 58868), 0.12, 0.24, 0.0, 5.0, 0.0, 70.0, true, true, false, false, 2, true);

    local ScaleformMovie = RequestScaleformMovie("MUGSHOT_BOARD_01")

    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(0)
    end

    while HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(0)
        PushScaleformMovieFunction(ScaleformMovie, "SET_BOARD")
        PushScaleformMovieFunctionParameterString(job)
        PushScaleformMovieFunctionParameterString(name)
        PushScaleformMovieFunctionParameterString("LOS SANTOS POLICE DEPT")
        PushScaleformMovieFunctionParameterString(money)
        PushScaleformMovieFunctionParameterString(0)
        PushScaleformMovieFunctionParameterString(5)
        PushScaleformMovieFunctionParameterString(0)
        PopScaleformMovieFunctionVoid()
    end
end)

function Cutscene()
	DoScreenFadeOut(100)

	Citizen.Wait(250)

	local Male = GetHashKey("mp_m_freemode_01")

	TriggerEvent('skinchanger:getSkin', function(skin)
		if GetHashKey(GetEntityModel(PlayerPedId())) == Male then
			local clothesSkin = {
				['tshirt_1'] = 20, ['tshirt_2'] = 15,
				['torso_1'] = 33, ['torso_2'] = 0,
				['arms'] = 0,
				['pants_1'] = 7, ['pants_2'] = 0,
				['shoes_1'] = 34, ['shoes_2'] = 0,
			}
			TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)

		else
			local clothesSkin = {
				['tshirt_1'] = 15, ['tshirt_2'] = 0,
				['torso_1'] = 2, ['torso_2'] = 6,
				['arms'] = 2,
				['pants_1'] = 2, ['pants_2'] = 0,
				['shoes_1'] = 35, ['shoes_2'] = 0,
			}
			TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
		end
	end)

	LoadModel(-1320879687)

	local PolicePosition = Config.Cutscene["PolicePosition"]
	local Police = CreatePed(5, -1320879687, PolicePosition["x"], PolicePosition["y"], PolicePosition["z"], PolicePosition["h"], false)
	TaskStartScenarioInPlace(Police, "WORLD_HUMAN_PAPARAZZI", 0, false)

	local PlayerPosition = Config.Cutscene["PhotoPosition"]
	local PlayerPed = PlayerPedId()
	SetEntityCoords(PlayerPed, PlayerPosition["x"], PlayerPosition["y"], PlayerPosition["z"] - 1)
	SetEntityHeading(PlayerPed, PlayerPosition["h"])
	FreezeEntityPosition(PlayerPed, true)

	Cam()

	Citizen.Wait(1000)

	DoScreenFadeIn(100)

	Citizen.Wait(10000)

	DoScreenFadeOut(250)
	Citizen.Wait(500)
	DestroyCam(Config.Cutscene["CameraPos"]["cameraId"])
	RenderScriptCams(false,  false,  0,  true,  true)
	
	local ped = PlayerPedId()
	local hashVehicule = "pbus"
	local pilotModel = GetHashKey("s_m_y_sheriff_01")
	local voza
	local pilot
	RequestModel(pilotModel)
	while not HasModelLoaded(pilotModel) do
		Citizen.Wait(0)
	end
	if HasModelLoaded(pilotModel) then
		ESX.Streaming.RequestModel(hashVehicule)
		local retval = GetHashKey(hashVehicule)
		voza = CreateVehicle(hashVehicule, 2309.3706054688, 2994.1384277344, 47.356475830078, 63.992919921875, false, false)
		pilot = CreatePedInsideVehicle(voza, 6, pilotModel, -1, false, false)
		TaskWarpPedIntoVehicle(ped,  voza,  2)
		SetVehicleDoorsLocked(voza, 4)
		TaskVehicleDriveToCoord(pilot, voza, 1852.4729003906, 2608.1918945312, 45.889236450196, 26.0, 0, GetEntityModel(voza), 411, 10.0)
		SetPedKeepTask(pilot, true)
		SetModelAsNoLongerNeeded(hashVehicule)
		SetModelAsNoLongerNeeded(pilotModel)
		FreezeEntityPosition(ped, true)
		SetEntityInvincible(ped, true)
		TrajeVoznja = 1
	end
	Citizen.Wait(500)
	DoScreenFadeIn(250)
	Citizen.CreateThread(function()
		local nekakoord = vector3(1852.4729003906, 2608.1918945312, 45.889236450196)
		while TrajeVoznja == 1 do
			local corda = GetEntityCoords(PlayerPedId())
			if #(corda-nekakoord) <= 10 then
			--if GetDistanceBetweenCoords(corda, 1852.4729003906, 2608.1918945312, 45.889236450196, false) <= 10 then
				ESX.Game.DeleteVehicle(voza)
				RemovePedElegantly(pilot)
				TrajeVoznja = 0
				DoScreenFadeOut(250)
				local JailPosition = Config.JailPositions["Cell"]
				SetEntityCoords(PlayerPed, JailPosition["x"], JailPosition["y"], JailPosition["z"])
				InJail()
				DeleteEntity(Police)
				SetModelAsNoLongerNeeded(-1320879687)
				FreezeEntityPosition(PlayerPed, false)
				SetEntityInvincible(PlayerPed, false)
				SetEntityHealth(playerPed, GetEntityMaxHealth(playerPed))

				Citizen.Wait(1000)

				DoScreenFadeIn(250)

				TriggerServerEvent("InteractSound_SV:PlayOnSource", "cell", 0.3)

				RenderScriptCams(false,  false,  0,  true,  true)
				FreezeEntityPosition(PlayerPed, false)
				DestroyCam(Config.Cutscene["CameraPos"]["cameraId"])
			end
			Citizen.Wait(1)
		end
	end)
end

function Cam()
	local CamOptions = Config.Cutscene["CameraPos"]

	CamOptions["cameraId"] = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)

    SetCamCoord(CamOptions["cameraId"], CamOptions["x"], CamOptions["y"], CamOptions["z"])
	SetCamRot(CamOptions["cameraId"], CamOptions["rotationX"], CamOptions["rotationY"], CamOptions["rotationZ"])

	RenderScriptCams(true, false, 0, true, true)
end

function TeleportPlayer(pos)

	local Values = pos

	if #Values["goal"] > 1 then

		local elements = {}

		for i, v in pairs(Values["goal"]) do
			table.insert(elements, { label = v, value = v })
		end

		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'teleport_jail',
			{
				title    = "Izaberite poziciju",
				align    = 'center',
				elements = elements
			},
		function(data, menu)

			local action = data.current.value
			local position = Config.Teleports[action]

			if action == "Jail" or action == "Security" then

				if PlayerData.job.name ~= "police" and PlayerData.job.name ~= "sipa" then
					ESX.ShowNotification("Nemate kljuc!")
					return
				end
			end

			menu.close()

			DoScreenFadeOut(100)

			Citizen.Wait(250)

			SetEntityCoords(PlayerPedId(), position["Pos"])

			Citizen.Wait(250)

			DoScreenFadeIn(100)
			
		end,

		function(data, menu)
			menu.close()
		end)
	else
		local position = Config.Teleports[Values["goal"][1]]

		DoScreenFadeOut(100)

		Citizen.Wait(250)

		SetEntityCoords(PlayerPedId(), position["Pos"])

		Citizen.Wait(250)

		DoScreenFadeIn(100)
	end
end

Citizen.CreateThread(function()
	local blip = AddBlipForCoord(Config.Teleports["Boiling Broke"]["Pos"])

    SetBlipSprite (blip, 188)
    SetBlipDisplay(blip, 4)
    SetBlipScale  (blip, 0.8)
    SetBlipColour (blip, 49)
    SetBlipAsShortRange(blip, true)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Zatvor')
    EndTextCommandSetBlipName(blip)
end)
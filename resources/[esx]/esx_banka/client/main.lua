--[[
  -Fali jos dodavanje objekta bankomata i ako cu stavljat odmah oduzimanje iznosa s bankomata
]]

ESX                         = nil
local inMenu = false
local atbank = false
local perm 						= 0
local Bankomati = {}
local Blipovi = {}
local Objekti = {}
Scaleforms    = mLibs:Scaleforms()

--
-- MAIN THREAD
--

Citizen.CreateThread(function()
  while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
  Wait(500)
	ESX.TriggerServerCallback('esx-races:DohvatiPermisiju', function(br)
		perm = br
	end)
  ESX.TriggerServerCallback('atm:DohvatiBankomate', function(ba)
		Bankomati = ba
		SpawnBlipove()
    SpawnBankomate()
	end)
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		print("stopirano")
    for i=1, #Blipovi, 1 do
      RemoveBlip(Blipovi[i].blip)
    end
    for i=1, #Objekti, 1 do
      DeleteObject(Objekti[i].objekt)
    end
	end
end)

RegisterKeyMapping('+banka', 'Banka', 'keyboard', 'E')
-- Main thread
RegisterCommand('-banka', function()
	---prazno mora biti
end, false)
RegisterCommand('+banka', function()
  local igrac = PlayerPedId()
  if nearBankorATM() then
    local atm = GetDesATM(igrac)
    if atm == nil then
      inMenu = true
      SetNuiFocus(true,true)
      SendNUIMessage({type = 'openGeneral', banka = atbank})
      ESX.TriggerServerCallback('banka:DohvatiKredit', function(br)
        SendNUIMessage({
          type = "narediKredit",
          kredit = br.kredit,
          rata = br.rata
        })
      end)
      TriggerServerEvent('banka::server:balance', inMenu)
    else
      ESX.ShowNotification("Bankomat je razvaljen!")
    end
  end
end, false)

--
-- BLIPS
--

Citizen.CreateThread(function()
  for k,v in ipairs(Config.Zonas["banks"])do
  local blip = AddBlipForCoord(v.x, v.y, v.z)
  SetBlipSprite (blip, 434)
  SetBlipDisplay(blip, 4)
  SetBlipScale  (blip, 0.65)
  SetBlipColour (blip, 2)
  SetBlipAsShortRange(blip, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString(tostring(v.name))
  EndTextCommandSetBlipName(blip)
  end
end)

function SpawnBankomate()
	for i=1, #Objekti, 1 do
		DeleteObject(Objekti[i].objekt)
	end
  Objekti = {}
	for i=1, #Bankomati, 1 do
		if Bankomati[i] ~= nil then
			if Bankomati[i].bKoord then
        local model = GetHashKey(Bankomati[i].Objekt)
        RequestModel(model)
        while not HasModelLoaded(model) do
          Citizen.Wait(1)
        end
        local obj = CreateObjectNoOffset(model, Bankomati[i].bKoord, false)
        SetEntityHeading(obj, tonumber(Bankomati[i].Heading))
        table.insert(Objekti, {ID = Bankomati[i].ID, objekt = obj})
        SetModelAsNoLongerNeeded(model)
			end
		end
	end
end

function SpawnBlipove()
	for i=1, #Blipovi, 1 do
		RemoveBlip(Blipovi[i].blip)
	end
  Blipovi = {}
	for i=1, #Bankomati, 1 do
		if Bankomati[i] ~= nil then
			if Bankomati[i].Koord then
        local blip = AddBlipForCoord(Bankomati[i].Koord)
        SetBlipSprite (blip, 277)
        SetBlipDisplay(blip, 4)
        SetBlipScale  (blip, 0.5)
        SetBlipColour (blip, 2)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("ATM")
        EndTextCommandSetBlipName(blip)
        table.insert(Blipovi, {ID = Bankomati[i].ID, blip = blip})
			end
		end
	end
end

for i=1, #Config.ATM, 1 do
  exports.qtarget:AddTargetModel({GetHashKey(Config.ATM[i])}, {
    options = {
      {
        event = "bankomat:OtvoriMenu",
        icon = "fas fa-box-circle-check",
        label = "Otvori menu"
      }
    },
    distance = 2
  })
end

--Pljacka bankomata
local gas = nil
local desATM = nil
local desATM2 = nil
local cachedData = {}
local stariSkin = nil

ToggleBag=function(N)
	TriggerEvent("skinchanger:getSkin",function(O)
		if O.sex==0 then 
			local P={["bags_1"]=0,["bags_2"]=0}
			if N then 
				P={["bags_1"]=45,["bags_2"]=0}
			end;
			TriggerEvent("skinchanger:loadClothes",O,P)
		else 
			local P={["bags_1"]=0,["bags_2"]=0}
			TriggerEvent("skinchanger:loadClothes",O,P)
		end 
	end)
end;

LoadModels=function(a2)
	for L,a3 in ipairs(a2)do 
		if IsModelValid(a3)then 
			while not HasModelLoaded(a3)do 
				RequestModel(a3)
				Citizen.Wait(10)
			end 
		else 
			while not HasAnimDictLoaded(a3)do
				RequestAnimDict(a3)
				Citizen.Wait(10)
			end 
		end 
	end 
end;

RegisterNetEvent('atm:ZapocniPljacku')
AddEventHandler('atm:ZapocniPljacku', function()
  local atm = GetATM(GetEntityCoords(PlayerPedId()))
	if atm ~= nil then
    local atm2 = GetDesATM(PlayerPedId())
    if atm2 == nil then
      local players, nearbyPlayer = ESX.Game.GetPlayersInArea(GetEntityCoords(PlayerPedId()), 6.0)
      print(#players)
      if #players <= 1 then
        ESX.TriggerServerCallback('esx_vangelico_robbery:conteggio', function(CopsConnected)
          if CopsConnected >= Config.Policija then
            TriggerServerEvent("atm:ObrisiBocu")
            TriggerEvent("esx_invh:closeinv")
            local alarm = math.random(1,10)
            if alarm == 1 or alarm == 3 or alarm == 5 or alarm == 7 or alarm == 9 then
              local pKoord = GetEntityCoords(PlayerPedId())
              local PlayerCoords = { x = pKoord.x, y = pKoord.y, z = pKoord.z }
              TriggerServerEvent('esx_addons_gcphone:startCall', 'police', "Pljacka bankomata", PlayerCoords, {
                PlayerCoords = { x = pKoord.x, y = pKoord.y, z = pKoord.z },
              })
            end
            local model = "prop_gascyl_01a"
            RequestModel(model)
            while not HasModelLoaded(model) do
                Wait(1)
            end
            local playerPed = PlayerPedId()
            local koord = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 0.3, -1.0)
            --anim@mp_fireworks place_firework_1_rocket
            RequestAnimDict("anim@mp_fireworks")
            while not HasAnimDictLoaded("anim@mp_fireworks") do
              Citizen.Wait(1)
            end
            TaskPlayAnim(PlayerPedId(),"anim@mp_fireworks","place_firework_1_rocket", 8.0, -8, 2000, 2, 0, 0, 0, 0)
            RemoveAnimDict("anim@mp_fireworks")
            Wait(2000)
            gas = CreateObject(GetHashKey(model), koord.x, koord.y, koord.z, true, true, true)
            SetEntityInvincible(gas, true)
            FreezeEntityPosition(gas, true)
            SetModelAsNoLongerNeeded(model)
            ESX.ShowNotification("Zapalili ste plinsku bocu!")
            local rand = math.random(100, 6000)
            Citizen.SetTimeout(rand, function()
              local weapon = "WEAPON_PISTOL"
              RequestWeaponAsset(GetHashKey(weapon)) 
              while not HasWeaponAssetLoaded(GetHashKey(weapon)) do
                Wait(1)
              end
              ShootSingleBulletBetweenCoords(
                koord.x, koord.y, koord.z+1.0, 
                koord.x, koord.y, koord.z, 
                1.0, 
                true, 
                GetHashKey(weapon), 
                false, 
                false, 
                true
              )
              RemoveWeaponAsset(GetHashKey(weapon))
              rand = math.random(100, 6000)
              Citizen.SetTimeout(rand, function()
                AddExplosion(koord.x, koord.y, koord.z, 27, 1.0, true, false, 0.49)
                DeleteEntity(gas)
                gas = nil
              end)
            end)
          else
            ESX.ShowNotification("Potrebno je barem "..Config.Policija.." policajca!")
          end
        end)
      else
        ESX.ShowNotification("Drugi igrac vam je previse blizu!")
      end
    else
      ESX.ShowNotification("Bankomat je vec raznesen!")
    end
  else
    ESX.ShowNotification("Niste blizu bankomata!")
  end
end)

RegisterNetEvent('atm:JelBlizuBankomat')
AddEventHandler('atm:JelBlizuBankomat', function(koord)
	DeleteEntity(gas)
	gas = nil
	local atm = GetATM(koord)
	if atm ~= nil then
		ESX.ShowNotification("Zapoceli ste pljacku bankomata!")
		local obj = atm.objekt

		local atmKord = GetOffsetFromEntityInWorldCoords(obj, 0.0, -0.09, 0.0)
		local atmKord2 = GetOffsetFromEntityInWorldCoords(obj, 0.0, -3.0, 0.0)

		atm.model = atm.model:sub(5)
		local model = "loq"..atm.model.."_des"
		local model2 = "loq"..atm.model.."_console"
		local atmHead = GetEntityHeading(obj)
		RequestModel(model)
		while not HasModelLoaded(model) do
			Wait(1)
		end
		desATM = CreateObjectNoOffset(GetHashKey(model), atmKord.x, atmKord.y, atmKord.z, true, true, true)
		SetEntityHeading(desATM, atmHead)
		FreezeEntityPosition(desATM, true)
		SetModelAsNoLongerNeeded(model)
    local netObj = ObjToNet(desATM)
    local netKoord = GetEntityCoords(desATM)
    TriggerServerEvent("atm:SpremiPljacku", netObj, netKoord)

		RequestModel(model2)
		while not HasModelLoaded(model2) do
			Wait(1)
		end
		desATM2 = CreateObjectNoOffset(GetHashKey(model2), atmKord2.x, atmKord2.y, atmKord2.z, true, true, true)
		SetEntityHeading(desATM2, atmHead)
		ActivatePhysics(desATM2)
		SetModelAsNoLongerNeeded(model2)
	end
end)

function GetATM(koord)
	for k,v in pairs({"prop_atm_02", "prop_atm_03", "prop_fleeca_atm"}) do 
		local obj = GetClosestObjectOfType(koord, 2.0, GetHashKey(v))
		if DoesEntityExist(obj) then
			local data = {
				objekt = obj,
				model = v
			}
			return data
		end
	end
	return nil
end

function GetATM2(koord)
	for k,v in pairs({"prop_atm_01", "prop_atm_02", "prop_atm_03", "prop_fleeca_atm"}) do 
		local obj = GetClosestObjectOfType(koord, 2.0, GetHashKey(v))
		if DoesEntityExist(obj) then
			local data = {
				objekt = obj,
				model = v
			}
			return data
		end
	end
	return nil
end

function GetDesATM(ent)
	for k,v in pairs({"loq_atm_02_des", "loq_atm_03_des", "loq_fleeca_atm_des"}) do 
		local obj = GetClosestObjectOfType(GetEntityCoords(ent), 2.0, GetHashKey(v))
		if DoesEntityExist(obj) then
			local koord = GetEntityCoords(obj)
			local data = {
				objekt = obj,
				netID = ObjToNet(obj),
				koord = koord
			}
			return data
		end
	end
	return nil
end

exports.qtarget:AddTargetModel({"loq_atm_02_des", "loq_atm_03_des", "loq_fleeca_atm_des"}, {
	options = {
	{
		event = "atm:Opljackaj",
		icon = "fas fa-box-circle-check",
		label = "Opljackaj bankomat"
	}
	},
	distance = 5
})

RegisterNetEvent('atm:Opljackaj')
AddEventHandler('atm:Opljackaj', function(data)
  local ent = data.entity
	local atm = GetDesATM(ent)
	if atm ~= nil then
    ESX.TriggerServerCallback('atm:MorelPljacka', function(br)
      if br then
        local players, nearbyPlayer = ESX.Game.GetPlayersInArea(GetEntityCoords(PlayerPedId()), 6.0)
        if #players <= 1 then
          local ped = PlayerPedId()
          local pKoord = GetEntityCoords(ped)
          local Pljackaj = function()
            local pKoord = GetEntityCoords(ped)
            local model = GetHashKey("hei_prop_heist_cash_pile")
            LoadModels({model})
            local kesObj = CreateObject(model, pKoord, true)
            FreezeEntityPosition(kesObj,true)
            SetEntityInvincible(kesObj,true)
            SetEntityNoCollisionEntity(kesObj,ped)
            SetEntityVisible(kesObj,false,false)
            AttachEntityToEntity(kesObj,ped,GetPedBoneIndex(ped,60309),0.0,0.0,0.0,0.0,0.0,0.0,false,false,false,false,0,true)
            local gTime = GetGameTimer()
            Citizen.CreateThread(function()
              while GetGameTimer()-gTime<37000 do 
                Citizen.Wait(0)
                DisableControlAction(0,73,true)
                if HasAnimEventFired(ped,GetHashKey("CASH_APPEAR"))then 
                  if not IsEntityVisible(kesObj)then 
                    SetEntityVisible(kesObj,true,false)
                  end 
                end;
                if HasAnimEventFired(ped,GetHashKey("RELEASE_CASH_DESTROY"))then 
                  if IsEntityVisible(kesObj)then 
                    SetEntityVisible(kesObj,false,false)
                    TriggerServerEvent("atm:DajLovu")
                  end 
                end 
              end;
              DeleteObject(kesObj)
            end)
          end;
          LoadModels({GetHashKey("hei_p_m_bag_var22_arm_s"),"anim@heists@ornate_bank@grab_cash"})
          while not NetworkHasControlOfEntity(desATM)do 
            Citizen.Wait(0)
            NetworkRequestControlOfEntity(desATM)
          end;
          cachedData["bag"] = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"),GetEntityCoords(PlayerPedId()),true,false,false)
          ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
            stariSkin = skin
          end)
          ToggleBag(false)
          local rot = GetEntityRotation(desATM)
          local koord = GetEntityCoords(desATM)
          rot = vector3(rot.x, rot.y, rot.z+180.0)
          koord = vector3(koord.x, koord.y, pKoord.z-0.55)
          cachedData["scene"] = NetworkCreateSynchronisedScene(koord,rot,2,false,false,1065353216,0,1.3)
          NetworkAddPedToSynchronisedScene(ped,cachedData["scene"],"anim@heists@ornate_bank@grab_cash","intro",1.5,-4.0,1,16,1148846080,0)
          NetworkAddEntityToSynchronisedScene(cachedData["bag"],cachedData["scene"],"anim@heists@ornate_bank@grab_cash","bag_intro",4.0,-8.0,1)
          NetworkStartSynchronisedScene(cachedData["scene"])
          Citizen.Wait(1500)
          Pljackaj()
          cachedData["scene"] = NetworkCreateSynchronisedScene(koord,rot,2,false,false,1065353216,0,1.3)
          NetworkAddPedToSynchronisedScene(ped,cachedData["scene"],"anim@heists@ornate_bank@grab_cash","grab",1.5,-4.0,1,16,1148846080,0)
          NetworkAddEntityToSynchronisedScene(cachedData["bag"],cachedData["scene"],"anim@heists@ornate_bank@grab_cash","bag_grab",4.0,-8.0,1)
          NetworkStartSynchronisedScene(cachedData["scene"])
          Citizen.Wait(37000)
          cachedData["scene"] = NetworkCreateSynchronisedScene(koord,rot,2,false,false,1065353216,0,1.3)
          NetworkAddPedToSynchronisedScene(ped,cachedData["scene"],"anim@heists@ornate_bank@grab_cash","exit",1.5,-4.0,1,16,1148846080,0)
          NetworkAddEntityToSynchronisedScene(cachedData["bag"],cachedData["scene"],"anim@heists@ornate_bank@grab_cash","bag_exit",4.0,-8.0,1)
          NetworkStartSynchronisedScene(cachedData["scene"])
          Citizen.Wait(1900)
          DeleteObject(cachedData["bag"])
          DeleteObject(desATM2)
          --ToggleBag(true)
          TriggerEvent('skinchanger:loadSkin', stariSkin)
          RemoveAnimDict("anim@heists@ornate_bank@grab_cash")
          SetModelAsNoLongerNeeded(GetHashKey("hei_p_m_bag_var22_arm_s"))
          TriggerServerEvent("atm:MakniPljackas")
        else
          ESX.ShowNotification("Drugi igrac vam je previse blizu!")
        end
      else
        ESX.ShowNotification("Ovaj bankomat je opljackan vec!")
      end
    end, atm.netID)
	end
end)

RegisterCommand("testgas2", function(source, args, raw)
	DeleteEntity(gas)
	DeleteEntity(desATM)
	DeleteEntity(desATM2)
end)
-------------------

RegisterNetEvent('bankomat:OtvoriMenu')
AddEventHandler('bankomat:OtvoriMenu', function(atm)
  ExecuteCommand("+banka")
end)

RegisterNetEvent('atm:VratiBankomate')
AddEventHandler('atm:VratiBankomate', function(atm)
	Bankomati = atm
	SpawnBlipove()
  SpawnBankomate()
end)

RegisterCommand("urediatm", function(source, args, raw)
  if perm == 1 then
      local elements = {}
      
      table.insert(elements, {label = "Dodaj ATM", value = "novi"})
      for i=1, #Bankomati, 1 do
          if Bankomati[i] ~= nil then
              table.insert(elements, {label = "Bankomat "..Bankomati[i].ID, value = Bankomati[i].ID})
          end
      end

      ESX.UI.Menu.Open(
          'default', GetCurrentResourceName(), 'ubank',
          {
              title    = "Izaberite bankomat",
              align    = 'top-left',
              elements = elements,
          },
          function(data, menu)
      if data.current.value == "novi" then
        menu.close()
        local coord = GetEntityCoords(PlayerPedId())
        TriggerServerEvent("atm:DodajBankomat", coord)
        Wait(500)
        ExecuteCommand("urediatm")
      else
        local pID = data.current.value
        menu.close()
        local id
        for i = 1, #Bankomati do
          if Bankomati[i].ID == pID then
            id = i
            break
          end
        end
        elements = {}
        --table.insert(elements, {label = "Postavi koordinate teksta", value = "koord"})
        table.insert(elements, {label = "Postavi objekt bankomata", value = "bobj"})
        table.insert(elements, {label = "Uredi objekt bankomata", value = "ubobj"})
        table.insert(elements, {label = "Obrisi objekt bankomata", value = "obobj"})
        table.insert(elements, {label = "Portaj se", value = "port"})
        --table.insert(elements, {label = "Promjeni iznos na bankomatu", value = "iznos"})
        table.insert(elements, {label = "Obrisi bankomat", value = "obrisi"})
        ESX.UI.Menu.Open(
          'default', GetCurrentResourceName(), 'ubankomat',
          {
            title    = "Izaberite opciju",
            align    = 'top-left',
            elements = elements,
          },
          function(data2, menu2)
            if data2.current.value == "iznos" then
              ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'pcijatm', {
                title = "Upisite novi iznos na bankomatu",
              }, function (datari, menuri)
                local pIznos = tonumber(datari.value)				
                if pIznos == nil or pIznos <= 0 then
                  ESX.ShowNotification('Greska.')
                else
                  menuri.close()
                  TriggerServerEvent("atm:UrediIznos", pID, pIznos)
                end
              end, function (datari, menuri)
                menuri.close()
              end)
            elseif data2.current.value == "port" then
              if Bankomati[id].Koord then
                SetEntityCoords(PlayerPedId(), Bankomati[id].Koord)
              else
                ESX.ShowNotification("Bankomat nema postavljene koordinate")
              end
            elseif data2.current.value == "koord" then
              local kord = GetEntityCoords(PlayerPedId())
              TriggerServerEvent("atm:SpremiKoord", pID, kord)
            elseif data2.current.value == "bobj" then
              if Bankomati[id].Objekt == nil then
                menu2.close()
                Wait(500)
                Citizen.CreateThread(function()
                  local kord = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 4.0, -1.0)
                  local model = "prop_atm_01"
                  RequestModel(model)
                  while not HasModelLoaded(model) do
                    Citizen.Wait(1)
                  end
                  local obj = CreateObjectNoOffset(model, kord, false)
                  SetModelAsNoLongerNeeded(model)
                  FreezeEntityPosition(obj, true)
                  PlaceObjectOnGroundProperly(obj)
                  FreezeEntityPosition(PlayerPedId(), true)
                  local controls = CreateControls()
                  ButtonsScaleform = Instructional.Create(controls)
                  local brojic = 1
                  local kordac = GetEntityCoords(obj)
                  local postavlja = true
                  while postavlja do
                    DrawScaleformMovieFullscreen(ButtonsScaleform,255,255,255,255,0)
                    if IsControlJustPressed(0, 175) then
                      if (brojic+1) <= 4 then
                        brojic = brojic+1
                        local kordara = GetEntityCoords(obj)
                        local he = GetEntityHeading(obj)
                        local model = GetHashKey(Config.ATM[brojic])
                        DeleteObject(obj)
                        RequestModel(model)
                        while not HasModelLoaded(model) do
                          Citizen.Wait(1)
                        end
                        obj = CreateObjectNoOffset(model, kordara.x, kordara.y, kordara.z, false, false, false)
                        SetEntityHeading(obj, he)
                        FreezeEntityPosition(obj, true)
                        Wait(100)
                        --PlaceObjectOnGroundProperly(obj)
                        SetModelAsNoLongerNeeded(model)
                      end
                    end
                    if IsControlJustPressed(0, 174) then
                      if (brojic-1) >= 1 then
                        brojic = brojic-1
                        local kordara = GetEntityCoords(obj)
                        local he = GetEntityHeading(obj)
                        local model = GetHashKey(Config.ATM[brojic])
                        DeleteObject(obj)
                        RequestModel(model)
                        while not HasModelLoaded(model) do
                          Citizen.Wait(1)
                        end
                        obj = CreateObjectNoOffset(model, kordara.x, kordara.y, kordara.z, false, false, false)
                        SetEntityHeading(obj, he)
                        FreezeEntityPosition(obj, true)
                        Wait(100)
                        --PlaceObjectOnGroundProperly(obj)
                        SetModelAsNoLongerNeeded(model)
                      end
                    end
                    if IsControlPressed(0, 172) then
                      local corde = GetOffsetFromEntityInWorldCoords(obj, 0.0, 0.0, 0.01)
                      SetEntityCoords(obj, corde)
                    end
                    if IsControlPressed(0, 173) then
                      local corde = GetOffsetFromEntityInWorldCoords(obj, 0.0, 0.0, -0.01)
                      SetEntityCoords(obj, corde)
                    end
                    if IsControlPressed(0, 32) then
                      local corde = GetOffsetFromEntityInWorldCoords(obj, 0.0, 0.01, 0.0)
                      SetEntityCoords(obj, corde)
                      --PlaceObjectOnGroundProperly(obj)
                    end
                    if IsControlPressed(0, 33) then
                      local corde = GetOffsetFromEntityInWorldCoords(obj, 0.0, -0.01, 0.0)
                      SetEntityCoords(obj, corde)
                      --PlaceObjectOnGroundProperly(obj)
                    end
                    if IsControlPressed(0, 34) then
                      local corde = GetOffsetFromEntityInWorldCoords(obj, 0.01, 0.0, 0.0)
                      SetEntityCoords(obj, corde)
                      --PlaceObjectOnGroundProperly(obj)
                    end
                    if IsControlPressed(0, 35) then
                      local corde = GetOffsetFromEntityInWorldCoords(obj, -0.01, 0.0, 0.0)
                      SetEntityCoords(obj, corde)
                      --PlaceObjectOnGroundProperly(obj)
                    end
                    if IsControlPressed(0, 52) then
                      local head = GetEntityHeading(obj)
                      SetEntityHeading(obj, head+0.1)
                      --PlaceObjectOnGroundProperly(Kuca)
                    end
                    if IsControlPressed(0, 51) then
                      local head = GetEntityHeading(obj)
                      SetEntityHeading(obj, head-0.1)
                      --PlaceObjectOnGroundProperly(Kuca)
                    end
                    if IsControlJustPressed(0, 191) then
                      FreezeEntityPosition(PlayerPedId(), false)
                      local korda = GetEntityCoords(obj)
                      local heading = GetEntityHeading(obj)
                      DeleteObject(obj)
                      ESX.ShowNotification("Postavili ste objekt bankomata!")
                      TriggerServerEvent("atm:SpremiObjekt", pID, korda, heading, Config.ATM[brojic])
                      postavlja = false
                    end
                    if IsControlJustPressed(0, 73) then
                      FreezeEntityPosition(PlayerPedId(), false)
                      DeleteObject(obj)
                      ESX.ShowNotification("Odustali ste od postavljanja bankomata!")
                      postavlja = false
                      break
                    end
                    Citizen.Wait(1)
                  end
                  Instructional.Unload(ButtonsScaleform)
                end)
              else
                ESX.ShowNotification("Vec postoji objekt bankomata!")
              end
            elseif data2.current.value == "ubobj" then
              if Bankomati[id].Objekt ~= nil then
                menu2.close()
                Wait(500)
                Citizen.CreateThread(function()
                  local kord = nil
                  local head = nil
                  local model = Bankomati[id].Objekt
                  for i=1, #Objekti, 1 do
                    if Objekti[i].ID == pID then
                      kord = GetEntityCoords(Objekti[i].objekt)
                      head = GetEntityHeading(Objekti[i].objekt)
                      ESX.Game.DeleteObject(Objekti[i].objekt)
                      break
                    end
                  end
                  local brojic = 1
                  for i=1, #Config.ATM, 1 do
                    if GetHashKey(Config.ATM[i]) == GetHashKey(model) then
                      brojic = i
                      break
                    end
                  end
                  model = GetHashKey(Config.ATM[brojic])
                  RequestModel(model)
                  while not HasModelLoaded(model) do
                    Citizen.Wait(1)
                  end
                  local obj = CreateObjectNoOffset(model, kord, false)
                  SetEntityHeading(obj, head)
                  SetModelAsNoLongerNeeded(model)
                  FreezeEntityPosition(obj, true)
                  --PlaceObjectOnGroundProperly(obj)
                  FreezeEntityPosition(PlayerPedId(), true)
                  local controls = CreateControls()
                  ButtonsScaleform = Instructional.Create(controls)
                  local kordac = GetEntityCoords(obj)
                  local postavlja = true
                  while postavlja do
                    DrawScaleformMovieFullscreen(ButtonsScaleform,255,255,255,255,0)
                    if IsControlJustPressed(0, 175) then
                      if (brojic+1) <= 4 then
                        brojic = brojic+1
                        local kordara = GetEntityCoords(obj)
                        local he = GetEntityHeading(obj)
                        local model = GetHashKey(Config.ATM[brojic])
                        DeleteObject(obj)
                        RequestModel(model)
                        while not HasModelLoaded(model) do
                          Citizen.Wait(1)
                        end
                        obj = CreateObjectNoOffset(model, kordara.x, kordara.y, kordara.z, false, false, false)
                        SetEntityHeading(obj, he)
                        FreezeEntityPosition(obj, true)
                        Wait(100)
                        --PlaceObjectOnGroundProperly(obj)
                        SetModelAsNoLongerNeeded(model)
                      end
                    end
                    if IsControlJustPressed(0, 174) then
                      if (brojic-1) >= 1 then
                        brojic = brojic-1
                        local kordara = GetEntityCoords(obj)
                        local he = GetEntityHeading(obj)
                        local model = GetHashKey(Config.ATM[brojic])
                        DeleteObject(obj)
                        RequestModel(model)
                        while not HasModelLoaded(model) do
                          Citizen.Wait(1)
                        end
                        obj = CreateObjectNoOffset(model, kordara.x, kordara.y, kordara.z, false, false, false)
                        SetEntityHeading(obj, he)
                        FreezeEntityPosition(obj, true)
                        Wait(100)
                        --PlaceObjectOnGroundProperly(obj)
                        SetModelAsNoLongerNeeded(model)
                      end
                    end
                    if IsControlPressed(0, 172) then
                      local corde = GetOffsetFromEntityInWorldCoords(obj, 0.0, 0.0, 0.01)
                      SetEntityCoords(obj, corde)
                    end
                    if IsControlPressed(0, 173) then
                      local corde = GetOffsetFromEntityInWorldCoords(obj, 0.0, 0.0, -0.01)
                      SetEntityCoords(obj, corde)
                    end
                    if IsControlPressed(0, 32) then
                      local corde = GetOffsetFromEntityInWorldCoords(obj, 0.0, 0.01, 0.0)
                      SetEntityCoords(obj, corde)
                      --PlaceObjectOnGroundProperly(obj)
                    end
                    if IsControlPressed(0, 33) then
                      local corde = GetOffsetFromEntityInWorldCoords(obj, 0.0, -0.01, 0.0)
                      SetEntityCoords(obj, corde)
                      --PlaceObjectOnGroundProperly(obj)
                    end
                    if IsControlPressed(0, 34) then
                      local corde = GetOffsetFromEntityInWorldCoords(obj, 0.01, 0.0, 0.0)
                      SetEntityCoords(obj, corde)
                      --PlaceObjectOnGroundProperly(obj)
                    end
                    if IsControlPressed(0, 35) then
                      local corde = GetOffsetFromEntityInWorldCoords(obj, -0.01, 0.0, 0.0)
                      SetEntityCoords(obj, corde)
                      --PlaceObjectOnGroundProperly(obj)
                    end
                    if IsControlPressed(0, 52) then
                      local head = GetEntityHeading(obj)
                      SetEntityHeading(obj, head+0.1)
                      --PlaceObjectOnGroundProperly(Kuca)
                    end
                    if IsControlPressed(0, 51) then
                      local head = GetEntityHeading(obj)
                      SetEntityHeading(obj, head-0.1)
                      --PlaceObjectOnGroundProperly(Kuca)
                    end
                    if IsControlJustPressed(0, 191) then
                      FreezeEntityPosition(PlayerPedId(), false)
                      local korda = GetEntityCoords(obj)
                      local heading = GetEntityHeading(obj)
                      DeleteObject(obj)
                      ESX.ShowNotification("Postavili ste objekt bankomata!")
                      TriggerServerEvent("atm:SpremiObjekt", pID, korda, heading, Config.ATM[brojic])
                      postavlja = false
                    end
                    if IsControlJustPressed(0, 73) then
                      ESX.ShowNotification("Odustali ste od premjestanja bankomata!")
                      FreezeEntityPosition(PlayerPedId(), false)
                      DeleteObject(obj)
                      SpawnBankomate()
                      postavlja = false
                      break
                    end
                    Citizen.Wait(1)
                  end
                  Instructional.Unload(ButtonsScaleform)
                end)
              else
                ESX.ShowNotification("Objekt bankomata prvo mora biti postavljen!")
              end
            elseif data2.current.value == "obobj" then
              if Bankomati[id].Objekt ~= nil then
                TriggerServerEvent("atm:ObrisiObjekt", pID)
                ESX.ShowNotification("Uspjesno obrisan objekt bankomata!")
              else
                ESX.ShowNotification("Objekt ne postoji!")
              end
            elseif data2.current.value == "obrisi" then
              for i=1, #Blipovi, 1 do
                if Blipovi[i].ID == pID then
                  RemoveBlip(Blipovi[i].blip)
                  break
                end
              end
              for i=1, #Objekti, 1 do
                if Objekti[i].ID == pID then
                  DeleteObject(Objekti[i].objekt)
                  break
                end
              end
              TriggerServerEvent("atm:ObrisiBankomat", pID)
              menu2.close()
              Wait(500)
              ExecuteCommand("urediatm")
            end
          end,
          function(data2, menu2)
            
            menu2.close()
          end
        )
      end
          end,
          function(data, menu)
              menu.close()
          end
      )
  else
      ESX.ShowNotification("Niste admin!")
  end
end, false)

CreateControls = function()
  local controls
  controls = {
    [1] = Config.Controls["direction"],
    [2] = Config.Controls["heading"],
    [3] = Config.Controls["height"],
    [4] = Config.Controls["kuce"],
    [5] = Config.Controls["camera"],
    [6] = Config.Controls["zoom"],
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

Instructional.Unload = function(scaleform)
  Scaleforms.UnloadMovie(scaleform)
end

AddEventHandler("playerSpawned", function()
	ESX.TriggerServerCallback('esx-races:DohvatiPermisiju', function(br)
		perm = br
	end)
end)

RegisterNetEvent('es_admin:setPerm')
AddEventHandler('es_admin:setPerm', function()
	ESX.TriggerServerCallback('esx-races:DohvatiPermisiju', function(br)
		perm = br
	end)
end)

Citizen.CreateThread(function()
  local waitara = 1000
  while true do
    local _pcoords = GetEntityCoords(PlayerPedId())
    local naso = false
    for _, search in pairs(Config.Zonas["banks"]) do
      local distance = #(vector3(search.x, search.y, search.z) - vector3(_pcoords))
      if distance < 3 then
        waitara = 1
        naso = true
        DrawText3D(search.x, search.y, search.z, 'Pritisni ~y~E~w~ za ~r~pristup~w~ banci')
        DrawMarker(2,search.x, search.y, search.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.1, 255, 255, 0, 100, false, true, 2, false, false, false, false)
      end
    end
    --[[for i=1, #Bankomati, 1 do
      if Bankomati[i] ~= nil then
        if Bankomati[i].Koord and #(GetEntityCoords(PlayerPedId())-Bankomati[i].Koord) < 2 then
          waitara = 1
          naso = true
          DrawText3D(Bankomati[i].Koord.x, Bankomati[i].Koord.y, Bankomati[i].Koord.z, '['..Bankomati[i].ID..'] Pritisni ~y~E~w~ za ~r~pristup~w~ bankomatu')
          DrawMarker(2,Bankomati[i].Koord.x, Bankomati[i].Koord.y, Bankomati[i].Koord.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.1, 255, 0, 0, 100, false, true, 2, false, false, false, false)
          break
        end
      end
    end]]
    if not naso then
      waitara = 1000
    end
    Citizen.Wait(waitara)
  end
end)

--
-- EVENTS
--

RegisterNetEvent('banka::client:refreshbalance')
AddEventHandler('banka::client:refreshbalance', function(balance)
  local _streetcoords = GetStreetNameFromHashKey(GetStreetNameAtCoord(table.unpack(GetEntityCoords(PlayerPedId()))))
  local _pid = GetPlayerServerId(PlayerId())
  ESX.TriggerServerCallback('banka::server:GetPlayerName', function(playerName, tran)
    SendNUIMessage({
      type = "balanceHUD",
      balance = balance,
      player = playerName,
      address = _streetcoords,
      playerid = _pid,
      transakcije = tran
    })
  end)
end)

--
-- NUI CALLBACKS
--

RegisterNUICallback('kredit', function(data)
	ESX.TriggerServerCallback('banka:DohvatiKredit', function(br)
		if br.kredit == 0 then
			local PlayerData = ESX.GetPlayerData()
			if PlayerData.job.name ~= "unemployed" or PlayerData.posao.name ~= "unemployed" then
				if br.brplaca >= 400 then
					TriggerServerEvent('banka:podignikredit', tonumber(data.amount))
					Wait(200)
					ESX.TriggerServerCallback('banka:DohvatiKredit', function(br)
						SendNUIMessage({
							type = "narediKredit",
							kredit = br.kredit,
							rata = br.rata
						})
					end)
				else
					local brojic = 400-br.brplaca
					if brojic >= 1 and brojic <= 4 then
						ESX.ShowNotification("Nije vam jos dozvoljeno podizati kredit, moci cete nakon "..brojic.." primljene place!")
					else
						ESX.ShowNotification("Nije vam jos dozvoljeno podizati kredit, moci cete nakon "..brojic.." primljenih placa!")
					end
				end
			else
				ESX.ShowNotification("Ne mozete podici kredit ako ste nezaposleni!")
			end
		else
			ESX.ShowNotification("Vec imate podignut kredit koji nije vracen do kraja!")
		end
	end)
end)

RegisterNUICallback('vratikredit', function()
	ESX.TriggerServerCallback('banka:DohvatiKredit', function(br)
		if br.kredit == 0 then
			ESX.ShowNotification("Nemate podignut kredit!")
		else
			TriggerServerEvent("banka:VratiKredit")
			Wait(200)
			ESX.TriggerServerCallback('banka:DohvatiKredit', function(br)
				SendNUIMessage({
					type = "narediKredit",
					kredit = br.kredit,
					rata = br.rata
				})
			end)
		end
	end)
end)

RegisterNUICallback('deposit', function(data)
	TriggerServerEvent('banka::server:depositvb', tonumber(data.amount), inMenu)
	TriggerServerEvent('banka::server:balance', inMenu)
end)

RegisterNUICallback('withdraw', function(data)
	TriggerServerEvent('banka::server:withdrawvb', tonumber(data.amountw), inMenu)
	TriggerServerEvent('banka::server:balance', inMenu)
end)

RegisterNUICallback('balance', function()
	TriggerServerEvent('banka::server:balance', inMenu)
end)

RegisterNetEvent('balance:back')
AddEventHandler('balance:back', function(balance)
	SendNUIMessage({type = 'balanceReturn', bal = balance})
end) 

RegisterNUICallback('transfer', function(data)
	TriggerServerEvent('banka::server:transfervb', data.to, data.amountt, inMenu)
	TriggerServerEvent('banka::server:balance', inMenu)
end)

RegisterNetEvent('banka::result')
AddEventHandler('banka::result', function(type, message)
	SendNUIMessage({type = 'result', m = message, t = type})
end)

RegisterNUICallback('NUIFocusOff', function()
	SetNuiFocus(false, false)
	SendNUIMessage({type = 'closeAll'})
  Citizen.Wait(500)
  inMenu = false
end)

--
-- FUNCS
--

nearBankorATM = function()
    local _ped = PlayerPedId()
    local _pcoords = GetEntityCoords(_ped)
    local _toreturn = false
    for _, search in pairs(Config.Zonas["banks"]) do
      local distance = #(vector3(search.x, search.y, search.z) - vector3(_pcoords))
      if distance < 3 then
        atbank = true
        _toreturn = true
      end
    end
    local atm = GetATM2(GetEntityCoords(PlayerPedId()))
	  if atm ~= nil then
      atbank = false
      _toreturn = true
    end
    return _toreturn
end

DrawText3D = function(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end
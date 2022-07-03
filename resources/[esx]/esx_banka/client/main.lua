--[[
  -Fali jos dodavanje objekta bankomata i ako cu stavljat odmah oduzimanje iznosa s bankomata
]]

ESX                         = nil
local inMenu = false
local atbank = false
local perm 						= 0
local Bankomati = {}
local Blipovi = {}
local ATMID = nil

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
	end)
end)

RegisterKeyMapping('+banka', 'Banka', 'keyboard', 'E')
-- Main thread
RegisterCommand('-banka', function()
	---prazno mora biti
end, false)
RegisterCommand('+banka', function()
  local igrac = PlayerPedId()
  if nearBankorATM() then
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

function SpawnBlipove()
	for i=1, #Blipovi, 1 do
		RemoveBlip(Blipovi[i].blip)
	end
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

RegisterNetEvent('atm:VratiBankomate')
AddEventHandler('atm:VratiBankomate', function(atm)
	Bankomati = atm
	SpawnBlipove()
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
        table.insert(elements, {label = "Postavi koordinate teksta", value = "koord"})
        table.insert(elements, {label = "Postavi objekt bankomata", value = "bobj"})
        table.insert(elements, {label = "Portaj se", value = "port"})
        table.insert(elements, {label = "Promjeni iznos na bankomatu", value = "iznos"})
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
              --Ovdje ce ici biranje objekta i postavljanje
            elseif data2.current.value == "obrisi" then
              for i=1, #Blipovi, 1 do
                if Blipovi[i].ID == pID then
                  RemoveBlip(Blipovi[i].blip)
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
    for i=1, #Bankomati, 1 do
      if Bankomati[i] ~= nil then
        if Bankomati[i].Koord and #(GetEntityCoords(PlayerPedId())-Bankomati[i].Koord) < 2 then
          waitara = 1
          naso = true
          DrawText3D(Bankomati[i].Koord.x, Bankomati[i].Koord.y, Bankomati[i].Koord.z, '['..Bankomati[i].ID..'] Pritisni ~y~E~w~ za ~r~pristup~w~ bankomatu')
          DrawMarker(2,Bankomati[i].Koord.x, Bankomati[i].Koord.y, Bankomati[i].Koord.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.1, 255, 0, 0, 100, false, true, 2, false, false, false, false)
          break
        end
      end
    end
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
    for i=1, #Bankomati, 1 do
      if Bankomati[i] ~= nil then
        if Bankomati[i].Koord and #(GetEntityCoords(PlayerPedId())-Bankomati[i].Koord) < 2 then
          atbank = false
          _toreturn = true
          ATMID = Bankomati[i].ID
          break
        end
      end
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
--================================================================================================
--==                      banka: BY VISIBAIT (BASED OFF NEW_BANKING)                        ==
--================================================================================================

ESX                         = nil
local inMenu = false
local atbank = false

--
-- MAIN THREAD
--

Citizen.CreateThread(function()
  while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
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
    inMenu = true
    SetNuiFocus(true,true)
    SendNUIMessage({type = 'openGeneral', banco = atbank})
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
    for _, search in pairs(Config.Zonas["atms"]) do
      local distance = #(vector3(search.x, search.y, search.z) - vector3(_pcoords))
      if distance < 2 then
        waitara = 1
        naso = true
        DrawText3D(search.x, search.y, search.z, 'Pritisni ~y~E~w~ za ~r~pristup~w~ bankomatu')
        DrawMarker(2,search.x, search.y, search.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.1, 255, 0, 0, 100, false, true, 2, false, false, false, false)
      end
    end
    if not naso then
      waitara = 1000
    end
    Citizen.Wait(waitara)
  end
end)

Citizen.CreateThread(function()
  for k,v in ipairs(Config.Zonas["atms"])do
  local blip = AddBlipForCoord(v.x, v.y, v.z)
  SetBlipSprite (blip, v.id)
  SetBlipDisplay(blip, 4)
  SetBlipScale  (blip, 0.5)
  SetBlipColour (blip, 2)
  SetBlipAsShortRange(blip, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString(tostring(v.name))
  EndTextCommandSetBlipName(blip)
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
    for _, search in pairs(Config.Zonas["atms"]) do
      local distance = #(vector3(search.x, search.y, search.z) - vector3(_pcoords))
      if distance < 2 then
        atbank = false
        _toreturn = true
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
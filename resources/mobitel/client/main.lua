local Otvoren = false;
local UPozivu = false;
local myPedId = nil

local phoneProp = 0
local phoneModel = "prop_amb_phone"
-- OR "prop_npc_phone"
-- OR "prop_npc_phone_02"
-- OR "prop_cs_phone_01"

local currentStatus = 'out'
local lastDict = nil
local lastAnim = nil
local lastIsFreeze = false

local ANIMS = {
	['cellphone@'] = {
		['out'] = {
			['text'] = 'cellphone_text_in',
			['call'] = 'cellphone_call_listen_base',
		},
		['text'] = {
			['out'] = 'cellphone_text_out',
			['text'] = 'cellphone_text_in',
			['call'] = 'cellphone_text_to_call',
		},
		['call'] = {
			['out'] = 'cellphone_call_out',
			['text'] = 'cellphone_call_to_text',
			['call'] = 'cellphone_text_to_call',
		}
	},
	['anim@cellphone@in_car@ps'] = {
		['out'] = {
			['text'] = 'cellphone_text_in',
			['call'] = 'cellphone_call_in',
		},
		['text'] = {
			['out'] = 'cellphone_text_out',
			['text'] = 'cellphone_text_in',
			['call'] = 'cellphone_text_to_call',
		},
		['call'] = {
			['out'] = 'cellphone_horizontal_exit',
			['text'] = 'cellphone_call_to_text',
			['call'] = 'cellphone_text_to_call',
		}
	}
}

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNUICallback(
    "nazovi",
    function(data, cb)
      if ImalSignala() then
		    TriggerServerEvent("mobitel:Nazovi", data.broj)
      else
        SendNUIMessage({
          nepostoji = true,
          mess = "Nemate signala"
        })
      end
    end
)

RegisterNUICallback(
    "prihvati",
    function(data, cb)
      TriggerServerEvent("mobitel:PrihvatiPoziv", data.info)
    end
)

RegisterNUICallback(
    "obrisiKontakt",
    function(data, cb)
      TriggerServerEvent("mobitel:ObrisiKontakt", data.broj)
    end
)

function newPhoneProp()
	deletePhone()
	RequestModel(phoneModel)
	while not HasModelLoaded(phoneModel) do
		Citizen.Wait(1)
	end
	phoneProp = CreateObject(GetHashKey(phoneModel), 1.0, 1.0, 1.0, 1, 1, 0)
	SetModelAsNoLongerNeeded(phoneModel)
	local bone = GetPedBoneIndex(myPedId, 28422)
	AttachEntityToEntity(phoneProp, myPedId, bone, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 0, 2, 1)
end

function deletePhone ()
	if phoneProp ~= 0 then
		Citizen.InvokeNative(0xAE3CBE5BF394C9C9 , Citizen.PointerValueIntInitialized(phoneProp))
		phoneProp = 0
	end
end

--[[
	out || text || Call ||
--]]
function PhonePlayAnim (status, freeze, force)
	if currentStatus == status and force ~= true then
		return
	end

	myPedId = GetPlayerPed(-1)
	local freeze = freeze or false

	local dict = "cellphone@"
	if IsPedInAnyVehicle(myPedId, false) then
		dict = "anim@cellphone@in_car@ps"
	end
	loadAnimDict(dict)

	local anim = ANIMS[dict][currentStatus][status]
	if currentStatus ~= 'out' then
		StopAnimTask(myPedId, lastDict, lastAnim, 1.0)
	end
	local flag = 50
	if freeze == true then
		flag = 14
	end
	TaskPlayAnim(myPedId, dict, anim, 3.0, -1, -1, flag, 0, false, false, false)

	if status ~= 'out' and currentStatus == 'out' then
		Citizen.Wait(380)
		newPhoneProp()
	end

	lastDict = dict
	lastAnim = anim
	lastIsFreeze = freeze
	currentStatus = status

	if status == 'out' then
		Citizen.Wait(180)
		deletePhone()
		StopAnimTask(myPedId, lastDict, lastAnim, 1.0)
	end

end

function PhonePlayOut ()
	PhonePlayAnim('out')
end

function PhonePlayText ()
	PhonePlayAnim('text')
end

function PhonePlayCall (freeze)
	PhonePlayAnim('call', freeze)
end

function PhonePlayIn () 
	if currentStatus == 'out' then
		PhonePlayText()
	end
end

function loadAnimDict(dict)
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(1)
	end
end

function ImalSignala()
  local centarGrada = vector3(86.756629943848,-989.32501220703,29.407320022583)
  local centarPaleto = vector3(-176.29887390137, 6363.9033203125, 31.396242141724)
  local centarSandy = vector3(1813.2326660156, 3796.2780761719, 33.625762939453)
  local pos = GetEntityCoords(PlayerPedId())
  if #(centarGrada-pos) >= 2800 and pos.z < 100 and #(centarPaleto-pos) >= 680 and #(centarSandy-pos) >= 580 then
    return false
  else
    return true
  end
end

RegisterNUICallback(
    "dohvatiPoruke",
    function(data, cb)
      ESX.TriggerServerCallback('mobitel:DohvatiPoruke', function(por, br)
        for i=1, #por, 1 do
          if por[i].transmitter == br and por[i].display == br then
            por[i].display = por[i].receiver
          end
        end
        SendNUIMessage({
          poruke = true,
          data = por,
          br = br
        })
      end)
    end
)

RegisterNUICallback(
    "dohvatiHitne",
    function(data, cb)
      ESX.TriggerServerCallback('mobitel:DohvatiHitne', function(data, br)
        SendNUIMessage({
          hitni = true,
          orgBr = br,
          data = data
        })
      end)
    end
)

RegisterNUICallback(
    "dohvatiKontakte",
    function(data, cb)
      ESX.TriggerServerCallback('mobitel:DohvatiKontakte', function(kon)
        SendNUIMessage({
          kontakti = true,
          data = kon
        })
      end)
    end
)

RegisterNUICallback(
    "prekini",
    function(data, cb)
		  TriggerServerEvent("mobitel:Prekini", data.info)
    end
)

RegisterNUICallback(
    "dodajKontakt",
    function(data, cb)
      TriggerServerEvent("mobitel:DodajKontakt", data.broj, data.ime)
    end
)

RegisterNUICallback(
    "posaljiPoruku",
    function(data, cb)
      if ImalSignala() then
        TriggerServerEvent("mobitel:PosaljiPoruku", data.broj, data.poruka)
      else
        SendNUIMessage({
          nepostoji = true,
          mess = "Nemate signala"
        })
      end
    end
)

RegisterNUICallback(
    "postaviGPS",
    function(data, cb)
      local koord = json.decode(data.koord)
      SetNewWaypoint(koord.x, koord.y)
    end
)

RegisterNUICallback(
    "posaljiPoruku2",
    function(data, cb)
      local coord = GetEntityCoords(PlayerPedId())
      TriggerServerEvent("mobitel:PosaljiPoruku2", data.broj, data.poruka, json.encode(coord), data.orgBr)
    end
)

RegisterNUICallback(
    "zatvorioMob",
    function(data, cb)
		  Otvoren = not Otvoren
      PhonePlayOut()
      SetNuiFocus(false)
    end
)

RegisterNetEvent('mobitel:ObrisanKontakt')
AddEventHandler('mobitel:ObrisanKontakt', function()
  SendNUIMessage({
    nepostoji = true,
    mess = "Uspjesno obrisan kontakt"
  })
end)

RegisterNetEvent('mobitel:DodanKontakt')
AddEventHandler('mobitel:DodanKontakt', function()
  SendNUIMessage({
    nepostoji = true,
    mess = "Uspjesno dodan kontakt"
  })
end)

RegisterNetEvent('mobitel:Pozivanje')
AddEventHandler('mobitel:Pozivanje', function(info, br)
    if br then
      SendNUIMessage({
        poziv = true,
        broj = nil,
        info = info,
        vrsta = 1
      })
    else
      SendNUIMessage({
			  poziv = true,
        broj = info.pozivatelj_broj,
        info = info,
			  vrsta = 2
		  })
    end
end)

RegisterNetEvent('mobitel:NovaPoruka')
AddEventHandler('mobitel:NovaPoruka', function(br, posiljatelj)
  if posiljatelj then
    SendNUIMessage({
      nepostoji = true,
      mess = "Uspjesno poslana poruka"
    })
  else
    ESX.ShowNotification("Nova poruka s broja "..br)
    SendNUIMessage({
      smszvuk = true
    })
  end
end)

RegisterNetEvent('mobitel:BrojNePostoji')
AddEventHandler('mobitel:BrojNePostoji', function(br)
  if br then
    SendNUIMessage({
      nepostoji = true,
      mess = "Broj ne postoji"
    })
  else
    SendNUIMessage({
      nepostoji = true,
      mess = "Birani broj je nedostupan"
    })
  end
end)

RegisterNetEvent('mobitel:PrihvacenPoziv')
AddEventHandler('mobitel:PrihvacenPoziv', function(info, br)
  exports["mumble-voip"]:SetCallChannel(info.id)
  if br then
    SendNUIMessage({
      upozivu = true,
      info = info,
      vrsta = 1
    })
  else
    SendNUIMessage({
      upozivu = true,
      info = info,
      vrsta = 2
    })
  end
  UPozivu = true
  Citizen.CreateThread(function()
    while UPozivu do
      if not ImalSignala() then
        TriggerEvent("mobitel:PrekinutPoziv")
      end
      Citizen.Wait(1000)
    end
  end)
end)

RegisterNetEvent('mobitel:PrekinutPoziv')
AddEventHandler('mobitel:PrekinutPoziv', function()
  exports["mumble-voip"]:SetCallChannel(0)
  SendNUIMessage({
    prekini = true
  })
  UPozivu = false
end)

AddEventHandler('esx:onPlayerDeath', function()
	if Otvoren then
		Otvoren = not Otvoren;
    SendNUIMessage({
      mobitel = true,
      br = Otvoren
    })
    if Otvoren then
      PhonePlayIn()
      SetNuiFocus(true, true)
    else
      PhonePlayOut()
      SetNuiFocus(false)
    end
	end
  if UPozivu then
    TriggerEvent("mobitel:PrekinutPoziv")
  end
end)

RegisterNetEvent('mobitel:Nazovi')
AddEventHandler('mobitel:Nazovi', function(br)
  if not Otvoren then
    Otvoren = not Otvoren;
    SendNUIMessage({
      mobitel = true,
      br = Otvoren
    })
    PhonePlayIn()
    SetNuiFocus(true, true)
    if ImalSignala() then
      TriggerServerEvent("mobitel:Nazovi", br)
    else
      SendNUIMessage({
        nepostoji = true,
        mess = "Nemate signala"
      })
    end
  end
end)

RegisterNetEvent('mobitel:PosaljiPoruku')
AddEventHandler('mobitel:PosaljiPoruku', function(br)
  if not Otvoren then
    Otvoren = not Otvoren;
    SendNUIMessage({
      mobitel = true,
      br = Otvoren
    })
    PhonePlayIn()
    SetNuiFocus(true, true)
    SendNUIMessage({
      nporuka = true,
      broj = br
    })
  end
end)

RegisterCommand('+mobitel', function()
  ESX.TriggerServerCallback('mobitel:ImalMobitel', function(br)
    if br then
      if IsControlEnabled(0, 288) then
        Otvoren = not Otvoren;
        ESX.TriggerServerCallback('mobitel:DohvatiBroj', function(broj)
          SendNUIMessage({
            mobitel = true,
            br = Otvoren,
            broj = broj
          })
        end)
        if Otvoren then
          PhonePlayIn()
          SetNuiFocus(true, true)
        else
          PhonePlayOut()
          SetNuiFocus(false)
        end
      end
    else
      ESX.ShowNotification("Nemate mobitel.")
    end
  end)
end, false)
RegisterKeyMapping('+mobitel', 'Koristi mobitel', 'keyboard', 'f1')
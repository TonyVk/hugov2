ESX								= nil
local HasAlreadyEnteredMarker	= false
local LastZone					= nil
local CurrentAction				= nil
local CurrentActionMsg			= ''
local CurrentActionData			= {}
local isDead					= false
local NemaStruje 				= false
local Cpovi 					= {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	SpawnCpove()
end)

function SpawnCpove()
	if #Cpovi > 0 then
		for i=1, #Cpovi, 1 do
		  	if Cpovi[i] ~= nil then
			  	if Cpovi[i].Spawnan then
					DeleteCheckpoint(Cpovi[i].ID)
					Cpovi[i].Spawnan = false
			  	end
		  	end
		end
	end
	Cpovi = {}
	for k,v in pairs(Config.Zones) do
		for i = 1, #v.Pos, 1 do
			table.insert(Cpovi, {ID = check, Koord = v.Pos[i], Spawnan = false, r = Config.Color.r, g = Config.Color.g, b = Config.Color.b})
		end
	end
end

RegisterNetEvent('elektricar:NemaStruje')
AddEventHandler('elektricar:NemaStruje', function(br)
	NemaStruje = br
end)

function OpenAccessoryMenu()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'set_unset_accessory',
	{
		title = _U('set_unset'),
		align = 'top-left',
		elements = {
			--{label = _U('helmet'), value = 'Helmet'},
			--{label = _U('ears'), value = 'Ears'},
			{label = _U('mask'), value = 'Mask'}
			--{label = _U('glasses'), value = 'Glasses'}
		}
	}, function(data, menu)
		menu.close()
		SetUnsetAccessory(data.current.value)

	end, function(data, menu)
		menu.close()
	end)
end

function SetUnsetAccessory(accessory)
	ESX.TriggerServerCallback('esx_accessories:get', function(hasAccessory, accessorySkin)
		local _accessory = string.lower(accessory)

		if hasAccessory then
			TriggerEvent('skinchanger:getSkin', function(skin)
				local mAccessory = -1
				local mColor = 0

				if _accessory == "mask" then
					mAccessory = 0
				end

				if skin[_accessory .. '_1'] == mAccessory then
					mAccessory = accessorySkin[_accessory .. '_1']
					mColor = accessorySkin[_accessory .. '_2']
				end

				local accessorySkin = {}
				accessorySkin[_accessory .. '_1'] = mAccessory
				accessorySkin[_accessory .. '_2'] = mColor
				TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
			end)
		else
			ESX.ShowNotification(_U('no_' .. _accessory))
		end

	end, accessory)
end

function OpenShopMenu(accessory)
	local _accessory = string.lower(accessory)
	local restrict = {}

	restrict = { _accessory .. '_1', _accessory .. '_2' }
	
	TriggerEvent('esx_skin:openRestrictedMenu', function(data, menu)

		menu.close()

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_confirm',
		{
			title = _U('valid_purchase'),
			align = 'top-left',
			elements = {
				{label = _U('no'), value = 'no'},
				{label = _U('yes', ESX.Math.GroupDigits(Config.Price)), value = 'yes'}
			}
		}, function(data, menu)
			menu.close()
			if data.current.value == 'yes' then
				ESX.TriggerServerCallback('esx_accessories:checkMoney', function(hasEnoughMoney)
					if hasEnoughMoney then
						TriggerServerEvent('esx_accessories:pay')
						TriggerEvent('skinchanger:getSkin', function(skin)
							TriggerServerEvent('esx_accessories:save', skin, accessory)
							TriggerEvent('skinchanger:getSkin', function(skin)
								skin['mask_1'] = 0
								skin['mask_2'] = 0
								TriggerServerEvent('esx_skin:save', skin)
							end)
						end)
					else
						TriggerEvent('esx_skin:getLastSkin', function(skin)
							TriggerEvent('skinchanger:loadSkin', skin)
						end)
						ESX.ShowNotification(_U('not_enough_money'))
					end
				end)
			end

			if data.current.value == 'no' then
				local player = PlayerPedId()
				TriggerEvent('esx_skin:getLastSkin', function(skin)
					TriggerEvent('skinchanger:loadSkin', skin)
				end)
				if accessory == "Ears" then
					ClearPedProp(player, 2)
				elseif accessory == "Mask" then
					SetPedComponentVariation(player, 1, 0 ,0, 2)
				elseif accessory == "Helmet" then
					ClearPedProp(player, 0)
				elseif accessory == "Glasses" then
					SetPedPropIndex(player, 1, -1, 0, 0)
				end
			end
			CurrentAction     = 'shop_menu'
			CurrentActionMsg  = _U('press_access')
			CurrentActionData = {}
		end, function(data, menu)
			menu.close()
			CurrentAction     = 'shop_menu'
			CurrentActionMsg  = _U('press_access')
			CurrentActionData = {}

		end)
	end, function(data, menu)
		menu.close()
		CurrentAction     = 'shop_menu'
		CurrentActionMsg  = _U('press_access')
		CurrentActionData = {}
	end, restrict)
end

AddEventHandler('playerSpawned', function()
	isDead = false
end)

AddEventHandler('esx:onPlayerDeath', function()
	isDead = true
end)

AddEventHandler('esx_accessories:hasEnteredMarker', function(zone)
	print("aaaa")
	CurrentAction     = 'shop_menu'
	CurrentActionMsg  = _U('press_access')
	CurrentActionData = { accessory = zone }
end)

AddEventHandler('esx_accessories:hasExitedMarker', function(zone)
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil
end)

-- Create Blips --
Citizen.CreateThread(function()
	for k,v in pairs(Config.ShopsBlips) do
		if v.Pos ~= nil then
			for i=1, #v.Pos, 1 do
				local blip = AddBlipForCoord(v.Pos[i])

				SetBlipSprite (blip, v.Blip.sprite)
				SetBlipDisplay(blip, 4)
				SetBlipScale  (blip, 1.0)
				SetBlipColour (blip, v.Blip.color)
				SetBlipAsShortRange(blip, true)

				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString(_U('shop', _U(string.lower(k))))
				EndTextCommandSetBlipName(blip)
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(500)

		local coords      = GetEntityCoords(PlayerPedId())
		local isInMarker  = false
		local currentZone = nil

		if #Cpovi > 0 then
			for i=1, #Cpovi, 1 do
			  if Cpovi[i] ~= nil then
				if #(coords-Cpovi[i].Koord) > 100 then
				  if Cpovi[i].Spawnan then
					DeleteCheckpoint(Cpovi[i].ID)
					Cpovi[i].Spawnan = false
				  end
				else
				  if Cpovi[i].Spawnan == false then
					local kord = Cpovi[i].Koord
					local range = 2.0
					local check = CreateCheckpoint(47, kord.x, kord.y, kord.z, 0, 0, 0, range, Cpovi[i].r, Cpovi[i].g, Cpovi[i].b, 100)
					SetCheckpointCylinderHeight(check, range, range, range)
					Cpovi[i].ID = check
					Cpovi[i].Spawnan = true
				  end
				end
			  end
			end
			for i=1, #Cpovi, 1 do
			  if Cpovi[i] ~= nil and Cpovi[i].Spawnan then
				if #(coords-Cpovi[i].Koord) < 1.5 then
					isInMarker  = true
					currentZone = "shop_menu"
					LastZone    = "shop_menu"
					TriggerEvent("dpc:EquipLast")
					break
				end
			  end
			end
		end

		if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
			HasAlreadyEnteredMarker = true
			LastZone = currentZone
			TriggerEvent('esx_accessories:hasEnteredMarker', currentZone)
		end

		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('esx_accessories:hasExitedMarker', LastZone)
		end

	end
end)

RegisterCommand('+maska', function()
	if IsInputDisabled(0) and not isDead then
		OpenAccessoryMenu()
	end
end, false)
RegisterKeyMapping('+maska', 'Otvori maska menu', 'keyboard', 'k')

-- Key controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		
		if CurrentAction ~= nil then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, 38) then
				if not NemaStruje then
					OpenShopMenu("mask")
					CurrentAction = nil
				else
					CurrentAction = nil
					ESX.ShowNotification("Trenutno nismo u mogucnosti prodati robu zato sto nemamo struje!")
				end
			end
		else
			Citizen.Wait(500)
		end
	end
end)

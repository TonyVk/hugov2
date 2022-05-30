ESX = nil

local Keys = {
    ["ESC"] = 322,
    ["F1"] = 288,
    ["F2"] = 289,
    ["F3"] = 170,
    ["F5"] = 166,
    ["F6"] = 167,
    ["F7"] = 168,
    ["F8"] = 169,
    ["F9"] = 56,
    ["F10"] = 57,
    ["~"] = 243,
    ["1"] = 157,
    ["2"] = 158,
    ["3"] = 160,
    ["4"] = 164,
    ["5"] = 165,
    ["6"] = 159,
    ["7"] = 161,
    ["8"] = 162,
    ["9"] = 163,
    ["-"] = 84,
    ["="] = 83,
    ["BACKSPACE"] = 177,
    ["TAB"] = 37,
    ["Q"] = 44,
    ["W"] = 32,
    ["E"] = 38,
    ["R"] = 45,
    ["T"] = 245,
    ["Y"] = 246,
    ["U"] = 303,
    ["P"] = 199,
    ["["] = 39,
    ["]"] = 40,
    ["ENTER"] = 18,
    ["CAPS"] = 137,
    ["A"] = 34,
    ["S"] = 8,
    ["D"] = 9,
    ["F"] = 23,
    ["G"] = 47,
    ["H"] = 74,
    ["K"] = 311,
    ["L"] = 182,
    ["LEFTSHIFT"] = 21,
    ["Z"] = 20,
    ["X"] = 73,
    ["C"] = 26,
    ["V"] = 0,
    ["B"] = 29,
    ["N"] = 249,
    ["M"] = 244,
    [","] = 82,
    ["."] = 81,
    ["LEFTCTRL"] = 36,
    ["LEFTALT"] = 19,
    ["SPACE"] = 22,
    ["RIGHTCTRL"] = 70,
    ["HOME"] = 213,
    ["PAGEUP"] = 10,
    ["PAGEDOWN"] = 11,
    ["DELETE"] = 178,
    ["LEFT"] = 174,
    ["RIGHT"] = 175,
    ["TOP"] = 27,
    ["DOWN"] = 173,
    ["NENTER"] = 201,
    ["N4"] = 108,
    ["N5"] = 60,
    ["N6"] = 107,
    ["N+"] = 96,
    ["N-"] = 97,
    ["N7"] = 117,
    ["N8"] = 61,
    ["N9"] = 118
}

local trunkData = nil
local isInInventory = false
local NeOtvaraj     = false
local uvozilu = false
local prvispawn = false
ESX = nil
local fastWeapons = {
	[1] = nil,
	[2] = nil,
	[3] = nil
}

Citizen.CreateThread(function()
    while ESX == nil do TriggerEvent("esx:getSharedObject",function(obj) ESX = obj end)
        Wait(250)
    end
end)

-- Citizen.CreateThread(function ()
--     while true do
--         uvozilu = IsPedInAnyVehicle(PlayerPedId(), false)
--         if not uvozilu then
--             DisableControlAction(0, 37 , true)
--         end

--         if not uvozilu then cekaj = 0 else cekaj = 500 end
--         Citizen.Wait(cekaj)
--     end
-- end)

AddEventHandler("playerSpawned", function()
    if not prvispawn then
        prvispawn = true
        Citizen.CreateThread(function ()
            while not uvozilu do
                DisableControlAction(0, 37 , true)
                Citizen.Wait(0)
            end
        end)
    end
end)

RegisterNetEvent('baseevents:enteredVehicle')
AddEventHandler('baseevents:enteredVehicle', function(currentVehicle, currentSeat, modelName, netId)
    uvozilu = true
end)

RegisterNetEvent('baseevents:leftVehicle')
AddEventHandler('baseevents:leftVehicle', function(currentVehicle, currentSeat, modelName, netId)
    uvozilu = false
    Citizen.CreateThread(function ()
        while not uvozilu do
            DisableControlAction(0, 37 , true)
            Citizen.Wait(0)
        end
    end)
end)

RegisterNetEvent('esx_invh:closeinv')
AddEventHandler('esx_invh:closeinv', function()
	closeInventory()
end)

RegisterNetEvent('esx:ZabraniInv')
AddEventHandler('esx:ZabraniInv', function(br)
	NeOtvaraj = br
end)

RegisterCommand('-inv', function()
    if IsInputDisabled(0) and not NeOtvaraj then
        openInventory()
    end
end, false)

RegisterKeyMapping('-inv', 'Inventory', 'keyboard', 'i')

function openInventory()
    loadPlayerInventory()
    isInInventory = true
    
    SendNUIMessage(
        {
            action = "display",
            type = "normal"
        }
    )
    SetNuiFocus(true, true)
    Citizen.CreateThread(function()
        while isInInventory do
            Citizen.Wait(5)        
            local playerPed = PlayerPedId()
            DisableControlAction(0, 1, true) -- Disable pan
            DisableControlAction(0, 2, true) -- Disable tilt
            DisableControlAction(0, 24, true) -- Attack
            DisableControlAction(0, 257, true) -- Attack 2
            DisableControlAction(0, 25, true) -- Aim
            DisableControlAction(0, 263, true) -- Melee Attack 1
            DisableControlAction(0, Keys["W"], true) -- W
            DisableControlAction(0, Keys["A"], true) -- A
            DisableControlAction(0, 31, true) -- S (fault in Keys table!)
            DisableControlAction(0, 30, true) -- D (fault in Keys table!)

            DisableControlAction(0, Keys["R"], true) -- Reload
            DisableControlAction(0, Keys["SPACE"], true) -- Jump
            DisableControlAction(0, Keys["Q"], true) -- Cover
            DisableControlAction(0, Keys["TAB"], true) -- Select Weapon
            DisableControlAction(0, Keys["F"], true) -- Also 'enter'?

            DisableControlAction(0, Keys["F1"], true) -- Disable phone
            DisableControlAction(0, Keys["F2"], true) -- Inventory
            DisableControlAction(0, Keys["F3"], true) -- Animations
            DisableControlAction(0, Keys["F6"], true) -- Job

            DisableControlAction(0, Keys["V"], true) -- Disable changing view
            DisableControlAction(0, Keys["C"], true) -- Disable looking behind
            DisableControlAction(0, Keys["X"], true) -- Disable clearing animation
            DisableControlAction(2, Keys["P"], true) -- Disable pause screen

            DisableControlAction(0, 59, true) -- Disable steering in vehicle
            DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
            DisableControlAction(0, 72, true) -- Disable reversing in vehicle

            DisableControlAction(2, Keys["LEFTCTRL"], true) -- Disable going stealth

            DisableControlAction(0, 47, true) -- Disable weapon
            DisableControlAction(0, 264, true) -- Disable melee
            DisableControlAction(0, 257, true) -- Disable melee
            DisableControlAction(0, 140, true) -- Disable melee
            DisableControlAction(0, 141, true) -- Disable melee
            DisableControlAction(0, 142, true) -- Disable melee
            DisableControlAction(0, 143, true) -- Disable melee
            DisableControlAction(0, 75, true) -- Disable exit vehicle
            DisableControlAction(27, 75, true) -- Disable exit vehicle
        end
    end)
end

function openTrunkInventory()
    loadPlayerInventory()
    isInInventory = true

    SendNUIMessage(
        {
            action = "display",
            type = "trunk"
        }
    )

    SetNuiFocus(true, true)
    Citizen.CreateThread(function()
        while isInInventory do
            Citizen.Wait(5)        
            local playerPed = PlayerPedId()
            DisableControlAction(0, 1, true) -- Disable pan
            DisableControlAction(0, 2, true) -- Disable tilt
            DisableControlAction(0, 24, true) -- Attack
            DisableControlAction(0, 257, true) -- Attack 2
            DisableControlAction(0, 25, true) -- Aim
            DisableControlAction(0, 263, true) -- Melee Attack 1
            DisableControlAction(0, Keys["W"], true) -- W
            DisableControlAction(0, Keys["A"], true) -- A
            DisableControlAction(0, 31, true) -- S (fault in Keys table!)
            DisableControlAction(0, 30, true) -- D (fault in Keys table!)

            DisableControlAction(0, Keys["R"], true) -- Reload
            DisableControlAction(0, Keys["SPACE"], true) -- Jump
            DisableControlAction(0, Keys["Q"], true) -- Cover
            DisableControlAction(0, Keys["TAB"], true) -- Select Weapon
            DisableControlAction(0, Keys["F"], true) -- Also 'enter'?

            DisableControlAction(0, Keys["F1"], true) -- Disable phone
            DisableControlAction(0, Keys["F2"], true) -- Inventory
            DisableControlAction(0, Keys["F3"], true) -- Animations
            DisableControlAction(0, Keys["F6"], true) -- Job

            DisableControlAction(0, Keys["V"], true) -- Disable changing view
            DisableControlAction(0, Keys["C"], true) -- Disable looking behind
            DisableControlAction(0, Keys["X"], true) -- Disable clearing animation
            DisableControlAction(2, Keys["P"], true) -- Disable pause screen

            DisableControlAction(0, 59, true) -- Disable steering in vehicle
            DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
            DisableControlAction(0, 72, true) -- Disable reversing in vehicle

            DisableControlAction(2, Keys["LEFTCTRL"], true) -- Disable going stealth

            DisableControlAction(0, 47, true) -- Disable weapon
            DisableControlAction(0, 264, true) -- Disable melee
            DisableControlAction(0, 257, true) -- Disable melee
            DisableControlAction(0, 140, true) -- Disable melee
            DisableControlAction(0, 141, true) -- Disable melee
            DisableControlAction(0, 142, true) -- Disable melee
            DisableControlAction(0, 143, true) -- Disable melee
            DisableControlAction(0, 75, true) -- Disable exit vehicle
            DisableControlAction(27, 75, true) -- Disable exit vehicle
        end
    end)
end

function closeInventory()
    isInInventory = false
    SendNUIMessage(
        {
            action = "hide"
        }
    )
    SetNuiFocus(false, false)
end

function Sanitize(str)
	local replacements = {
		['&' ] = '&amp;',
		['<' ] = '&lt;',
		['>' ] = '&gt;',
		['\n'] = '<br/>'
	}

	return str
		:gsub('[&<>\n]', replacements)
		:gsub(' +', function(s)
			return ' '..('&nbsp;'):rep(#s-1)
		end)
end

RegisterNUICallback(
    "NUIFocusOff",
    function()
        closeInventory()
    end
)

RegisterNUICallback(
    "GetNearPlayers",
    function(data, cb)
        local playerPed = PlayerPedId()
        local players, nearbyPlayer = ESX.Game.GetPlayersInArea(GetEntityCoords(playerPed), 3.0)
        local foundPlayers = false
        local elements = {}

        for i = 1, #players, 1 do
            if players[i] ~= PlayerId() then
                foundPlayers = true

                table.insert(
                    elements,
                    {
                        label = Sanitize(GetPlayerName(players[i])),
                        player = GetPlayerServerId(players[i])
                    }
                )
            end
        end

        if not foundPlayers then
            exports.pNotify:SendNotification(
                {
                    text = _U("players_nearby"),
                    type = "error",
                    timeout = 3000,
                    layout = "bottomCenter",
                    queue = "inventoryhud"
                }
            )
        else
            SendNUIMessage(
                {
                    action = "nearPlayers",
                    foundAny = foundPlayers,
                    players = elements,
                    item = data.item
                }
            )
        end

        cb("ok")
    end
)

RegisterNUICallback(
    "PutIntoTrunk",
    function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end

        if type(data.number) == "number" and math.floor(data.number) == data.number then
            local count = tonumber(data.number)

            if data.item.type == "item_weapon" then
                count = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(data.item.name))
            end

            TriggerServerEvent("esx_trunk:putItem", trunkData.plate, data.item.type, data.item.name, count, trunkData.max, trunkData.myVeh, data.item.label)
        end

        Wait(500)
        loadPlayerInventory()

        cb("ok")
    end
)

RegisterNUICallback(
    "TakeFromTrunk",
    function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end

        if type(data.number) == "number" and math.floor(data.number) == data.number then
            TriggerServerEvent("esx_trunk:getItem", trunkData.plate, data.item.type, data.item.name, tonumber(data.number), trunkData.max, trunkData.myVeh)
        end

        Wait(500)
        loadPlayerInventory()

        cb("ok")
    end
)

RegisterNUICallback(
    "UseItem",
    function(data, cb)
        TriggerServerEvent("esx:useItem", data.item.name)

        if shouldCloseInventory(data.item.name) then
            closeInventory()
        else
            Citizen.Wait(250)
            loadPlayerInventory()
        end

        cb("ok")
    end
)

RegisterNUICallback(
    "GiveItem",
    function(data, cb)
        local playerPed = PlayerPedId()
        local players, nearbyPlayer = ESX.Game.GetPlayersInArea(GetEntityCoords(playerPed), 3.0)
        local foundPlayer = false
        for i = 1, #players, 1 do
			if players[i] ~= PlayerId() then
                if GetPlayerServerId(players[i]) == data.player then
                    foundPlayer = true
                end
            end
        end

        if foundPlayer then
            local count = tonumber(data.number)
			
			if data.item.type == "item_weapon" then
				local dataa = ESX.GetPlayerData()
				if dataa.job.name == 'police' or dataa.job.name == 'sipa' or dataa.job.name == 'zastitar' or dataa.job.name == 'Gradonacelnik' then
					ESX.ShowNotification("Vi ste u policiji/zastitar i zato ne mozete davati oruzje drugim igracima!")
					return
				end
			end
			
			if data.item.name == "net_cracker" or data.item.name == "thermite" then
				ESX.ShowNotification("Ne mozete ovaj predmet dati drugome igracu!")
				return
			end

            if data.item.type == "item_weapon" then
                count = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(data.item.name))
                TriggerServerEvent("DiscordBot:Inventory", GetPlayerName(PlayerId()).." je dao igracu "..GetPlayerName(GetPlayerFromServerId(data.player)).." "..data.item.name .. " sa " .. data.item.count .. "x metaka." )
            end
			TriggerServerEvent("esx:DajItemTuljanu", data.player, data.item.type, data.item.name, count)
            Wait(250)
            loadPlayerInventory()
        else
            exports.pNotify:SendNotification(
                {
                    text = _U("player_nearby"),
                    type = "error",
                    timeout = 3000,
                    layout = "bottomCenter",
                    queue = "inventoryhud"
                }
            )
        end
        cb("ok")
    end
)

function shouldCloseInventory(itemName)
    for index, value in ipairs(Config.CloseUiItems) do
        if value == itemName then
            return true
        end
    end

    return false
end

function shouldSkipAccount(accountName)
    for index, value in ipairs(Config.ExcludeAccountsList) do
        if value == accountName then
            return true
        end
    end

    return false
end

--local arraylimit = Config.locallimit
function getInventorylimit(inventory)
  local limit = 0
  local itemlimit = 0
  if inventory ~= nil then
    for i = 1, #inventory, 1 do
      if inventory[i] ~= nil then
        itemlimit = Config.Defaultlimit
        if arraylimit[inventory[i].name] ~= nil then
          itemlimit = arraylimit[inventory[i].name]
        end
        limit = limit + (itemlimit * (inventory[i].count or 1))
      end
    end
  end
  return limit
end

function loadPlayerInventory()
    ESX.TriggerServerCallback(
        "esx_inventoryhud:getPlayerInventory",
        function(data)
            items = {}
            fastItems = {}
            inventory = data.inventory
            accounts = data.accounts
            money = data.money
            weapons = data.weapons

            if Config.IncludeCash and money ~= nil and money > 0 then
                moneyData = {
                    label = _U("cash"),
                    name = "cash",
                    type = "item_money",
                    count = money,
                    usable = false,
                    rare = false,
                    limit = -1,
                    canRemove = true
                 }
                table.insert(items, moneyData)
            end

            if Config.IncludeAccounts and accounts ~= nil then
                for key, value in pairs(accounts) do
                    if not shouldSkipAccount(accounts[key].name) then
                        local canDrop = accounts[key].name ~= "bank"

                        if accounts[key].money > 0 then
                            accountData = {
                                label = accounts[key].label,
                                count = accounts[key].money,
                                type = "item_account",
                                name = accounts[key].name,
                                usable = false,
                                rare = false,
                                limit = -1,
                                canRemove = canDrop
                            }
                            table.insert(items, accountData)
                        end
                    end
                end
            end
			
            if inventory ~= nil then
                for key, value in pairs(inventory) do
                    if inventory[key].count <= 0 then
                        inventory[key] = nil
                    else
						local torba = 0
						TriggerEvent('skinchanger:getSkin', function(skin)
							torba = skin['bags_1']
						end)
						if torba == 40 or torba == 41 or torba == 44 or torba == 45 then
							if string.find(inventory[key].name, "weapon_") == nil then
								inventory[key].type = "item_standard"
								inventory[key].limit = inventory[key].limit*2
								if value.name ~= "ljudi" then
									table.insert(items, inventory[key])
								end
							else
								inventory[key].type = "item_standard"
								if value.name ~= "ljudi" then
									table.insert(items, inventory[key])
								end
							end
						else
							inventory[key].type = "item_standard"
							if value.name ~= "ljudi" then
								table.insert(items, inventory[key])
							end
						end
                    end
                end
            end

            if Config.IncludeWeapons and weapons ~= nil then
                for key, value in pairs(weapons) do
                    local weaponHash = GetHashKey(weapons[key].name)
                    local playerPed = PlayerPedId()
                    if HasPedGotWeapon(playerPed, weaponHash, false) and weapons[key].name ~= "WEAPON_UNARMED" then
							local found = false
							for slot, weapon in pairs(fastWeapons) do
								if weapon == weapons[key].name then
									local ammo = GetAmmoInPedWeapon(playerPed, weaponHash)
									table.insert(
										fastItems,
										{
											label = weapons[key].label,
											count = ammo,
											limit = -1,
											type = "item_weapon",
											name = weapons[key].name,
											usable = false,
											rare = false,
											canRemove = true,
											slot = slot
										}
									)
									found = true
									break
								end
							end
							if found == false then
								local ammo = GetAmmoInPedWeapon(playerPed, weaponHash)
								table.insert(
									items,
									{
										label = weapons[key].label,
										count = ammo,
										limit = -1,
										type = "item_weapon",
										name = weapons[key].name,
										usable = false,
										rare = false,
										canRemove = true
									}
								)
							end
                    end
                end
            end
			
			local arraylimit = Config.locallimit
			local limit = 0
			local itemlimit = 0
			local itemsW = 0
			if items ~= nil then
			for i = 1, #items, 1 do
				if items[i] ~= nil then
				  itemlimit = Config.Defaultlimit
				  itemlimit = itemlimit / items[1].count * 0.0
				if arraylimit[items[i].name] ~= nil then
				  itemlimit = arraylimit[items[i].name]
				  items[i].limit = itemlimit / 1000
				end
				  limit = limit + (itemlimit * (items[i].count or 1))
				end
		      end
			end
			
			local texts =  _U("player_info", GetPlayerName(PlayerId()), (limit / 1000), (Config.limit / 1000))
			
            if limit > Config.limit then
                exports['mythic_notify']:DoCustomHudText('inform', 'Imate previse stvari kod sebe, bacite nesto na pod')
			   setHurt()
			   
			   texts = _U("player_info_full", GetPlayerName(PlayerId()), (limit / 1000), (Config.limit / 1000))
			elseif limit <= Config.limit then
			   setNotHurt()
			   texts =  _U("player_info", GetPlayerName(PlayerId()), (limit / 1000), (Config.limit / 1000))
			end
			
            SendNUIMessage(
                {
                    action = "setItems",
                    itemList = items,
                    fastItems = fastItems,
					text = texts
                }
            )
			
        end,
        GetPlayerServerId(PlayerId())
    )
end

function setHurt()
    FreezeEntityPosition(PlayerPedId(), true)
end
			 
function setNotHurt()
	 FreezeEntityPosition(PlayerPedId(), false)
end

RegisterNetEvent("esx_inventoryhud:openTrunkInventory")
AddEventHandler(
    "esx_inventoryhud:openTrunkInventory",
    function(data, blackMoney, inventory, weapons)
        setTrunkInventoryData(data, blackMoney, inventory, weapons)
        openTrunkInventory()
    end
)

RegisterNetEvent("esx_inventoryhud:otvori")
AddEventHandler(
    "esx_inventoryhud:otvori", function()
    openInventory()
end)

RegisterNetEvent("esx_inventoryhud:refreshTrunkInventory")
AddEventHandler(
    "esx_inventoryhud:refreshTrunkInventory",
    function(data, blackMoney, inventory, weapons)
        setTrunkInventoryData(data, blackMoney, inventory, weapons)
    end
)

function setTrunkInventoryData(data, blackMoney, inventory, weapons)
    trunkData = data
	
		SendNUIMessage(
			{
				action = "setInfoText",
				text = data.text
			}
		)			

    items = {}

    if blackMoney > 0 then
        accountData = {
            label = _U("black_money"),
            count = blackMoney,
            type = "item_account",
            name = "black_money",
            usable = false,
            rare = false,
            limit = -1,
            canRemove = false
        }
        table.insert(items, accountData)
    end

    if inventory ~= nil then
        for key, value in pairs(inventory) do
            if inventory[key].count <= 0 then
                inventory[key] = nil
            else
                inventory[key].type = "item_standard"
                inventory[key].usable = false
                inventory[key].rare = false
                inventory[key].limit = -1
                inventory[key].canRemove = false
                table.insert(items, inventory[key])
            end
        end
    end

    if Config.IncludeWeapons and weapons ~= nil then
        for key, value in pairs(weapons) do
            local weaponHash = GetHashKey(weapons[key].name)
            local playerPed = PlayerPedId()
            if weapons[key].name ~= "WEAPON_UNARMED" then
                table.insert(
                    items,
                    {
                        label = weapons[key].label,
                        count = weapons[key].ammo,
                        limit = -1,
                        type = "item_weapon",
                        name = weapons[key].name,
                        usable = false,
                        rare = false,
                        canRemove = false
                    }
                )
            end
        end
    end
	
    SendNUIMessage(
        {
            action = "setSecondInventoryItems",
            itemList = items
        }
    )
end

function openTrunkInventory()
    TriggerScreenblurFadeIn(0)
    loadPlayerInventory()
    isInInventory = true
    local playerPed = PlayerPedId()
    if not IsEntityPlayingAnim(playerPed, 'mini@repair', 'fixing_a_player', 3) then
        ESX.Streaming.RequestAnimDict('mini@repair', function()
            TaskPlayAnim(playerPed, 'mini@repair', 'fixing_a_player', 8.0, -8, -1, 49, 0, 0, 0, 0)
        end)
    end

    SendNUIMessage(
        {
            action = "display",
            type = "trunk"
        }
    )

    SetNuiFocus(true, true)
    Citizen.CreateThread(function()
        while isInInventory do
            Citizen.Wait(5)        
            local playerPed = PlayerPedId()
            DisableControlAction(0, 1, true) -- Disable pan
            DisableControlAction(0, 2, true) -- Disable tilt
            DisableControlAction(0, 24, true) -- Attack
            DisableControlAction(0, 257, true) -- Attack 2
            DisableControlAction(0, 25, true) -- Aim
            DisableControlAction(0, 263, true) -- Melee Attack 1
            DisableControlAction(0, Keys["W"], true) -- W
            DisableControlAction(0, Keys["A"], true) -- A
            DisableControlAction(0, 31, true) -- S (fault in Keys table!)
            DisableControlAction(0, 30, true) -- D (fault in Keys table!)

            DisableControlAction(0, Keys["R"], true) -- Reload
            DisableControlAction(0, Keys["SPACE"], true) -- Jump
            DisableControlAction(0, Keys["Q"], true) -- Cover
            DisableControlAction(0, Keys["TAB"], true) -- Select Weapon
            DisableControlAction(0, Keys["F"], true) -- Also 'enter'?

            DisableControlAction(0, Keys["F1"], true) -- Disable phone
            DisableControlAction(0, Keys["F2"], true) -- Inventory
            DisableControlAction(0, Keys["F3"], true) -- Animations
            DisableControlAction(0, Keys["F6"], true) -- Job

            DisableControlAction(0, Keys["V"], true) -- Disable changing view
            DisableControlAction(0, Keys["C"], true) -- Disable looking behind
            DisableControlAction(0, Keys["X"], true) -- Disable clearing animation
            DisableControlAction(2, Keys["P"], true) -- Disable pause screen

            DisableControlAction(0, 59, true) -- Disable steering in vehicle
            DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
            DisableControlAction(0, 72, true) -- Disable reversing in vehicle

            DisableControlAction(2, Keys["LEFTCTRL"], true) -- Disable going stealth

            DisableControlAction(0, 47, true) -- Disable weapon
            DisableControlAction(0, 264, true) -- Disable melee
            DisableControlAction(0, 257, true) -- Disable melee
            DisableControlAction(0, 140, true) -- Disable melee
            DisableControlAction(0, 141, true) -- Disable melee
            DisableControlAction(0, 142, true) -- Disable melee
            DisableControlAction(0, 143, true) -- Disable melee
            DisableControlAction(0, 75, true) -- Disable exit vehicle
            DisableControlAction(27, 75, true) -- Disable exit vehicle
        end
    end)
end

--FAST ITEMS
RegisterNUICallback(
    "PutIntoFast",
    function(data, cb)
		if data.item.slot ~= nil then
			fastWeapons[data.item.slot] = nil
		end
		fastWeapons[data.slot] = data.item.name
		TriggerServerEvent("esx_inventoryhud:changeFastItem",data.slot,data.item.name)
		loadPlayerInventory()
		cb("ok")
	end
)
RegisterNUICallback(
    "TakeFromFast",
    function(data, cb)
		fastWeapons[data.item.slot] = nil

		TriggerServerEvent("esx_inventoryhud:changeFastItem",0,data.item.name)
		loadPlayerInventory()
		cb("ok")
	end
)


RegisterKeyMapping('+prva', 'Prva', 'keyboard', '1')

RegisterCommand('-prva', function()
	---prazno mora biti
end, false)
RegisterCommand('+prva', function()
    if fastWeapons[1] ~= nil then
        if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey(fastWeapons[1]) then
            SetCurrentPedWeapon(PlayerPedId(), "WEAPON_UNARMED",true)
        else
            local ped = PlayerPedId()
            loadAnimDict( "reaction@intimidation@1h" )
            TaskPlayAnim(ped, "reaction@intimidation@1h", "intro", 8.0, 2.0, -1, 48, 10, 0, 0, 0 )
            Citizen.CreateThread(function()
                while IsEntityPlayingAnim(ped, "reaction@intimidation@1h", "intro", 3) do
                    Citizen.Wait(0)
                    DisableControlAction(0, 25, true)
                    DisablePlayerFiring(PlayerId(), true)
                end
            end)
            SetCurrentPedWeapon(PlayerPedId(), fastWeapons[1],true)
            Wait(2800)
            ClearPedTasks(PlayerPedId())
        end
    end
end, false)

RegisterKeyMapping('+druga', 'Druga', 'keyboard', '2')

RegisterCommand('-druga', function()
	---prazno mora biti
end, false)
RegisterCommand('+druga', function()
    if fastWeapons[2] ~= nil then
        if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey(fastWeapons[2]) then
            SetCurrentPedWeapon(PlayerPedId(), "WEAPON_UNARMED",true)
        else
            local ped = PlayerPedId()
            loadAnimDict( "reaction@intimidation@1h" )
            TaskPlayAnim(ped, "reaction@intimidation@1h", "intro", 8.0, 2.0, -1, 48, 10, 0, 0, 0 )
            Citizen.CreateThread(function()
                while IsEntityPlayingAnim(ped, "reaction@intimidation@1h", "intro", 3) do
                    Citizen.Wait(0)
                    DisableControlAction(0, 25, true)
                    DisablePlayerFiring(PlayerId(), true)
                end
            end)
            SetCurrentPedWeapon(PlayerPedId(), fastWeapons[2],true)
            Wait(2800)
            ClearPedTasks(PlayerPedId())
        end
    end
end, false)

RegisterKeyMapping('+treca', 'Treca', 'keyboard', '3')

RegisterCommand('-treca', function()
	---prazno mora biti
end, false)
RegisterCommand('+treca', function()
    if fastWeapons[3] ~= nil then
        if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey(fastWeapons[3]) then
            SetCurrentPedWeapon(PlayerPedId(), "WEAPON_UNARMED",true)
        else
            local ped = PlayerPedId()
            loadAnimDict( "reaction@intimidation@1h" )
            TaskPlayAnim(ped, "reaction@intimidation@1h", "intro", 8.0, 2.0, -1, 48, 10, 0, 0, 0 )
            Citizen.CreateThread(function()
                while IsEntityPlayingAnim(ped, "reaction@intimidation@1h", "intro", 3) do
                    Citizen.Wait(0)
                    DisableControlAction(0, 25, true)
                    DisablePlayerFiring(PlayerId(), true)
                end
            end)
            SetCurrentPedWeapon(PlayerPedId(), fastWeapons[3],true)
            Wait(2800)
            ClearPedTasks(PlayerPedId())
        end
    end
end, false)


RegisterKeyMapping('+cetvrta', 'Cetvrta', 'keyboard', '4')

RegisterCommand('-cetvrta', function()
	---prazno mora biti
end, false)
RegisterCommand('+cetvrta', function()
    if fastWeapons[4] ~= nil then
        if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey(fastWeapons[4]) then
            SetCurrentPedWeapon(PlayerPedId(), "WEAPON_UNARMED",true)
        else
            local ped = PlayerPedId()
            loadAnimDict( "reaction@intimidation@1h" )
            TaskPlayAnim(ped, "reaction@intimidation@1h", "intro", 8.0, 2.0, -1, 48, 10, 0, 0, 0 )
            Citizen.CreateThread(function()
                while IsEntityPlayingAnim(ped, "reaction@intimidation@1h", "intro", 3) do
                    Citizen.Wait(0)
                    DisableControlAction(0, 25, true)
                    DisablePlayerFiring(PlayerId(), true)
                end
            end)
            SetCurrentPedWeapon(PlayerPedId(), fastWeapons[4],true)
            Wait(2800)
            ClearPedTasks(PlayerPedId())
        end
    end
end, false)

RegisterKeyMapping('+peta', 'Peta', 'keyboard', '5')

RegisterCommand('-peta', function()
	---prazno mora biti
end, false)
RegisterCommand('+peta', function()
    if fastWeapons[5] ~= nil then
        if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey(fastWeapons[5]) then
            SetCurrentPedWeapon(PlayerPedId(), "WEAPON_UNARMED",true)
        else
            local ped = PlayerPedId()
            loadAnimDict( "reaction@intimidation@1h" )
            TaskPlayAnim(ped, "reaction@intimidation@1h", "intro", 8.0, 2.0, -1, 48, 10, 0, 0, 0 )
            Citizen.CreateThread(function()
                while IsEntityPlayingAnim(ped, "reaction@intimidation@1h", "intro", 3) do
                    Citizen.Wait(0)
                    DisableControlAction(0, 25, true)
                    DisablePlayerFiring(PlayerId(), true)
                end
            end)
            SetCurrentPedWeapon(PlayerPedId(), fastWeapons[5],true)
            Wait(2800)
            ClearPedTasks(PlayerPedId())
        end
    end
end, false)


function loadAnimDict( dict )
	while ( not HasAnimDictLoaded( dict ) ) do
		RequestAnimDict( dict )
		Citizen.Wait( 10 )
	end
end


--Add Items--

RegisterNetEvent('esx_inventoryhud:client:addItem')
AddEventHandler('esx_inventoryhud:client:addItem', function(itemname, itemlabel)
    local data = { name = itemname, label = itemlabel }
    SendNUIMessage({type = "addInventoryItem", addItemData = data})
end)
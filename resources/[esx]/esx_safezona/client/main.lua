ESX                             = nil
local Safezone                     = {}
local perm 						= 0
local UZoni = false
local GledaZonu = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(100)
    end
    ProvjeriPosao()
end)

function ProvjeriPosao()
	ESX.PlayerData = ESX.GetPlayerData()
	ESX.TriggerServerCallback('esx-races:DohvatiPermisiju', function(br)
		perm = br
	end)
    ESX.TriggerServerCallback('safezona:DohvatiZone', function(vr)
		Safezone = vr
        SpawnZone()
	end)
end

function SpawnZone()
    for i=1, #Safezone, 1 do
        local pinkcage = PolyZone:Create(Safezone[i].koord, {
            name=Safezone[i].ime,
            debugGrid = false,
            --minZ = Safezone[i].koord.z-5.0,
            --maxZ = Safezone[i].koord.z+10.0
        })
        Safezone[i].zona = pinkcage
        pinkcage:onPlayerInOut(function(isPointInside, point)
            if isPointInside then
                UZoni = true
                TriggerEvent("pNotify:SendNotification",{
                    text = "<b style='color:#1E90FF'>Vi ste u safe zoni</b>",
                    type = "success",
                    timeout = (3000),
                    layout = "bottomcenter",
                    queue = "global"
                })
                NetworkSetFriendlyFireOption(false)
                ClearPlayerWantedLevel(PlayerId())
                SetCurrentPedWeapon(player,GetHashKey("WEAPON_UNARMED"),true)
                Citizen.CreateThread(function()
                    while UZoni do
                        Citizen.Wait(0)
                        local player = GetPlayerPed(-1)
                        DisableControlAction(2, 37, true) -- disable weapon wheel (Tab)
                        DisablePlayerFiring(player,true) -- Disables firing all together if they somehow bypass inzone Mouse Disable
                        DisableControlAction(0, 106, true) -- Disable in-game mouse controls
                        DisableControlAction(0, 167, true)
                        DisableControlAction(0, 45, true)
                        DisableControlAction(0, 140, true)
                        DisableControlAction(0, 263, true)
                        SetPlayerCanDoDriveBy(PlayerId(), false)
                        if IsDisabledControlJustPressed(2, 37) then --if Tab is pressed, send error message
                            SetCurrentPedWeapon(player,GetHashKey("WEAPON_UNARMED"),true) -- if tab is pressed it will set them to unarmed (this is to cover the vehicle glitch until I sort that all out)
                            TriggerEvent("pNotify:SendNotification",{
                                text = "<b style='color:#1E90FF'>Ne mozete koristiti oruzja u safe zoni</b>",
                                type = "error",
                                timeout = (3000),
                                layout = "bottomcenter",
                                queue = "global"
                            })
                        end
                        if IsDisabledControlJustPressed(0, 106) then --if LeftClick is pressed, send error message
                            SetCurrentPedWeapon(player,GetHashKey("WEAPON_UNARMED"),true) -- If they click it will set them to unarmed
                            TriggerEvent("pNotify:SendNotification",{
                                text = "<b style='color:#1E90FF'>Ne mozete to raditi u safe zoni</b>",
                                type = "error",
                                timeout = (3000),
                                layout = "bottomcenter",
                                queue = "global"
                            })
                        end
                    end
                end)
            else
                if UZoni then
                    TriggerEvent("pNotify:SendNotification",{
                        text = "<b style='color:#1E90FF'>Napustili ste safe zonu</b>",
                        type = "error",
                        timeout = (3000),
                        layout = "bottomcenter",
                        queue = "global"
                    })
                end
                UZoni = false
                DisablePlayerFiring(PlayerPedId(),false)
                SetPlayerCanDoDriveBy(PlayerId(), true)
                NetworkSetFriendlyFireOption(true)
                SetCanAttackFriendly(PlayerPedId(), true, true)
            end
        end)
    end
end

RegisterNetEvent('safezona:VratiZonu')
AddEventHandler('safezona:VratiZonu', function(vr, ime, ko)
	Safezone = vr
    local pinkcage = PolyZone:Create(ko, {
        name=ime,
        debugGrid = false,
        --minZ = ko.z-5.0,
        --maxZ = ko.z+10.0
    })
    for i=1, #Safezone, 1 do
        if Safezone[i].ime == ime then
            Safezone[i].zona = pinkcage
            break
        end
    end
    pinkcage:onPlayerInOut(function(isPointInside, point)
        if isPointInside then
            UZoni = true
            TriggerEvent("pNotify:SendNotification",{
                text = "<b style='color:#1E90FF'>Vi ste u safe zoni</b>",
                type = "success",
                timeout = (3000),
                layout = "bottomcenter",
                queue = "global"
            })
            Citizen.CreateThread(function()
                while UZoni do
                    Citizen.Wait(0)
                    local player = GetPlayerPed(-1)
                    NetworkSetFriendlyFireOption(false)
                    ClearPlayerWantedLevel(PlayerId())
                    SetCurrentPedWeapon(player,GetHashKey("WEAPON_UNARMED"),true)
                    DisableControlAction(2, 37, true) -- disable weapon wheel (Tab)
                    DisablePlayerFiring(player,true) -- Disables firing all together if they somehow bypass inzone Mouse Disable
                    DisableControlAction(0, 106, true) -- Disable in-game mouse controls
                    DisableControlAction(0, 167, true)
                    DisableControlAction(0, 45, true)
                    DisableControlAction(0, 140, true)
                    DisableControlAction(0, 263, true)
                    if IsDisabledControlJustPressed(2, 37) then --if Tab is pressed, send error message
                        SetCurrentPedWeapon(player,GetHashKey("WEAPON_UNARMED"),true) -- if tab is pressed it will set them to unarmed (this is to cover the vehicle glitch until I sort that all out)
                        TriggerEvent("pNotify:SendNotification",{
                            text = "<b style='color:#1E90FF'>Ne mozete koristiti oruzja u safe zoni</b>",
                            type = "error",
                            timeout = (3000),
                            layout = "bottomcenter",
                            queue = "global"
                        })
                    end
                    if IsDisabledControlJustPressed(0, 106) then --if LeftClick is pressed, send error message
                        SetCurrentPedWeapon(player,GetHashKey("WEAPON_UNARMED"),true) -- If they click it will set them to unarmed
                        TriggerEvent("pNotify:SendNotification",{
                            text = "<b style='color:#1E90FF'>Ne mozete to raditi u safe zoni</b>",
                            type = "error",
                            timeout = (3000),
                            layout = "bottomcenter",
                            queue = "global"
                        })
                    end
                end
            end)
        else
            TriggerEvent("pNotify:SendNotification",{
                text = "<b style='color:#1E90FF'>Napustili ste safe zonu</b>",
                type = "error",
                timeout = (3000),
                layout = "bottomcenter",
                queue = "global"
            })
            UZoni = false
            NetworkSetFriendlyFireOption(true)
            SetCanAttackFriendly(PlayerPedId(), true, true)
        end
    end)
end)

RegisterNetEvent('safezona:ObrisiZonu')
AddEventHandler('safezona:ObrisiZonu', function(vr, id)
    for i = 1, #Safezone do
        if Safezone[i] ~= nil then
            if Safezone[i].ID == id then
                Safezone[i].zona:destroy()
                break
            end
        end
	end
    Safezone = vr
end)

RegisterCommand("uredisafezonu", function(source, args, raw)
    if perm == 1 then
        local elements = {}

        table.insert(elements, {label = "Nova zona", value = "nova"})
        
        for i=1, #Safezone, 1 do
            if Safezone[i] ~= nil then
                table.insert(elements, {label = Safezone[i].ime, value = Safezone[i].ID})
            end
        end

        ESX.UI.Menu.Open(
            'default', GetCurrentResourceName(), 'usafez',
            {
                title    = "Izaberite safezonu",
                align    = 'top-left',
                elements = elements,
            },
            function(data, menu)
                if data.current.value == "nova" then
                    Wait(1000)
                    local trazi = true
                    local br = 0
                    local tablica = {}
                    local markeri = {}
                    menu.close()
                    ESX.ShowNotification("Pritisnite E da spremite marker.", 6000)
                    ESX.ShowNotification("Pritisnite enter da zavrsite pravljenje.", 6000)
                    ESX.ShowNotification("Pritisnite X da odustanete.", 6000)
                    while trazi do
                        Citizen.Wait(1)
                        if IsControlJustPressed(0, 38) then
                            local korde = GetEntityCoords(PlayerPedId())
                            local vek = vector2(korde.x, korde.y)
                            table.insert(tablica, vek)
                            table.insert(markeri, korde)
                        end
                        for i=1, #markeri, 1 do
                            DrawMarker(0, markeri[i], 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 2.0, 1.0, 0, 0, 0, 100, false, true, 2, false, false, false, false)
                        end
                        if IsControlPressed(0, 186) then
                            trazi = false
                            tablica = {}
                            ESX.ShowNotification("Odustali ste od postavljanja!")
                        end
                        if IsControlPressed(0, 191) then
                            trazi = false
                            ESX.ShowNotification("Zavrsili ste pravljenje!")
                        end
                    end
                    if #tablica > 0 then
                        ESX.ShowNotification("Pritisnite enter da zavrsite pregled.", 6000)
                        ESX.ShowNotification("Pritisnite X da odustanete.", 6000)
                        local koordic = GetEntityCoords(PlayerPedId())
                        local pinkcage = PolyZone:Create(tablica, {
                            name="test",
                            debugGrid = true,
                            minZ = koordic.z-5.0,
                            maxZ = koordic.z+10.0
                        })
                        Wait(1000)
                        local gledaj = true
                        while gledaj do
                            Citizen.Wait(1)
                            if IsControlPressed(0, 18) then
                                gledaj = false
                                pinkcage:destroy()
                                ESX.ShowNotification("Zavrsili ste pregled i dodali novu zonu!")
                                ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'pimezone', {
                                    title = "Upisite ime zone",
                                }, function (datari, menuri)
                                    local pIme = datari.value				
                                    if pIme == nil then
                                        ESX.ShowNotification('Greska.')
                                    else
                                        menuri.close()
                                        TriggerServerEvent("safezona:DodajZonu", pIme, tablica)
                                    end
                                end, function (datari, menuri)
                                    menuri.close()
                                end)
                            end
                            if IsControlPressed(0, 186) then
                                gledaj = false
                                tablica = {}
                                ESX.ShowNotification("Odustali ste od postavljanja!")
                            end
                        end
                    end
                else
                    local zID = data.current.value
                    local id
                    for i = 1, #Safezone do
                        if Safezone[i].ID == zID then
                            id = i
                            break
                        end
                    end
                    elements = {}
                    table.insert(elements, {label = "Vidi safezonu", value = "vidi"})
                    table.insert(elements, {label = "Obrisi safezonu", value = "obrisi"})
                    ESX.UI.Menu.Open(
                        'default', GetCurrentResourceName(), 'uszonu',
                        {
                            title    = "Izaberite opciju",
                            align    = 'top-left',
                            elements = elements,
                        },
                        function(data2, menu2)
                            if data2.current.value == "obrisi" then
                                TriggerServerEvent("safezona:ObrisiZonu", zID)
                                ESX.ShowNotification("Obrisana safezona")
                                menu2.close()
                                menu.close()
                                Wait(100)
                                ExecuteCommand("uredisafezonu")
                            elseif data2.current.value == "vidi" then
                                if not GledaZonu then
                                    GledaZonu = true
                                    ESX.ShowNotification("Pritisnite X da zavrsite pregled.", 6000)
                                    local koordic = GetEntityCoords(PlayerPedId())
                                    local pinkcage = PolyZone:Create(Safezone[id].koord, {
                                        name="test",
                                        debugGrid = true,
                                        minZ = koordic.z-5.0,
                                        maxZ = koordic.z+10.0
                                    })
                                    Wait(1000)
                                    local gledaj = true
                                    while gledaj do
                                        Citizen.Wait(1)
                                        if IsControlPressed(0, 186) then
                                            gledaj = false
                                            GledaZonu = false
                                            pinkcage:destroy()
                                            ESX.ShowNotification("Zavrsili ste pregled zone!")
                                        end
                                    end
                                else
                                    ESX.ShowNotification("Vec gledate safezonu!")
                                end
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
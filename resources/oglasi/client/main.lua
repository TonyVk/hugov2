ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
    DodajPeda()
end)

local OglasPed = nil

function DodajPeda()
    local pedmodel = GetHashKey("csb_reporter")
    ESX.Streaming.RequestModel(pedmodel)
    OglasPed = CreatePed(0, pedmodel, -1083.2482910156, -245.91780090332, 36.763233184814, 205.36, false, true)
    SetEntityInvincible(OglasPed, true)
    SetBlockingOfNonTemporaryEvents(OglasPed, true)
    SetPedDiesWhenInjured(OglasPed, false)
    SetPedFleeAttributes(OglasPed, 2)
    FreezeEntityPosition(OglasPed, true)
    SetPedCanPlayAmbientAnims(OglasPed, false)
    SetPedCanRagdollFromPlayerImpact(OglasPed, false)
    SetEntityAsNoLongerNeeded(pedmodel)

    local blip = AddBlipForCoord(-1083.2482910156, -245.91780090332, 36.763233184814)
    SetBlipSprite (blip, 184)
    SetBlipDisplay(blip, 4)
    SetBlipColour (blip, 3)
    SetBlipScale  (blip, 0.8)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Oglasnik")
    EndTextCommandSetBlipName(blip)

    exports.qtarget:AddEntityZone("oglas", OglasPed, 
    {
        name="daj_oglas",
        debugPoly=false,
        useZ = true
    }, {
        options = {
            {
                event = "oglas:DajOglas",
                icon = "far fa-comment",
                label = "Kupite oglas ($50)"
            }
        },
        distance = 3.5
    })
end

RegisterNetEvent('oglas:DajOglas')
AddEventHandler('oglas:DajOglas', function()
    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'daj_oglas', {
        title = "Upišite tekst oglasa"
    }, function(data, menu)
        local tekst = data.value
        if tekst and #tekst > 0 and not isBlank(tekst) then
            TriggerServerEvent("oglasi:DodajOglas", tekst)
        else
            ESX.ShowNotification("Upišite tekst oglasa!")
        end
        menu.close()
    end, function(data, menu)
        menu.close()
    end)
end)

function isBlank(x)
    return not not tostring(x):find("^%s*$")
end

RegisterNetEvent('oglasi:OtvoriNovine')
AddEventHandler('oglasi:OtvoriNovine', function()
    SetNuiFocus(true, true)
    TriggerEvent("MakniHud", true)
    ESX.TriggerServerCallback('oglasi:DajOglase', function(ogl)
        for i=1, 16, 1 do
            if ogl[i] ~= nil then
                SendNUIMessage({
                    dodajoglas = true,
                    ime = ogl[i].firstname,
                    prezime = ogl[i].lastname,
                    broj = ogl[i].broj,
                    tekst = ogl[i].tekst
                })
            else
                SendNUIMessage({
                    dodajoglas = true,
                    ime = "Ime",
                    prezime = "Prezime",
                    broj = "1234567",
                    tekst = "Ovdje se može nalaziti vaš oglas! Posjetite nas."
                })
            end
        end
        SendNUIMessage({
            prikazi = true
        })
    end)
end)

RegisterNUICallback(
    "zatvori",
    function()
		SetNuiFocus(false)
		TriggerEvent("MakniHud", false)
    end
)
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterCommand("oglas", function(source, args, raw)
	if args[1] then
        ESX.TriggerServerCallback('oglasi:DohvatiPodatke', function(ime, prez, broj)
            SendNUIMessage({
                dodajoglas = true,
                ime = ime,
                prezime = prez,
                broj = broj,
                tekst = table.concat(args, " ")
            })
        end)
    else
        ESX.ShowNotification("Upisite tekst oglasa!")
    end
end)

RegisterNetEvent('oglasi:OtvoriNovine')
AddEventHandler('oglasi:OtvoriNovine', function()
    SetNuiFocus(true, true)
    TriggerEvent("MakniHud", true)
    SendNUIMessage({
        prikazi = true
    })
end)

RegisterNUICallback(
    "zatvori",
    function()
		SetNuiFocus(false)
		TriggerEvent("MakniHud", false)
    end
)
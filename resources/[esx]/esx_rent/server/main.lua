ESX = nil
local Rent = {}
local Ucitao = false

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

MySQL.ready(function()
	UcitajRent()
end)

function UcitajRent()
	Rent = {}
	MySQL.Async.fetchAll(
      'SELECT * FROM rent',
      {},
      function(result)
        for i=1, #result, 1 do
            local kord = json.decode(result[i].koord)
            local vekt = vector3(kord.x, kord.y, kord.z)
			table.insert(Rent, {ID = result[i].ID, ime = result[i].ime, koord = vekt, vlasnik = result[i].vlasnik, sef = result[i].sef, cijena = result[i].cijena})
        end
        Ucitao = true
      end
    )
end

ESX.RegisterServerCallback('rent:DohvatiRent', function(source, cb)
    while not Ucitao do
        Wait(100)
    end
	cb(Rent)
end)

RegisterNetEvent('rent:NapraviRent')
AddEventHandler('rent:NapraviRent', function(ime, coord, cij)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer.getPerm() > 0 then
        MySQL.Async.insert('INSERT INTO rent (ime, koord, cijena) VALUES (@ime, @ko, @cij)',{
            ['@ime'] = ime,
            ['@ko'] = json.encode(coord),
            ['@cij'] = cij
        }, function(id)
            table.insert(Rent, {ID = id, ime = ime, koord = coord, vlasnik = nil, sef = 0, cijena = cij})
            TriggerClientEvent("rent:VratiRent", -1, Rent)
        end)
    else
        xPlayer.showNotification("Niste admin.")
    end
end)

RegisterNetEvent('rent:UrediKoord')
AddEventHandler('rent:UrediKoord', function(id, coord)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer.getPerm() > 0 then
        MySQL.Async.execute('UPDATE rent SET `koord` = @kor WHERE ID = @id',{
            ['@kor'] = json.encode(coord),
            ['@id'] = id
        })
        for i=1, #Rent, 1 do
            if Rent[i] ~= nil then
                if Rent[i].ID == id then
                    Rent[i].koord = coord
                    break
                end
            end
        end
        TriggerClientEvent("rent:VratiRent", -1, Rent)
    else
        xPlayer.showNotification("Niste admin.")
    end
end)

RegisterNetEvent('rent:PrCijenu')
AddEventHandler('rent:PrCijenu', function(id, cij)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer.getPerm() > 0 then
        MySQL.Async.execute('UPDATE rent SET `cijena` = @cij WHERE ID = @id',{
            ['@cij'] = cij,
            ['@id'] = id
        })
        for i=1, #Rent, 1 do
            if Rent[i] ~= nil then
                if Rent[i].ID == id then
                    Rent[i].cijena = cij
                    break
                end
            end
        end
        TriggerClientEvent("rent:VratiRent", -1, Rent)
    else
        xPlayer.showNotification("Niste admin.")
    end
end)

RegisterNetEvent('rent:MakniVlasnika')
AddEventHandler('rent:MakniVlasnika', function(id)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer.getPerm() > 0 then
        MySQL.Async.execute('UPDATE rent SET `vlasnik` = @vl WHERE ID = @id',{
            ['@vl'] = nil,
            ['@id'] = id
        })
        for i=1, #Rent, 1 do
            if Rent[i] ~= nil then
                if Rent[i].ID == id then
                    Rent[i].vlasnik = nil
                    break
                end
            end
        end
        TriggerClientEvent("rent:VratiRent", -1, Rent)
    else
        xPlayer.showNotification("Niste admin.")
    end
end)

RegisterNetEvent('rent:ObrisiRent')
AddEventHandler('rent:ObrisiRent', function(id)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer.getPerm() > 0 then
        MySQL.Async.execute('DELETE FROM rent WHERE ID = @id',{
            ['@id'] = id
        })
        for i=1, #Rent, 1 do
            if Rent[i] ~= nil then
                if Rent[i].ID == id then
                    table.remove(Rent, i)
                    break
                end
            end
        end
        TriggerClientEvent("rent:VratiRent", -1, Rent)
    else
        xPlayer.showNotification("Niste admin.")
    end
end)

RegisterNetEvent('rent:UzmiIzSefaAdm')
AddEventHandler('rent:UzmiIzSefaAdm', function(id, kol)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer.getPerm() > 0 then
        MySQL.Async.execute('UPDATE rent SET `sef` = sef-@sef WHERE ID = @id',{
            ['@sef'] = kol,
            ['@id'] = id
        })
        for i=1, #Rent, 1 do
            if Rent[i] ~= nil then
                if Rent[i].ID == id then
                    Rent[i].sef = Rent[i].sef-kol
                    xPlayer.showNotification("Uzeli ste iz sefa $"..kol)
                    break
                end
            end
        end
        TriggerClientEvent("rent:VratiRent", -1, Rent)
    else
        xPlayer.showNotification("Niste admin.")
    end
end)

RegisterNetEvent('rent:OstaviUSefAdm')
AddEventHandler('rent:OstaviUSefAdm', function(id, kol)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer.getPerm() > 0 then
        MySQL.Async.execute('UPDATE rent SET `sef` = sef+@sef WHERE ID = @id',{
            ['@sef'] = kol,
            ['@id'] = id
        })
        for i=1, #Rent, 1 do
            if Rent[i] ~= nil then
                if Rent[i].ID == id then
                    Rent[i].sef = Rent[i].sef+kol
                    xPlayer.showNotification("Ostavili ste u sef $"..kol)
                    break
                end
            end
        end
        TriggerClientEvent("rent:VratiRent", -1, Rent)
    else
        xPlayer.showNotification("Niste admin.")
    end
end)
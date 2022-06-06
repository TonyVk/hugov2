ESX               = nil
local Vrata = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

MySQL.ready(function()
	UcitajVrata()
end)

function UcitajVrata()
	Vrata = {}
	MySQL.Async.fetchAll(
      'SELECT * FROM vrata order by ID',
      {},
      function(result)
        for i=1, #result, 1 do
			local kord = nil
            local ete = json.decode(result[i].koord)
            kord = vector3(ete.x, ete.y,ete.z)
			table.insert(Vrata, {objekt = nil, ime = result[i].ime, koord = kord, posao = result[i].posao, dist = result[i].dist, lock = 4, model = tonumber(result[i].model), banka = result[i].banka})
        end
		TriggerClientEvent("vrata:VratiVrata", -1, Vrata)
      end
    )
end

ESX.RegisterServerCallback('vrata:DohvatiVrata', function(source, cb)
    while #Vrata == 0 do
        Wait(100)
    end
	cb(Vrata)
end)

RegisterNetEvent('vrata:DodajVrata')
AddEventHandler('vrata:DodajVrata', function(ime, coord, posao, dist, model)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getPerm() >= 1 then
        table.insert(Vrata, {objekt = nil, ime = ime, koord = vector3(coord.x, coord.y, coord.z), posao = posao, dist = dist, lock = 4, model = tonumber(model), banka = 0})
        MySQL.Async.execute('INSERT INTO vrata (ime, koord, posao, dist, model) VALUES (@ime, @ko, @pos, @dist, @model)',{
            ['@ime'] = ime,
            ['@ko'] = json.encode(coord),
            ['@pos'] = posao,
            ['@dist'] = dist,
            ['@model'] = model
        })
        TriggerClientEvent("vrata:VratiVrata", -1, Vrata)
    end
end)

RegisterNetEvent('vrata:UrediPosao')
AddEventHandler('vrata:UrediPosao', function(ime, posao)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getPerm() >= 1 then
        for i=1, #Vrata, 1 do
            if Vrata[i].ime == ime then
                Vrata[i].posao = posao
                break
            end
        end
        MySQL.Async.execute('UPDATE vrata SET `posao` = @po WHERE ime = @ime',{
            ['@po'] = posao,
            ['@ime'] = ime
        })
        TriggerClientEvent("vrata:VratiVrata", -1, Vrata)
    end
end)

RegisterNetEvent('vrata:VrataBanke')
AddEventHandler('vrata:VrataBanke', function(ime)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getPerm() >= 1 then
        local bank
        for i=1, #Vrata, 1 do
            if Vrata[i].ime == ime then
                if Vrata[i].banka == 0 then
                    Vrata[i].banka = 1
                else
                    Vrata[i].banka = 0
                end
                bank = Vrata[i].banka
                break
            end
        end
        MySQL.Async.execute('UPDATE vrata SET `banka` = @ba WHERE ime = @ime',{
            ['@ba'] = bank,
            ['@ime'] = ime
        })
        if bank == 0 then
            xPlayer.showNotification("Postavili ste da vrata nisu od banke")
        else
            xPlayer.showNotification("Postavili ste da su vrata od banke")
        end
        TriggerClientEvent("vrata:VratiVrata", -1, Vrata)
    end
end)

RegisterNetEvent('vrata:UrediDist')
AddEventHandler('vrata:UrediDist', function(ime, dist)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getPerm() >= 1 then
        for i=1, #Vrata, 1 do
            if Vrata[i].ime == ime then
                Vrata[i].dist = dist
                break
            end
        end
        MySQL.Async.execute('UPDATE vrata SET `dist` = @di WHERE ime = @ime',{
            ['@di'] = dist,
            ['@ime'] = ime
        })
        TriggerClientEvent("vrata:VratiVrata", -1, Vrata)
    end
end)

RegisterNetEvent('vrata:ObrisiVrata')
AddEventHandler('vrata:ObrisiVrata', function(ime)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getPerm() >= 1 then
        for i=1, #Vrata, 1 do
            if Vrata[i].ime == ime then
                table.remove(Vrata, i)
                break
            end
        end
        MySQL.Async.execute('DELETE FROM vrata WHERE ime = @ime',{
            ['@ime'] = ime
        })
        TriggerClientEvent("vrata:ObrisiVrata", -1, ime, Vrata)
    end
end)

RegisterNetEvent('vrata:PromjeniLock')
AddEventHandler('vrata:PromjeniLock', function(ime, lock)
	for i=1, #Vrata, 1 do
        if Vrata[i].ime == ime then
            Vrata[i].lock = lock
            break
        end
    end
    TriggerClientEvent("vrata:VratiLock", -1, ime, lock)
end)
ESX               = nil
local Safezone = {}
local Ucitao = false

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

MySQL.ready(function()
	UcitajSafeZone()
end)

function UcitajSafeZone()
	Safezone = {}
	MySQL.Async.fetchAll(
      'SELECT * FROM safezone',
      {},
      function(result)
        for i=1, #result, 1 do
			local data = json.decode(result[i].koord)
			local tabl = {}
			for i=1, #data, 1 do
				table.insert(tabl, vector2(data[i].x, data[i].y))
			end
			table.insert(Safezone, {zona = nil, ID = result[i].ID, ime = result[i].ime, koord = tabl})
        end
        Ucitao = true
		--TriggerClientEvent("safezona:VratiZone", -1, Safezone)
      end
    )
end

ESX.RegisterServerCallback('safezona:DohvatiZone', function(source, cb)
    while not Ucitao do
        Wait(100)
    end
	cb(Safezone)
end)

RegisterNetEvent('safezona:DodajZonu')
AddEventHandler('safezona:DodajZonu', function(ime, coord)
    print("picko")
    MySQL.Async.insert('INSERT INTO safezone (ime, koord) VALUES (@ime, @ko)',{
		['@ime'] = ime,
		['@ko'] = json.encode(coord)
	}, function(id)
        table.insert(Safezone, {zona = nil, ID = id, ime = ime, koord = coord})
    end)
    TriggerClientEvent("safezona:VratiZonu", -1, Safezone, ime, coord)
end)

RegisterNetEvent('safezona:ObrisiZonu')
AddEventHandler('safezona:ObrisiZonu', function(id)
	for i=1, #Safezone, 1 do
        if Safezone[i].ID == id then
            table.remove(Safezone, i)
            break
        end
    end
    MySQL.Async.execute('DELETE FROM safezone WHERE ID = @id',{
        ['@id'] = id
    })
    TriggerClientEvent("safezona:ObrisiZonu", -1, Safezone, id)
end)
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local Oglasi = {}

RegisterNetEvent('oglasi:DodajOglas')
AddEventHandler('oglasi:DodajOglas', function(tekst)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.getMoney() >= 50 then
        xPlayer.removeMoney(50)
        MySQL.Async.insert('INSERT INTO yellow_tweets (phone_number, firstname, lastname, message, novine) VALUES (@br, @ime, @prez, @tekst, 0)',{
            ['@br'] = xPlayer.getNumber(),
            ['@ime']  = xPlayer.getFirstname(),
            ['@prez']  = xPlayer.getLastname(),
            ['@tekst']  = tekst
        }, function(insertId)
            MySQL.Async.fetchAll("select @s:=@s+1 as br, id from yellow_tweets, (SELECT @s:= 0) AS s where novine = 0", {}, function(result)
                local broj = 0
                for i=1, #result, 1 do
                    if result[i] and result[i].id == insertId then
                        broj = math.floor(tonumber(result[i].br)/16)
                        break
                    end
                end
                if broj == 0 then
                    broj = 1
                end
                xPlayer.showNotification("Vaš oglas će završiti na oglasniku za "..broj.."h")
            end)
        end)
    else
        xPlayer.showNotification("Nemate $50.")
    end
end)

ESX.RegisterServerCallback('oglasi:DajOglase', function(source, cb)
    cb(Oglasi)
end)

ESX.RegisterUsableItem('novine', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local item = xPlayer.getInventoryItem("novine")
    if item.count >= 1 then
        TriggerClientEvent("esx_invh:closeinv", _source)
        TriggerClientEvent("oglasi:OtvoriNovine", _source)
        xPlayer.removeInventoryItem("novine", 1)
    end
end)

function DohvatiOglase()
    Oglasi = {}
    MySQL.Async.fetchAll("select id, phone_number as broj, firstname, lastname, message as tekst from yellow_tweets where novine = 0 limit 16", {}, function(result)
		Oglasi = result
        TriggerClientEvent('chat:addMessage', -1, { args = { '^1NOVINE', 'Izašao je novi broj oglasnika!' } })
        for i=1, #result, 1 do
            MySQL.Async.execute('UPDATE yellow_tweets SET novine = 1 WHERE id = @id', {
				['@id'] = result[i].id
			})
        end
	end)
    SetTimeout(3600000, DohvatiOglase) --1h
end

MySQL.ready(function ()
    DohvatiOglase()
end)
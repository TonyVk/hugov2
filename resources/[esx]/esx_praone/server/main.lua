ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local Praone = {}
local Ucitao = false

ESX.RegisterServerCallback('praone:DohvatiPraone', function(source, cb)
    while not Ucitao do
        Wait(100)
    end
	cb(Praone)
end)

MySQL.ready(function()
	UcitajPraone()
end)

function UcitajPraone()
	Praone = {}
	MySQL.Async.fetchAll(
      'SELECT * FROM praone order by ID',
      {},
      function(result)
        for i=1, #result, 1 do
			local kord = nil
            local ete = json.decode(result[i].koord)
            kord = vector3(ete.x, ete.y, ete.z)
			local kord2 = nil
			if result[i].pranje then
				local ete2 = json.decode(result[i].pranje)
            	kord2 = vector3(ete2.x, ete2.y, ete2.z)
			end
			table.insert(Praone, {ID = tonumber(result[i].ID), koord = kord, pranje = kord2, vlasnik = result[i].vlasnik, cijena = tonumber(result[i].cijena), sef = tonumber(result[i].sef), kcijena = tonumber(result[i].kcijena)})
        end
        Ucitao = true
		TriggerClientEvent("praone:VratiPraone", -1, Praone)
      end
    )
end

ESX.RegisterServerCallback('praone:DajBrojPraona', function(source, cb)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local br = 0
	for i=1, #Praone, 1 do
		if Praone[i] ~= nil and Praone[i].vlasnik == xPlayer.getID() then
			br = br+1
		end
	end
	cb(br)
end)

RegisterNetEvent('praone:DodajNovu')
AddEventHandler('praone:DodajNovu', function(coord, cijena)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getPerm() >= 1 then
		MySQL.Async.insert('INSERT INTO praone (koord, cijena, kcijena) VALUES (@ko, 50, @ci)',{
			['@ko'] = json.encode(coord),
			['@ci'] = cijena
		}, function(id)
			table.insert(Praone, {ID = id, koord = vector3(coord.x, coord.y, coord.z), vlasnik = nil, pranje = nil, cijena = 50, sef = 0, kcijena = cijena})
        	TriggerClientEvent("praone:VratiPraone", -1, Praone)
		end)
    end
end)

RegisterNetEvent('praone:UrediCijenu')
AddEventHandler('praone:UrediCijenu', function(id, cijena)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getPerm() >= 1 then
        for i=1, #Praone, 1 do
            if Praone[i].ID == id then
                Praone[i].cijena = cijena
                break
            end
        end
        MySQL.Async.execute('UPDATE praone SET `cijena` = @ci WHERE ID = @id',{
            ['@ci'] = cijena,
            ['@id'] = id
        })
        TriggerClientEvent("praone:VratiPraone", -1, Praone)
    end
end)

RegisterNetEvent('praone:UrediCijenuPraone')
AddEventHandler('praone:UrediCijenuPraone', function(id, cijena)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getPerm() >= 1 then
        for i=1, #Praone, 1 do
            if Praone[i].ID == id then
                Praone[i].kcijena = cijena
                break
            end
        end
        MySQL.Async.execute('UPDATE praone SET `kcijena` = @ci WHERE ID = @id',{
            ['@ci'] = cijena,
            ['@id'] = id
        })
        TriggerClientEvent("praone:VratiPraone", -1, Praone)
    end
end)

RegisterNetEvent('praone:StanjeSefa')
AddEventHandler('praone:StanjeSefa', function(id)
    local xPlayer = ESX.GetPlayerFromId(source)
	for i=1, #Praone, 1 do
		if Praone[i].ID == id then
			xPlayer.showNotification("U sefu se nalazi $"..ESX.Math.GroupDigits(Praone[i].sef))
			break
		end
	end
end)

RegisterNetEvent('praone:UzmiIzSefa')
AddEventHandler('praone:UzmiIzSefa', function(id, cijena)
    local xPlayer = ESX.GetPlayerFromId(source)
	for i=1, #Praone, 1 do
		if Praone[i].ID == id then
			if Praone[i].sef >= cijena then
				Praone[i].sef = Praone[i].sef-cijena
				xPlayer.showNotification("Uzeli ste $"..cijena.." iz sefa!")
				MySQL.Async.execute('UPDATE praone SET `sef` = @se WHERE ID = @id',{
					['@se'] = Praone[i].sef,
					['@id'] = id
				})
			else
				xPlayer.showNotification("U sefu nemate toliko novca!")
			end
			break
		end
	end
end)

RegisterNetEvent('praone:ProdajPraonu')
AddEventHandler('praone:ProdajPraonu', function(id)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    for i=1, #Praone, 1 do
        if Praone[i] ~= nil then
            if Praone[i].ID == id then
                if Praone[i].vlasnik == xPlayer.getID() then
                    MySQL.Async.execute('UPDATE praone SET `vlasnik` = @vl WHERE ID = @id',{
                        ['@vl'] = nil,
                        ['@id'] = id
                    })
                    Praone[i].vlasnik = nil
                    xPlayer.showNotification("Prodali ste praonu drzavi za $"..math.ceil(Praone[i].kcijena/2))
                    xPlayer.addMoney(math.ceil(Praone[i].kcijena/2))
                    TriggerClientEvent("praone:VratiPraone", -1, Praone)
                end
                break
            end
        end
    end
end)

RegisterNetEvent('praone:PonudiIgracu')
AddEventHandler('praone:PonudiIgracu', function(id, cij, prIgr)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    for i=1, #Praone, 1 do
        if Praone[i] ~= nil then
            if Praone[i].ID == id then
                if Praone[i].vlasnik == xPlayer.getID() then
                    xPlayer.showNotification("Poslali ste ponudu igracu.")
                    TriggerClientEvent("upit:OtvoriPitanje", prIgr, "esx_praone", "Kupovina praone", "Zelite li kupiti praonu #"..Praone[i].ID.." za $"..cij.." ?", {cijena = cij, id = id, orgIgr = src})
                end
                break
            end
        end
    end
end)

RegisterNetEvent('praone:PrihvatiPonudu')
AddEventHandler('praone:PrihvatiPonudu', function(orgIgr, id, cij)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local vlPlayer = ESX.GetPlayerFromId(orgIgr)
    if xPlayer.getMoney() >= cij then
        for i=1, #Praone, 1 do
            if Praone[i] ~= nil then
                if Praone[i].ID == id then
                    if Praone[i].vlasnik == vlPlayer.getID() then
                        xPlayer.removeMoney(cij)
                        vlPlayer.addMoney(cij)
                        MySQL.Async.execute('UPDATE praone SET `vlasnik` = @vl WHERE ID = @id',{
                            ['@vl'] = xPlayer.getID(),
                            ['@id'] = id
                        })
                        Praone[i].vlasnik = xPlayer.getID()
						TriggerClientEvent("praone:VratiPraone", -1, Praone)
                        xPlayer.showNotification("Kupili ste praonu #"..Praone[i].ID.." za $"..cij)
                        vlPlayer.showNotification("Prodali ste praonu #"..Praone[i].ID.." za $"..cij)
                    else
                        xPlayer.showNotification("Igrac nije vlasnik praone!")
                        vlPlayer.showNotification("Niste vlasnik praone!")
                    end
                    break
                end
            end
        end
    else
        xPlayer.showNotification("Nemate dovoljno novca kod sebe.")
        vlPlayer.showNotification("Igrac nema dovoljno novca.")
    end
end)

RegisterNetEvent('praone:OdbijPonudu')
AddEventHandler('praone:OdbijPonudu', function(orgIgr)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local vlPlayer = ESX.GetPlayerFromId(orgIgr)
    xPlayer.showNotification("Odbili ste ponudu!")
    vlPlayer.showNotification("Igrac je odbio ponudu!")
end)

RegisterNetEvent('praone:SpremiPranje')
AddEventHandler('praone:SpremiPranje', function(id, koord)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getPerm() >= 1 then
        for i=1, #Praone, 1 do
            if Praone[i].ID == id then
                Praone[i].pranje = vector3(koord.x, koord.y, koord.z)
                break
            end
        end
        MySQL.Async.execute('UPDATE praone SET `pranje` = @ko WHERE ID = @id',{
            ['@ko'] = json.encode(koord),
            ['@id'] = id
        })
        TriggerClientEvent("praone:VratiPraone", -1, Praone)
    end
end)

RegisterNetEvent('praone:SpremiVlMenu')
AddEventHandler('praone:SpremiVlMenu', function(id, koord)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getPerm() >= 1 then
        for i=1, #Praone, 1 do
            if Praone[i].ID == id then
                Praone[i].koord = vector3(koord.x, koord.y, koord.z)
                break
            end
        end
        MySQL.Async.execute('UPDATE praone SET `koord` = @ko WHERE ID = @id',{
            ['@ko'] = json.encode(koord),
            ['@id'] = id
        })
        TriggerClientEvent("praone:VratiPraone", -1, Praone)
    end
end)

RegisterNetEvent('praone:MakniVlasnika')
AddEventHandler('praone:MakniVlasnika', function(id)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getPerm() >= 1 then
        for i=1, #Praone, 1 do
            if Praone[i].ID == id then
                Praone[i].vlasnik = nil
                break
            end
        end
        MySQL.Async.execute('UPDATE praone SET `vlasnik` = @vl WHERE ID = @id',{
            ['@vl'] = nil,
            ['@id'] = id
        })
        TriggerClientEvent("praone:VratiPraone", -1, Praone)
    end
end)

RegisterNetEvent('praone:KupiPraonu')
AddEventHandler('praone:KupiPraonu', function(id)
    print(id)
    local xPlayer = ESX.GetPlayerFromId(source)
	for i=1, #Praone, 1 do
		if Praone[i].ID == id then
			if Praone[i].kcijena <= xPlayer.getMoney() then
				xPlayer.removeMoney(Praone[i].kcijena)
				Praone[i].vlasnik = xPlayer.getID()
				MySQL.Async.execute('UPDATE praone SET `vlasnik` = @vl WHERE ID = @id',{
					['@vl'] = xPlayer.getID(),
					['@id'] = id
				})
				TriggerClientEvent("praone:VratiPraone", -1, Praone)
			else
				xPlayer.showNotification("Nemate dovoljno novca!")
			end
			break
		end
	end
end)

RegisterNetEvent('praone:ObrisiPraone')
AddEventHandler('praone:ObrisiPraone', function(id)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getPerm() >= 1 then
        for i=1, #Praone, 1 do
            if Praone[i].ID == id then
                table.remove(Praone, i)
                break
            end
        end
        MySQL.Async.execute('DELETE FROM praone WHERE ID = @id',{
            ['@id'] = id
        })
        TriggerClientEvent("praone:VratiPraone", -1, Praone)
    end
end)

ESX.RegisterServerCallback('praone:JesilVlasnik', function(source, cb, id)
	local xPlayer = ESX.GetPlayerFromId(source)
	local naso = false
    local kupljeno = false
	for i=1, #Praone, 1 do
		if Praone[i].ID == id then
            if Praone[i].vlasnik == xPlayer.getID() then
			    naso = true
            end
            if Praone[i].vlasnik ~= nil then
                kupljeno = true
            end
			break
		end
	end
	cb(naso, kupljeno)
end)

ESX.RegisterServerCallback('praone:DajCijenu', function(source, cb, id)
	local xPlayer = ESX.GetPlayerFromId(source)
	for i=1, #Praone, 1 do
		if Praone[i].ID == id then
			cb(Praone[i].cijena)
			break
		end
	end
end)

ESX.RegisterServerCallback('praone:DajProdajnu', function(source, cb, id)
	for i=1, #Praone, 1 do
		if Praone[i].ID == id then
			cb(Praone[i].kcijena)
			break
		end
	end
end)

ESX.RegisterServerCallback('praone:OperiMe', function(source, cb, id)
	local xPlayer = ESX.GetPlayerFromId(source)
	local cijena = 50
	for i=1, #Praone, 1 do
		if Praone[i].ID == id then
			cijena = Praone[i].cijena
			break
		end
	end
    if xPlayer.getMoney() >= cijena then
        xPlayer.removeMoney(cijena)
        DodajLovu(id, cijena)
        cb(true, cijena)
    else
        cb(false, cijena)
    end
end)

function DodajLovu(id, br)
	for i=1, #Praone, 1 do
		if Praone[i].ID == id then
			Praone[i].sef = Praone[i].sef+(br*0.40)
			MySQL.Async.execute('UPDATE praone SET `sef` = @se WHERE ID = @id',{
				['@se'] = Praone[i].sef,
				['@id'] = id
			})
			break
		end
	end
end
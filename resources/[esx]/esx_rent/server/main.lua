ESX = nil
local Rent = {}
local Ucitao = false
local Vozila = {}

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
			table.insert(Rent, {ID = result[i].ID, ime = result[i].ime, koord = vekt, vlasnik = result[i].vlasnik, sef = result[i].sef, cijena = tonumber(result[i].cijena), vozila = json.decode(result[i].vozila)})
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

ESX.RegisterServerCallback('rent:RentajVozilo', function(source, cb, id, sime)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer then
        for i=1, #Rent, 1 do
            if Rent[i] ~= nil then
                if Rent[i].ID == id then
                    local voz = Rent[i].vozila
                    local naso = false
                    for v=1, #voz, 1 do
                        if voz[v].value == sime then
                            naso = true
                            if xPlayer.getMoney() >= voz[v].cijena then
                                xPlayer.removeMoney(voz[v].cijena)
                                xPlayer.showNotification("Rentali ste vozilo za $"..voz[v].cijena)
                                local sefCifra = voz[v].cijena*0.60
                                Rent[i].sef = Rent[i].sef+sefCifra
                                MySQL.Async.execute('UPDATE rent SET `sef` = @sef WHERE ID = @id',{
                                    ['@sef'] = Rent[i].sef,
                                    ['@id'] = id
                                })
                                TriggerClientEvent("rent:UpdateSef", -1, id, Rent[i].sef)
                                cb(true)
                            else
                                xPlayer.showNotification("Nemate dovoljno novca.")
                                cb(false)
                            end
                        end
                    end
                    if not naso then
                        xPlayer.showNotification("Greska! Vozilo se vise ne nalazi u ovom rentu.")
                        cb(false)
                    end
                    break
                end
            end
        end
    end
end)

ESX.RegisterServerCallback('rent:UzmiLovu', function(source, cb, id, sime)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer then
        for i=1, #Rent, 1 do
            if Rent[i] ~= nil then
                if Rent[i].ID == id then
                    local voz = Rent[i].vozila
                    local naso = false
                    for v=1, #voz, 1 do
                        if voz[v].value == sime then
                            naso = true
                            if xPlayer.getMoney() >= voz[v].cijena then
                                xPlayer.removeMoney(voz[v].cijena)
                                xPlayer.showNotification("Platili ste rent vozila $"..voz[v].cijena)
                                xPlayer.showNotification("Da prestanete rentati upisite /unrent")
                                local sefCifra = voz[v].cijena*0.60
                                Rent[i].sef = Rent[i].sef+sefCifra
                                MySQL.Async.execute('UPDATE rent SET `sef` = @sef WHERE ID = @id',{
                                    ['@sef'] = Rent[i].sef,
                                    ['@id'] = id
                                })
                                TriggerClientEvent("rent:UpdateSef", -1, id, Rent[i].sef)
                                cb(true)
                            else
                                xPlayer.showNotification("Nemate dovoljno novca za nastavak rentanja vozila.")
                                cb(false)
                            end
                        end
                    end
                    if not naso then
                        xPlayer.showNotification("Greska! Vozilo se vise ne nalazi u ovom rentu.")
                        cb(false)
                    end
                    break
                end
            end
        end
    end
end)

ESX.RegisterServerCallback('rent:KupiFirmu', function(source, cb, id)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer then
        local naso = false
        for i=1, #Rent, 1 do
            if Rent[i] ~= nil then
                if Rent[i].ID == id then
                    naso = true
                    if Rent[i].vlasnik == nil then
                        if xPlayer.getMoney() >= Rent[i].cijena then
                            xPlayer.removeMoney(Rent[i].cijena)
                            xPlayer.showNotification("Kupili ste "..Rent[i].ime)
                            Rent[i].vlasnik = xPlayer.getID()
                            MySQL.Async.execute('UPDATE rent SET `vlasnik` = @vl WHERE ID = @id',{
                                ['@vl'] = xPlayer.getID(),
                                ['@id'] = id
                            })
                            TriggerClientEvent("rent:UpdateVlasnika", -1, id, Rent[i].vlasnik)
                            cb(true)
                        else
                            xPlayer.showNotification("Nemate dovoljno novca. Fali vam $"..(Rent[i].cijena-xPlayer.getMoney()))
                            cb(false)
                        end
                    else
                        xPlayer.showNotification("Firma je vec kupljena!")
                        cb(false)
                    end
                    break
                end
            end
        end
        if not naso then
            xPlayer.showNotification("Firma nije pronadjena!")
            cb(false)
        end
    else
        cb(false)
    end
end)

ESX.RegisterServerCallback('rent:DajID', function(source, cb)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer then
        cb(xPlayer.getID())
    else
        cb(0)
    end
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
            table.insert(Rent, {ID = id, ime = ime, koord = coord, vlasnik = nil, sef = 0, cijena = cij, vozila = nil})
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
                    TriggerClientEvent("rent:UpdateSef", -1, id, Rent[i].sef)
                    xPlayer.showNotification("Uzeli ste iz sefa $"..kol)
                    break
                end
            end
        end
        --TriggerClientEvent("rent:VratiRent", -1, Rent)
    else
        xPlayer.showNotification("Niste admin.")
    end
end)

RegisterNetEvent('rent:UzmiIzSefa')
AddEventHandler('rent:UzmiIzSefa', function(id, kol)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    for i=1, #Rent, 1 do
        if Rent[i] ~= nil then
            if Rent[i].ID == id then
                if Rent[i].vlasnik == xPlayer.getID() then
                    if Rent[i].sef >= kol then
                        MySQL.Async.execute('UPDATE rent SET `sef` = sef-@sef WHERE ID = @id',{
                            ['@sef'] = kol,
                            ['@id'] = id
                        })
                        Rent[i].sef = Rent[i].sef-kol
                        TriggerClientEvent("rent:UpdateSef", -1, id, Rent[i].sef)
                        xPlayer.addMoney(kol)
                        xPlayer.showNotification("Uzeli ste iz sefa $"..kol)
                    else
                        xPlayer.showNotification("Nemate toliko novca u sefu.")
                    end
                end
                break
            end
        end
    end
end)

RegisterNetEvent('rent:ProdajFirmu')
AddEventHandler('rent:ProdajFirmu', function(id)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    for i=1, #Rent, 1 do
        if Rent[i] ~= nil then
            if Rent[i].ID == id then
                if Rent[i].vlasnik == xPlayer.getID() then
                    MySQL.Async.execute('UPDATE rent SET `vlasnik` = @vl WHERE ID = @id',{
                        ['@vl'] = nil,
                        ['@id'] = id
                    })
                    Rent[i].vlasnik = nil
                    xPlayer.showNotification("Prodali ste "..Rent[i].ime.." drzavi za $"..math.ceil(Rent[i].cijena/2))
                    xPlayer.addMoney(math.ceil(Rent[i].cijena/2))
                    TriggerClientEvent("rent:UpdateVlasnika", -1, id, Rent[i].vlasnik)
                end
                break
            end
        end
    end
end)

RegisterNetEvent('rent:PonudiIgracu')
AddEventHandler('rent:PonudiIgracu', function(id, cij, prIgr)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    for i=1, #Rent, 1 do
        if Rent[i] ~= nil then
            if Rent[i].ID == id then
                if Rent[i].vlasnik == xPlayer.getID() then
                    xPlayer.showNotification("Poslali ste ponudu igracu.")
                    TriggerClientEvent("upit:OtvoriPitanje", prIgr, "esx_rent", "Kupovina firme", "Zelite li kupiti "..Rent[i].ime.." za $"..cij.." ?", {cijena = cij, id = id, orgIgr = src})
                end
                break
            end
        end
    end
end)

RegisterNetEvent('rent:PrihvatiPonudu')
AddEventHandler('rent:PrihvatiPonudu', function(orgIgr, id, cij)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local vlPlayer = ESX.GetPlayerFromId(orgIgr)
    if xPlayer.getMoney() >= cij then
        for i=1, #Rent, 1 do
            if Rent[i] ~= nil then
                if Rent[i].ID == id then
                    if Rent[i].vlasnik == vlPlayer.getID() then
                        xPlayer.removeMoney(cij)
                        vlPlayer.addMoney(cij)
                        MySQL.Async.execute('UPDATE rent SET `vlasnik` = @vl WHERE ID = @id',{
                            ['@vl'] = xPlayer.getID(),
                            ['@id'] = id
                        })
                        Rent[i].vlasnik = xPlayer.getID()
                        TriggerClientEvent("rent:UpdateVlasnika", -1, id, Rent[i].vlasnik)
                        xPlayer.showNotification("Kupili ste "..Rent[i].ime.." za $"..cij)
                        vlPlayer.showNotification("Prodali ste "..Rent[i].ime.." za $"..cij)
                    else
                        xPlayer.showNotification("Igrac nije vlasnik firme!")
                        vlPlayer.showNotification("Niste vlasnik firme!")
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

RegisterNetEvent('rent:SpremiVozilo')
AddEventHandler('rent:SpremiVozilo', function(nid)
    local src = source
    table.insert(Vozila, {netid = nid, source = src})
end)

RegisterNetEvent('rent:MakniVozilo')
AddEventHandler('rent:MakniVozilo', function()
    local src = source
    for i=1, #Vozila, 1 do
		if Vozila[i] ~= nil and Vozila[i].source == src then
            local ent = NetworkGetEntityFromNetworkId(Vozila[i].netid)
			DeleteEntity(ent)
            table.remove(Vozila, i)
            break
        end
    end
end)

AddEventHandler('playerDropped', function()
	for i=1, #Vozila, 1 do
		if Vozila[i] ~= nil and Vozila[i].source == source then
            local ent = NetworkGetEntityFromNetworkId(Vozila[i].netid)
			DeleteEntity(ent)
            table.remove(Vozila, i)
			break
		end
	end
end)

RegisterNetEvent('rent:OdbijPonudu')
AddEventHandler('rent:OdbijPonudu', function(orgIgr)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local vlPlayer = ESX.GetPlayerFromId(orgIgr)
    xPlayer.showNotification("Odbili ste ponudu!")
    vlPlayer.showNotification("Igrac je odbio ponudu!")
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
                    TriggerClientEvent("rent:UpdateSef", -1, id, Rent[i].sef)
                    xPlayer.showNotification("Ostavili ste u sef $"..kol)
                    break
                end
            end
        end
        --TriggerClientEvent("rent:VratiRent", -1, Rent)
    else
        xPlayer.showNotification("Niste admin.")
    end
end)

RegisterNetEvent('rent:SpremiVozilo')
AddEventHandler('rent:SpremiVozilo', function(id, ime, sime, cij)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer.getPerm() > 0 then
        local bla = {label = ime, value = sime, cijena = cij}
        for i=1, #Rent, 1 do
            if Rent[i] ~= nil then
                if Rent[i].ID == id then
                    if Rent[i].vozila == nil then
                        Rent[i].vozila = {}
                    end
                    table.insert(Rent[i].vozila, bla)
                    MySQL.Async.execute('UPDATE rent SET `vozila` = @voz WHERE ID = @id',{
                        ['@voz'] = json.encode(Rent[i].vozila),
                        ['@id'] = id
                    })
                    xPlayer.showNotification("Dodali ste novo vozilo.")
                    TriggerClientEvent("rent:VratiRent", -1, Rent)
                    break
                end
            end
        end
    else
        xPlayer.showNotification("Niste admin.")
    end
end)

RegisterNetEvent('rent:SpremiVCijenu')
AddEventHandler('rent:SpremiVCijenu', function(id, ime, cij)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer.getPerm() > 0 then
        for i=1, #Rent, 1 do
            if Rent[i] ~= nil then
                if Rent[i].ID == id then
                    for v=1, #Rent[i].vozila, 1 do
                        if Rent[i].vozila[v].value == ime then
                            Rent[i].vozila[v].cijena = cij
                            break
                        end
                    end
                    MySQL.Async.execute('UPDATE rent SET `vozila` = @voz WHERE ID = @id',{
                        ['@voz'] = json.encode(Rent[i].vozila),
                        ['@id'] = id
                    })
                    xPlayer.showNotification("Azurirali ste cijenu vozila.")
                    TriggerClientEvent("rent:VratiRent", -1, Rent)
                    break
                end
            end
        end
    else
        xPlayer.showNotification("Niste admin.")
    end
end)

RegisterNetEvent('rent:SpremiVIme')
AddEventHandler('rent:SpremiVIme', function(id, ime, im)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer.getPerm() > 0 then
        for i=1, #Rent, 1 do
            if Rent[i] ~= nil then
                if Rent[i].ID == id then
                    for v=1, #Rent[i].vozila, 1 do
                        if Rent[i].vozila[v].value == ime then
                            Rent[i].vozila[v].label = im
                            break
                        end
                    end
                    MySQL.Async.execute('UPDATE rent SET `vozila` = @voz WHERE ID = @id',{
                        ['@voz'] = json.encode(Rent[i].vozila),
                        ['@id'] = id
                    })
                    xPlayer.showNotification("Azurirali ste ime(label) vozila.")
                    TriggerClientEvent("rent:VratiRent", -1, Rent)
                    break
                end
            end
        end
    else
        xPlayer.showNotification("Niste admin.")
    end
end)

RegisterNetEvent('rent:SpremiVsIme')
AddEventHandler('rent:SpremiVsIme', function(id, ime, sime)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer.getPerm() > 0 then
        for i=1, #Rent, 1 do
            if Rent[i] ~= nil then
                if Rent[i].ID == id then
                    for v=1, #Rent[i].vozila, 1 do
                        if Rent[i].vozila[v].value == ime then
                            Rent[i].vozila[v].value = sime
                            break
                        end
                    end
                    MySQL.Async.execute('UPDATE rent SET `vozila` = @voz WHERE ID = @id',{
                        ['@voz'] = json.encode(Rent[i].vozila),
                        ['@id'] = id
                    })
                    xPlayer.showNotification("Azurirali ste spawn ime vozila.")
                    TriggerClientEvent("rent:VratiRent", -1, Rent)
                    break
                end
            end
        end
    else
        xPlayer.showNotification("Niste admin.")
    end
end)

RegisterNetEvent('rent:ObrisiVozilo')
AddEventHandler('rent:ObrisiVozilo', function(id, ime)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer.getPerm() > 0 then
        for i=1, #Rent, 1 do
            if Rent[i] ~= nil then
                if Rent[i].ID == id then
                    for v=1, #Rent[i].vozila, 1 do
                        if Rent[i].vozila[v].value == ime then
                            table.remove(Rent[i].vozila, v)
                            break
                        end
                    end
                    if #Rent[i].vozila == 0 then
                        Rent[i].vozila = nil
                        MySQL.Async.execute('UPDATE rent SET `vozila` = null WHERE ID = @id',{
                            ['@id'] = id
                        })
                        xPlayer.showNotification("Obrisali ste vozilo.")
                        TriggerClientEvent("rent:VratiRent", -1, Rent)
                    else
                        MySQL.Async.execute('UPDATE rent SET `vozila` = @voz WHERE ID = @id',{
                            ['@voz'] = json.encode(Rent[i].vozila),
                            ['@id'] = id
                        })
                        xPlayer.showNotification("Obrisali ste vozilo.")
                        TriggerClientEvent("rent:VratiRent", -1, Rent)
                    end
                    break
                end
            end
        end
    else
        xPlayer.showNotification("Niste admin.")
    end
end)
ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local instances = {}
local houses = {}
local trava = {}

RegisterServerEvent('loaf_housing:enterHouse')
AddEventHandler('loaf_housing:enterHouse', function(id, ka)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    MySQL.Async.fetchAll("SELECT house, rentKuca, bought_furniture FROM users WHERE ID = @id", {['@id'] = xPlayer.getID()}, function(result)
        local house = json.decode(result[1].house)
        local rent = result[1].rentKuca
        local furniture = json.decode(result[1]['bought_furniture'])
        if house.houseId == id or rent == id then
            for k, v in pairs(Config.HouseSpawns) do
                if not v['taken'] then
					MySQL.Async.execute("UPDATE users SET last_house=@house WHERE ID=@id", {['@id'] = xPlayer.getID(), ['@house'] = id})
                    TriggerClientEvent('loaf_housing:spawnHouse', xPlayer.source, v['coords'], furniture)
                    instances[src] = {['id'] = ka, ['owner'] = src, ['coords'] = v['coords'], ['housespawn'] = k, ['players'] = {}}
                    instances[src]['players'][src] = src
                    houses[ka] = src
                    SetPlayerRoutingBucket(src, ka)
                    --v['taken'] = true
                    return
                end
            end
        else
            print(('There seems to be some kind of error in the script "%s", #%s tried to enter house %s but he/she doesn\'t own house #%s.'):format(GetCurrentResourceName(), xPlayer.identifier, id, id))
        end
    end)
end)

MySQL.ready(function ()
	MySQL.Async.fetchAll('SELECT ID, prop, door, price, prodaja, vlasnik, rentanje, rentCijena FROM kuce left join bought_houses on bought_houses.houseid=kuce.ID', {}, function(result)
		for i=1, #result, 1 do
			local data = json.decode(result[i].door)
			table.insert(Config.Houses, {['ID'] = result[i].ID, ['prop'] = result[i].prop, ['door'] = vector3(data.x, data.y, data.z), ['price'] = result[i].price, ['prodaja'] = result[i].prodaja, ['vlasnik'] = result[i].vlasnik, ['rentanje'] = tonumber(result[i].rentanje), ['rentCijena'] = tonumber(result[i].rentCijena)})
		end
		Wait(1000)
		TriggerClientEvent("loaf_housing:SaljiKucice", -1, Config.Houses)
	end)
end)

RegisterNetEvent('loaf_housing:DodajKucu')
AddEventHandler('loaf_housing:DodajKucu', function(id, prop, door, price, prod, src)
	table.insert(Config.Houses, {['ID'] = id, ['prop'] = prop, ['door'] = door, ['price'] = price, ['prodaja'] = prod, ['vlasnik'] = nil, rentanje = 0, rentCijena = 20})
	
    local xPlayer = ESX.GetPlayerFromId(src)
    MySQL.Async.fetchScalar("SELECT house FROM users WHERE ID = @id", {['@id'] = xPlayer.getID()}, function(result)
        local house = json.decode(result)
        if house.houseId == 0 then
            MySQL.Async.fetchScalar("SELECT houseid FROM bought_houses WHERE houseid=@houseid", {['@houseid'] = id}, function(result)
                local newHouse = ('{"owns":false,"furniture":[],"houseId":%s}'):format(id)
                if not result then
                    MySQL.Async.execute("UPDATE users SET house=@house WHERE ID=@id", {['@id'] = xPlayer.getID(), ['@house'] = newHouse}) 
					MySQL.Sync.execute("INSERT INTO bought_houses (houseid, vlasnik) VALUES (@houseid, @vlasnik)", {['houseid'] = id, ['vlasnik'] = xPlayer.getID()})
                    for k, v in pairs(Config.Houses) do
                        if v['ID'] == id then
                            v['vlasnik'] = xPlayer.getID()
                            TriggerClientEvent("loaf_housing:SaljiKucice", -1, Config.Houses)
                            break
                        end
                    end
                end
            end)
        end
    end)
end)

RegisterNetEvent('kuce:OdobriRent')
AddEventHandler('kuce:OdobriRent', function(id, rent)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.execute("UPDATE kuce SET rentanje=@rent WHERE ID=@id", {['@id'] = id, ['@rent'] = rent}) 
    for k, v in pairs(Config.Houses) do
		if v['ID'] == id then
			v['rentanje'] = rent
			break
		end
	end
    if rent == 0 then
        xPlayer.showNotification("Zabranili ste rentanje kuce!")
    else
        xPlayer.showNotification("Odobrili ste rentanje kuce!")
    end
	TriggerClientEvent("loaf_housing:SaljiKucice", -1, Config.Houses)
end)

RegisterNetEvent('kuce:StaviRentCijenu')
AddEventHandler('kuce:StaviRentCijenu', function(id, cij)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.execute("UPDATE kuce SET rentCijena=@rent WHERE ID=@id", {['@id'] = id, ['@rent'] = cij}) 
    for k, v in pairs(Config.Houses) do
		if v['ID'] == id then
			v['rentCijena'] = cij
			break
		end
	end
    xPlayer.showNotification("Postavili ste cijenu renta kuce na $"..cij)
	TriggerClientEvent("loaf_housing:SaljiKucice", -1, Config.Houses)
end)

RegisterNetEvent('kuce:RentajKucu')
AddEventHandler('kuce:RentajKucu', function(id)
    local xPlayer = ESX.GetPlayerFromId(source)
    for k, v in pairs(Config.Houses) do
		if v['ID'] == id then
			if xPlayer.getMoney() >= v['rentCijena'] then
                xPlayer.removeMoney(v['rentCijena'])
                xPlayer.showNotification("Iznajmili ste kucu za $"..v['rentCijena'])
                MySQL.Async.execute("UPDATE users SET rentKuca=@rent, rentDatum = NOW() WHERE ID=@id", {['@id'] = xPlayer.getID(), ['@rent'] = id})
                TriggerClientEvent('loaf_housing:reloadHouses', xPlayer.source)
            else
                xPlayer.showNotification("Nemate dovoljno novca kod sebe!")
            end
			break
		end
	end
end)

RegisterNetEvent('kuce:NovaKuca')
AddEventHandler('kuce:NovaKuca', function(prop, door, price)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.insert('insert into kuce(prop, door, price, prodaja) values(@pr, @dr, @pri, @prod)', {
		['@pr'] = prop,
		['@dr'] = json.encode(door),
		['@pri'] = price,
		['@prod'] = 0
	}, function(insertid)
		table.insert(Config.Houses, {['ID'] = insertid, ['prop'] = prop, ['door'] = door, ['price'] = price, ['prodaja'] = 0, ['vlasnik'] = nil, rentanje = 0, rentCijena = 20})
	    TriggerClientEvent("loaf_housing:SaljiKucice", -1, Config.Houses)
        xPlayer.showNotification("Uspjesno dodana kuca!")
	end)
end)

RegisterNetEvent('kuce:PremjestiMarker')
AddEventHandler('kuce:PremjestiMarker', function(id, door)
    local xPlayer = ESX.GetPlayerFromId(source)
	for k, v in pairs(Config.Houses) do
		if v['ID'] == id then
			v['door'] = door
			break
		end
	end
    xPlayer.showNotification("Uspjesno premjestena kuca!")
    MySQL.Async.execute('update kuce set door=@dr where ID=@id', {
		['@dr'] = json.encode(door),
		['@id'] = id
	}, function(insertid)
		TriggerClientEvent("loaf_housing:SaljiKucice", -1, Config.Houses)
	end)
end)

RegisterNetEvent('kuce:PromijeniCijenu')
AddEventHandler('kuce:PromijeniCijenu', function(id, cijena)
    local xPlayer = ESX.GetPlayerFromId(source)
	for k, v in pairs(Config.Houses) do
		if v['ID'] == id then
			v['price'] = cijena
			break
		end
	end
    xPlayer.showNotification("Uspjesno postavljena cijena kuce na $"..cijena)
    MySQL.Async.execute('update kuce set price=@pr where ID=@id', {
		['@pr'] = cijena,
		['@id'] = id
	}, function(insertid)
		TriggerClientEvent("loaf_housing:SaljiKucice", -1, Config.Houses)
	end)
end)

RegisterNetEvent('kuce:PromijeniInt')
AddEventHandler('kuce:PromijeniInt', function(id, int)
    local xPlayer = ESX.GetPlayerFromId(source)
	for k, v in pairs(Config.Houses) do
		if v['ID'] == id then
			v['prop'] = int
			break
		end
	end
    xPlayer.showNotification("Uspjesno postavljen novi interijer kuce")
    MySQL.Async.execute('update kuce set prop=@pr where ID=@id', {
		['@pr'] = int,
		['@id'] = id
	}, function(insertid)
		TriggerClientEvent("loaf_housing:SaljiKucice", -1, Config.Houses)
	end)
end)

RegisterNetEvent('kuce:MakniVlasnika')
AddEventHandler('kuce:MakniVlasnika', function(id)
    local xPlayer = ESX.GetPlayerFromId(source)
	for ka, v in pairs(Config.Houses) do
		local k = v['ID']
		if k == id then
            MySQL.Async.execute("UPDATE users SET house=@house WHERE ID=@identifier", {['@identifier'] = v['vlasnik'], ['@house'] = '{"owns":false,"furniture":[],"houseId":0}'}) 
            MySQL.Async.execute("DELETE FROM bought_houses WHERE houseid=@houseid", {['@houseid'] = id}, function(rez)
                xPlayer.showNotification("Maknuli ste vlasnika na kuci #"..id)
                v['vlasnik'] = nil
                TriggerClientEvent("loaf_housing:SaljiKucice", -1, Config.Houses)
            end)
			break
		end
	end
end)

RegisterNetEvent('kuce:ObrisiKucu')
AddEventHandler('kuce:ObrisiKucu', function(id)
    local xPlayer = ESX.GetPlayerFromId(source)
	for ka, v in pairs(Config.Houses) do
		local k = v['ID']
		if k == id then
            MySQL.Async.execute("UPDATE users SET house=@house WHERE ID=@identifier", {['@identifier'] = v['vlasnik'], ['@house'] = '{"owns":false,"furniture":[],"houseId":0}'}) 
            MySQL.Async.execute("DELETE FROM bought_houses WHERE houseid=@houseid", {['@houseid'] = id})
            MySQL.Async.execute("DELETE FROM kuce WHERE ID=@houseid", {['@houseid'] = id})
			table.remove(Config.Houses, ka)
			break
		end
	end
	TriggerClientEvent("loaf_housing:SaljiKucice", -1, Config.Houses)
end)

RegisterNetEvent('loaf_housing:UrediKucu')
AddEventHandler('loaf_housing:UrediKucu', function(id, door, src)
	for k, v in pairs(Config.Houses) do
		if v['ID'] == id then
			v['door'] = door
			break
		end
	end
	TriggerClientEvent("loaf_housing:SaljiKucice", -1, Config.Houses)
end)

RegisterNetEvent('loaf_housing:ObrisiKucu')
AddEventHandler('loaf_housing:ObrisiKucu', function(id)
	for ka, v in pairs(Config.Houses) do
		local k = v['ID']
		if k == id then
			table.remove(Config.Houses, ka)
			break
		end
	end
	TriggerClientEvent("loaf_housing:SaljiKucice", -1, Config.Houses)
end)

ESX.RegisterServerCallback('loaf_housing:DohvatiZadnjuKucu', function(source, cb)
    local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	MySQL.Async.fetchAll('SELECT last_house, rentKuca, DATEDIFF(NOW(), rentDatum) as datum FROM users WHERE ID = @id', {
		['@id'] = xPlayer.getID()
	}, function(result)
        if result[1].rentKuca ~= nil then
            if result[1].datum == nil or result[1].datum >= 1 then
                for ka, v in pairs(Config.Houses) do
                    local k = v['ID']
                    if k == result[1].rentKuca then
                        if xPlayer.getBank() >= v['rentCijena'] then
                            xPlayer.showNotification("Platili ste rent kuce $"..v['rentCijena'])
                            xPlayer.showNotification("Da prestanete rentati kucu upisite /unrentkucu")
                            xPlayer.removeBank(v['rentCijena'])
                            TriggerEvent("banka:Povijest", xPlayer.source, (-1*tonumber(v['rentCijena'])), "Plaćanje renta kuće")
                            MySQL.Async.execute("UPDATE users SET rentDatum=NOW() WHERE ID=@id", {['@id'] = xPlayer.getID()})
                        else
                            xPlayer.showNotification("Niste imali novca na banci pa ste izbaceni iz kuce.")
                            MySQL.Async.execute("UPDATE users SET rentKuca=null WHERE ID=@id", {['@id'] = xPlayer.getID()})
                            local h2 = {owns = false, furniture = {}, houseId = 0}
                            TriggerClientEvent("kuce:UpdateRentKucu", src, h2)
                            TriggerClientEvent('loaf_housing:reloadHouses', src)
                        end
                        break
                    end
                end
            end
        end
		cb(result[1].last_house, Config.Houses)
    end)
end)

ESX.RegisterServerCallback('esx_property:getPlayerDressing', function(source, cb)
	local xPlayer  = ESX.GetPlayerFromId(source)

    MySQL.Async.fetchAll("SELECT ID, ime, skin FROM kuce_outfit WHERE owner = @own", {['@own'] = xPlayer.getID()}, function(outfit)
        cb(outfit)
    end)
end)

ESX.RegisterServerCallback('kuce:DohvatiKuce', function(source, cb)
	cb(Config.Houses)
end)

RegisterNetEvent('kuce:SpawnVozilo')
AddEventHandler('kuce:SpawnVozilo', function(vehicle, co, he)
	local _source = source
	local veh = CreateVehicle(vehicle.model, co, he, true, false)
	while not DoesEntityExist(veh) do
		Wait(100)
	end
	local netid = NetworkGetNetworkIdFromEntity(veh)
	Wait(500)
	TriggerClientEvent("kuce:VratiVozilo", _source, netid, vehicle, co)
end)

ESX.RegisterServerCallback('esx_property:getPlayerOutfit', function(source, cb, num)
	local xPlayer  = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)
		local outfit = store.get('dressing', num)
		cb(outfit.skin)
	end)
end)

RegisterServerEvent('esx_property:removeOutfit')
AddEventHandler('esx_property:removeOutfit', function(id)
    MySQL.Async.execute("DELETE FROM kuce_outfit WHERE ID=@id", {['@id'] = id})
end)

RegisterServerEvent('loaf_housing:buy_furniture')
AddEventHandler('loaf_housing:buy_furniture', function(category, id)
    local xPlayer = ESX.GetPlayerFromId(source)
    local hadMoney = false
    if Config.Furniture[Config.Furniture['Categories'][category][1]][id] then
        if xPlayer.getAccount('bank').money >= Config.Furniture[Config.Furniture['Categories'][category][1]][id][3] then
            xPlayer.removeAccountMoney('bank', Config.Furniture[Config.Furniture['Categories'][category][1]][id][3])
            TriggerEvent("banka:Povijest", xPlayer.source, (-1*tonumber(Config.Furniture[Config.Furniture['Categories'][category][1]][id][3])), "Plaćanje namještaja za kuću")
            hadMoney = true
        else
            if xPlayer.getMoney() >= Config.Furniture[Config.Furniture['Categories'][category][1]][id][3] then
                xPlayer.removeMoney(Config.Furniture[Config.Furniture['Categories'][category][1]][id][3])
                hadMoney = true
            else
                TriggerClientEvent('esx:showNotification', xPlayer.source, Strings['no_money'])
            end
        end
    else
        TriggerClientEvent('esx:showNotification', xPlayer.source, 'There seems to be some kind of error in the script, could not buy furniture.')
    end

    if hadMoney then
        MySQL.Async.fetchScalar("SELECT bought_furniture FROM users WHERE ID = @id", {['@id'] = xPlayer.getID()}, function(result)
            local furniture = json.decode(result)
            if furniture[Config.Furniture[Config.Furniture['Categories'][category][1]][id][2]] then 
                furniture[Config.Furniture[Config.Furniture['Categories'][category][1]][id][2]]['amount'] = furniture[Config.Furniture[Config.Furniture['Categories'][category][1]][id][2]]['amount'] + 1
            else
                furniture[Config.Furniture[Config.Furniture['Categories'][category][1]][id][2]] = {['amount'] = 1, ['name'] = Config.Furniture[Config.Furniture['Categories'][category][1]][id][1]}
            end
            MySQL.Async.execute("UPDATE users SET bought_furniture=@bought_furniture WHERE ID=@id", {['@id'] = xPlayer.getID(), ['@bought_furniture'] = json.encode(furniture)}) 
            TriggerClientEvent('esx:showNotification', xPlayer.source, (Strings['Bought_Furniture']):format(Config.Furniture[Config.Furniture['Categories'][category][1]][id][1], Config.Furniture[Config.Furniture['Categories'][category][1]][id][3]))
        end)
    end
end)

RegisterServerEvent('loaf_housing:leaveHouse')
AddEventHandler('loaf_housing:leaveHouse', function(house)
    local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
    if instances[houses[house]]['players'][src] then
        local oldPlayers = instances[houses[house]]['players']
        local newPlayers = {}
        for k, v in pairs(oldPlayers) do
            if v ~= src then
                newPlayers[k] = v
            end
        end
        instances[houses[house]]['players'] = newPlayers
        SetPlayerRoutingBucket(src, 0)
		MySQL.Async.execute("UPDATE users SET last_house=@house WHERE ID=@identifier", {['@identifier'] = xPlayer.getID(), ['@house'] = 0})
    end
end)

RegisterServerEvent('loaf_housing:MakniSpremljenuKucu')
AddEventHandler('loaf_housing:MakniSpremljenuKucu', function()
    local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	MySQL.Async.execute("UPDATE users SET last_house=@house WHERE ID=@identifier", {['@identifier'] = xPlayer.getID(), ['@house'] = 0})
end)

RegisterServerEvent('loaf_housing:deleteInstance')
AddEventHandler('loaf_housing:deleteInstance', function()
    local src = source
    if instances[src] then
        Config.HouseSpawns[instances[src]['housespawn']]['taken'] = false
        for k, v in pairs(instances[src]['players']) do
            TriggerClientEvent('loaf_housing:leaveHouse', v, instances[src]['id'])
            SetPlayerRoutingBucket(v, 0)
			local xPlayer = ESX.GetPlayerFromId(v)
			MySQL.Async.execute("UPDATE users SET last_house=@house WHERE ID=@identifier", {['@identifier'] = xPlayer.getID(), ['@house'] = 0})
        end
        instances[src] = {}
    end
end)

RegisterServerEvent('loaf_housing:letIn')
AddEventHandler('loaf_housing:letIn', function(plr, storage)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(plr)
    if instances[src] then
        if not instances[src]['players'][plr] then 
            instances[src]['players'][plr] = plr
            SetPlayerRoutingBucket(plr, instances[src]['id'])
            local spawnpos = instances[src]['housecoords']
            local furniture = instances[src]['furniture']
            TriggerClientEvent('loaf_housing:knockAccept', plr, instances[src]['coords'], instances[src]['id'], storage, spawnpos, furniture, src)
			MySQL.Async.execute("UPDATE users SET last_house=@house WHERE ID=@identifier", {['@identifier'] = xPlayer.getID(), ['@house'] = instances[src]['id']})
        end
    end
end)

RegisterServerEvent('loaf_housing:unKnockDoor')
AddEventHandler('loaf_housing:unKnockDoor', function(id)
    local src = source
    if instances[houses[id]] then
        TriggerClientEvent('loaf_housing:removeDoorKnock', instances[houses[id]]['owner'], src)
    end
end)

RegisterServerEvent('loaf_housing:knockDoor')
AddEventHandler('loaf_housing:knockDoor', function(id)
    local src = source
    if instances[houses[id]] then
        local ime = GetPlayerName(src)
        TriggerClientEvent('loaf_housing:knockedDoor', instances[houses[id]]['owner'], src, ime)
    else
        TriggerClientEvent('esx:showNotification', src, Strings['Noone_Home'])
    end
end)

RegisterServerEvent('loaf_housing:setInstanceCoords')
AddEventHandler('loaf_housing:setInstanceCoords', function(coords, housecoords, prop, placedfurniture)
    local src = source
    if instances[src] then
        instances[src]['coords'] = coords
        instances[src]['housecoords'] = housecoords
        instances[src]['furniture'] = placedfurniture
    end
end)

RegisterServerEvent('loaf_housing:exitHouse')
AddEventHandler('loaf_housing:exitHouse', function(id)
    local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
    if instances[src] then
        for k, v in pairs(instances['players']) do
            SetPlayerRoutingBucket(v, 0)
            TriggerClientEvent('loaf_housing:exitHouse', v, id)
            table.remove(instances, src)
            table.remove(houses, id)
        end
    else
        for k, v in pairs(instances) do
            if v['players'][src] then
                table.remove(v['players'], src)
            end
        end
    end
	MySQL.Async.execute("UPDATE users SET last_house=@house WHERE ID=@identifier", {['@identifier'] = xPlayer.getID(), ['@house'] = 0})
end)

RegisterServerEvent('loaf_housing:buyHouse')
AddEventHandler('loaf_housing:buyHouse', function(id, ka)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    MySQL.Async.fetchScalar("SELECT house FROM users WHERE ID = @identifier", {['@identifier'] = xPlayer.getID()}, function(result)
        local house = json.decode(result)
        if house.houseId == 0 then
            MySQL.Async.fetchScalar("SELECT houseid FROM bought_houses WHERE houseid=@houseid", {['@houseid'] = id}, function(result)
                local newHouse = ('{"owns":false,"furniture":[],"houseId":%s}'):format(id)
                if not result then
                    if xPlayer.getAccount('bank').money >= Config.Houses[ka]['price'] then
                        xPlayer.removeAccountMoney('bank', Config.Houses[ka]['price'])
                        TriggerEvent("banka:Povijest", xPlayer.source, (-1*tonumber(Config.Houses[ka]['price'])), "Kupovina kuće")
                        MySQL.Async.execute("UPDATE users SET house=@house WHERE ID=@identifier", {['@identifier'] = xPlayer.getID(), ['@house'] = newHouse}) 
                        MySQL.Sync.execute("INSERT INTO bought_houses (houseid, vlasnik) VALUES (@houseid, @vlasnik)", {['houseid'] = id, ['vlasnik'] = xPlayer.getID()})
                        for i=1, #Config.Houses, 1 do
                            if Config.Houses[i].ID == id then
                                Config.Houses[i].vlasnik = xPlayer.getID()
                                break
                            end
                        end
                        TriggerClientEvent("loaf_housing:SaljiKucice", -1, Config.Houses)
                    else
                        if xPlayer.getMoney() >= Config.Houses[ka]['price'] then
                            xPlayer.removeMoney(Config.Houses[ka]['price'])
                            MySQL.Sync.execute("INSERT INTO bought_houses (houseid, vlasnik) VALUES (@houseid, @vlasnik)", {['houseid'] = id, ['vlasnik'] = xPlayer.getID()})
                            MySQL.Async.execute("UPDATE users SET house=@house WHERE ID=@identifier", {['@identifier'] = xPlayer.getID(), ['@house'] = newHouse}) 
                            for i=1, #Config.Houses, 1 do
                                if Config.Houses[i].ID == id then
                                    Config.Houses[i].vlasnik = xPlayer.getID()
                                    break
                                end
                            end
                            TriggerClientEvent("loaf_housing:SaljiKucice", -1, Config.Houses)
                        else
                            TriggerClientEvent('esx:showNotification', xPlayer.source, Strings['No_Money'])
                        end
                    end
                end
            end)
        end
    end)
end)

ESX.RegisterServerCallback('loaf_housing:ImalKucu', function(source, cb)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    MySQL.Async.fetchScalar("SELECT house FROM users WHERE ID = @identifier", {['@identifier'] = xPlayer.getID()}, function(result)
        local house = json.decode(result)
        if house.houseId == 0 then
			cb(false)
		else
			cb(true)
		end
	end)
end)

RegisterServerEvent('loaf_housing:sellHouse')
AddEventHandler('loaf_housing:sellHouse', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    MySQL.Async.fetchScalar("SELECT house FROM users WHERE ID = @identifier", {['@identifier'] = xPlayer.getID()}, function(result)
        local house = json.decode(result)
        for ka, v in pairs(Config.Houses) do
            local k = v['ID']
            if k == house.houseId then
                if v['price'] then
                    xPlayer.addMoney(v['price'] * (Config.SellPercentage/100))
                    TriggerClientEvent('esx:showNotification', xPlayer.source, (Strings['Sold_House']):format(math.floor(v['price'] * (Config.SellPercentage/100))))
                    MySQL.Async.execute("UPDATE users SET house=@house WHERE ID=@identifier", {['@identifier'] = xPlayer.getID(), ['@house'] = '{"owns":false,"furniture":[],"houseId":0}'}) 
                    MySQL.Async.execute("DELETE FROM bought_houses WHERE houseid=@houseid", {['@houseid'] = house.houseId})
                    v['vlasnik'] = nil
                    local por = "["..os.date("%X").."] ("..GetCurrentResourceName()..") Igrac "..GetPlayerName(src).."("..xPlayer.identifier..") je dobio $"..(v['price']*(Config.SellPercentage/100))
                    TriggerEvent("SpremiLog", por)
                end
                break
            end
        end
        TriggerClientEvent("loaf_housing:SaljiKucice", -1, Config.Houses)
    end)
end)

RegisterNetEvent('kuce:PonudiIgracu')
AddEventHandler('kuce:PonudiIgracu', function(igrID, cij)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    MySQL.Async.fetchScalar("SELECT house FROM users WHERE ID = @identifier", {['@identifier'] = xPlayer.getID()}, function(result)
        local house = json.decode(result)
        for ka, v in pairs(Config.Houses) do
            local k = v['ID']
            if k == house.houseId then
                xPlayer.showNotification("Poslali ste ponudu igracu.")
                TriggerClientEvent("upit:OtvoriPitanje", igrID, "loaf_housing2", "Kupovina kuce", "Zelite li kupiti kucu #"..k.." za $"..cij.." ?", {cijena = cij, id = k, orgIgr = src})
                break
            end
        end
    end)
end)

RegisterNetEvent('kuce:PrihvatiPonudu')
AddEventHandler('kuce:PrihvatiPonudu', function(orgIgr, id, cij)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local vlPlayer = ESX.GetPlayerFromId(orgIgr)
    if xPlayer.getMoney() >= cij then
        for i=1, #Config.Houses, 1 do
            local k = Config.Houses[i].ID
            if k == id then
                if Config.Houses[i].vlasnik == vlPlayer.getID() then
                    xPlayer.removeMoney(cij)
                    vlPlayer.addMoney(cij)
                    MySQL.Async.execute("UPDATE users SET house=@house WHERE ID=@identifier", {['@identifier'] = vlPlayer.getID(), ['@house'] = '{"owns":false,"furniture":[],"houseId":0}'}) 
                    local newHouse = ('{"owns":false,"furniture":[],"houseId":%s}'):format(id)
                    MySQL.Async.execute("UPDATE users SET house=@house WHERE ID=@identifier", {['@identifier'] = xPlayer.getID(), ['@house'] = newHouse})
                    MySQL.Async.execute("UPDATE bought_houses SET vlasnik=@vl WHERE houseid=@houseid", {['@vl'] = xPlayer.getID(), ['@houseid'] = id})
                    Config.Houses[i].vlasnik = xPlayer.getID()
                    TriggerClientEvent("loaf_housing:SaljiKucice", -1, Config.Houses)
                    xPlayer.showNotification("Kupili ste kucu #"..id.." za $"..cij)
                    vlPlayer.showNotification("Prodali ste kucu #"..id.." za $"..cij)
                else
                    xPlayer.showNotification("Igrac nije vlasnik kuce!")
                    vlPlayer.showNotification("Niste vlasnik kuce!")
                end
                break
            end
        end
    else
        xPlayer.showNotification("Nemate dovoljno novca kod sebe.")
        vlPlayer.showNotification("Igrac nema dovoljno novca.")
    end
end)

RegisterNetEvent('kuce:OdbijPonudu')
AddEventHandler('kuce:OdbijPonudu', function(orgIgr, vr)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local vlPlayer = ESX.GetPlayerFromId(orgIgr)
    if vr == 1 then
        xPlayer.showNotification("Odbili ste ponudu!")
        vlPlayer.showNotification("Igrac je odbio ponudu!")
    elseif vr == 2 then
        xPlayer.showNotification("Vec imate kucu!")
        vlPlayer.showNotification("Igrac vec ima kucu!")
    end
end)

RegisterServerEvent('loaf_housing:getOwned')
AddEventHandler('loaf_housing:getOwned', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    MySQL.Async.fetchAll("SELECT house, rentKuca FROM users WHERE ID = @id", {['@id'] = xPlayer.getID()}, function(result)
        local house = json.decode(result[1].house)
        local h2 = json.decode(result[1].house)
        if result[1].rentKuca ~= nil then
            MySQL.Async.fetchAll("SELECT vlasnik, users.house from bought_houses inner join users on users.ID = bought_houses.vlasnik where bought_houses.houseid = @house", {['@house'] = result[1].rentKuca}, function(result3)
                h2 = json.decode(result3[1].house)
                MySQL.Async.fetchAll("SELECT houseid FROM bought_houses", {}, function(result2)
                    TriggerClientEvent('loaf_housing:setHouse', xPlayer.source, house, result2, h2)
                end)
            end)
        else
            h2.houseId = 0
            MySQL.Async.fetchAll("SELECT houseid FROM bought_houses", {}, function(result2)
                TriggerClientEvent('loaf_housing:setHouse', xPlayer.source, house, result2, h2)
            end)
        end
    end)
end)

RegisterServerEvent('loaf_housing:furnish')
AddEventHandler('loaf_housing:furnish', function(house, furniture)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    MySQL.Async.execute("UPDATE users SET house=@house WHERE ID=@id", {['@id'] = xPlayer.getID(), ['@house'] = json.encode(house)}) 
    MySQL.Async.execute("UPDATE users SET bought_furniture=@bought_furniture WHERE ID=@id", {['@id'] = xPlayer.getID(), ['@bought_furniture'] = json.encode(furniture)}) 
end)

RegisterServerEvent('kuce:IzbaciStanara')
AddEventHandler('kuce:IzbaciStanara', function(id)
    local xPlayer = ESX.GetPlayerFromDbId(id)
	if xPlayer then
        xPlayer.showNotification("Izbaceni ste iz kuce.")
        local h2 = {owns = false, furniture = {}, houseId = 0}
        TriggerClientEvent("kuce:UpdateRentKucu", xPlayer.source, h2)
        TriggerClientEvent('loaf_housing:reloadHouses', xPlayer.source)
    end
    MySQL.Async.execute("UPDATE users SET rentKuca=null WHERE ID=@id", {['@id'] = id})
end)

RegisterServerEvent('kuce:UnrentKucu')
AddEventHandler('kuce:UnrentKucu', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
	if xPlayer then
        MySQL.Async.execute("UPDATE users SET rentKuca=null WHERE ID=@id", {['@id'] = xPlayer.getID()})
        local h2 = {owns = false, furniture = {}, houseId = 0}
        TriggerClientEvent("kuce:UpdateRentKucu", src, h2)
        TriggerClientEvent('loaf_housing:reloadHouses', src)
    end
end)

ESX.RegisterServerCallback('kuce:DajStanare', function(source, cb, id)
    MySQL.Async.fetchAll("SELECT ID, firstname, lastname FROM users WHERE rentKuca = @id", {['@id'] = id}, function(result)
        local elem = {}
        for i=1, #result, 1 do
            table.insert(elem, {label = result[i].firstname.." "..result[i].lastname, value = result[i].ID})
        end
        cb(elem)
    end)
end)

ESX.RegisterServerCallback('loaf_housing:hasGuests', function(source, cb)
    local hasGuest = false
    for k, v in pairs(instances[source]['players']) do
        local playerlist = GetPlayers()
        for id, src in pairs(playerlist) do
            if v ~= source and v == tonumber(src) then
                hasGuest = true
                break
            end
        end
    end
    cb(hasGuest)
end)

ESX.RegisterServerCallback('loaf_housing:hasGuests2', function(source, cb, kuca)
    local hasGuest = false
    for k, v in pairs(instances[source]['players']) do
        local playerlist = GetPlayers()
        for id, src in pairs(playerlist) do
            if v ~= source and v == tonumber(src) then
                SetPlayerRoutingBucket(v, 0)
                TriggerClientEvent("loaf_housing:leaveHouse", v, kuca)
            end
        end
    end
    cb(hasGuest)
end)

ESX.RegisterServerCallback('loaf_housing:hostOnline', function(source, cb, host)
    local online = false
    if instances[host] then
        local playerlist = GetPlayers()
        for id, src in pairs(playerlist) do
            if host == tonumber(src) then
                online = true
                break
            end
        end
        if not online then
			if instances[host]['housespawn'] ~= nil then
				Config.HouseSpawns[instances[host]['housespawn']]['taken'] = false
				instances[host] = {}
			end
        end
    end
    cb(online)
end)

ESX.RegisterServerCallback('loaf_housing:getInventory', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    cb({['items'] = xPlayer.inventory, ['weapons'] = xPlayer.getLoadout()})
end)

ESX.RegisterServerCallback('loaf_housing:getHouseInv', function(source, cb, owner)
	local xPlayer = ESX.GetPlayerFromId(source)
    if houses[owner] then
        if instances[houses[owner]] then
            MySQL.Async.fetchAll("SELECT kuce_stvari.ID, items.name, kolicina, owner, kuca, label FROM kuce_stvari inner join items on items.ID = kuce_stvari.item WHERE owner = @own and kuca = @ku", {['@own'] = xPlayer.getID(), ['@ku'] = owner}, function(items)
                MySQL.Async.fetchAll("SELECT kuce_oruzja.ID, ime, kolicina, owner, kuca FROM kuce_oruzja WHERE owner = @own and kuca = @ku", {['@own'] = xPlayer.getID(), ['@ku'] = owner}, function(weapons)
                    cb({['items'] = items, ['weapons'] = weapons})
                end)
            end)
        end
    end
end)

RegisterServerEvent('loaf_housing:withdrawItem')
AddEventHandler('loaf_housing:withdrawItem', function(type, item, amount, owner, torba, iime)
	local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    if houses[owner] then
        if instances[houses[owner]] then
            if type == 'item' then
                MySQL.Async.fetchAll("SELECT kolicina FROM kuce_stvari WHERE ID = @id", {['@id'] = item}, function(result)
                    if tonumber(result[1].kolicina) >= amount then
						local xItem = xPlayer.getInventoryItem(iime)
						if torba then
							if xItem.limit ~= -1 and (xItem.count + amount) > xItem.limit*2 then
								TriggerClientEvent('esx:showNotification', xPlayer.source, "Ne stane vam vise u inventory!")
							else
								xPlayer.showNotification("Uzeli ste "..amount.."x "..xItem.label)
								xPlayer.addInventoryItem(iime, amount)
                                TriggerEvent("DiscordBot:SefKuce", "Igrac "..GetPlayerName(src).." je uzeo "..amount.."x"..xItem.label.." iz sefa kuce!")
                                if tonumber(result[1].kolicina)-amount == 0 then
                                    MySQL.Async.execute("DELETE FROM kuce_stvari WHERE ID=@id", {['@id'] = item})
                                else
								    MySQL.Async.execute("UPDATE kuce_stvari SET kolicina=kolicina-@kol WHERE ID=@id", {['@id'] = item, ['@kol'] = amount})
                                end
							end
						else
							if xItem.limit ~= -1 and (xItem.count + amount) > xItem.limit then
								TriggerClientEvent('esx:showNotification', xPlayer.source, "Ne stane vam vise u inventory!")
							else
								xPlayer.showNotification("Uzeli ste "..amount.."x "..xItem.label)
								xPlayer.addInventoryItem(iime, amount)
                                TriggerEvent("DiscordBot:SefKuce", "Igrac "..GetPlayerName(src).." je uzeo "..amount.."x"..xItem.label.." iz sefa kuce!")
                                if tonumber(result[1].kolicina)-amount == 0 then
                                    MySQL.Async.execute("DELETE FROM kuce_stvari WHERE ID=@id", {['@id'] = item})
                                else
                                    MySQL.Async.execute("UPDATE kuce_stvari SET kolicina=kolicina-@kol WHERE ID=@id", {['@id'] = item, ['@kol'] = amount})
                                end
							end
						end
                    else
                        TriggerClientEvent('esx:showNotification', src, Strings['Not_Enough_House'])
                    end
                end)

            elseif type == 'weapon' then
                local loadout, hasweapon = xPlayer.getLoadout(), false
                for k, v in pairs(loadout) do
                    if v['name'] == iime then
                        hasweapon = true
                        break
                    end
                end

                if not hasweapon then
                    MySQL.Async.fetchAll("SELECT kolicina FROM kuce_oruzja WHERE ID = @id", {['@id'] = item}, function(result)
                        if #result > 0 then
                            MySQL.Async.execute("DELETE FROM kuce_oruzja WHERE ID=@id", {['@id'] = item})
                            xPlayer.addWeapon(iime, amount)
                            TriggerEvent("DiscordBot:SefKuce", "Igrac "..GetPlayerName(src).." je uzeo "..iime.." sa "..amount.." metaka iz sefa kuce!")
                        else
                            TriggerClientEvent('esx:showNotification', src, "Tog oruzja nema u sefu kuce!")
                        end
                    end)
                else
                    xPlayer.showNotification("Vec imate to oruzje!")
                end
            end
        end

    end
    
end)

RegisterServerEvent('loaf_housing:storeItem')
AddEventHandler('loaf_housing:storeItem', function(type, item, amount, kuca)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
    if houses[kuca] then
        if instances[houses[kuca]] then
            if type == 'item' then
                local xItem = xPlayer.getInventoryItem(item)
                if xItem.count >= amount then
                    MySQL.Async.fetchAll("SELECT ID FROM kuce_stvari WHERE item = @item and owner = @own and kuca = @ku", {['@item'] = xItem.ID, ['@own'] = xPlayer.getID(), ['@ku'] = kuca}, function(result)
                        if #result > 0 then
                            MySQL.Async.execute("UPDATE kuce_stvari SET kolicina=kolicina+@kol WHERE ID=@id", {['@id'] = result[1].ID, ['@kol'] = amount})
                        else
                            MySQL.Async.insert('insert into kuce_stvari(item, kolicina, owner, kuca) values(@it, @kol, @ow, @ku)', {
                                ['@it'] = xItem.ID,
                                ['@kol'] = amount,
                                ['@ow'] = xPlayer.getID(),
                                ['@ku'] = kuca
                            })
                        end
                    end)
                    xPlayer.removeInventoryItem(item, amount)
                    TriggerEvent("DiscordBot:SefKuce", "Igrac "..GetPlayerName(src).." je ostavio "..amount.."x"..xItem.label.." u sef kuce!")
                    xPlayer.showNotification("Uspjesno ste spremili stvar.")
                else
                    TriggerClientEvent('esx:showNotification', src, Strings['Not_Enough'])
                end

            elseif type == 'weapon' then

                local loadout, hasweapon = xPlayer.getLoadout(), false
                for k, v in pairs(loadout) do
                    if v['name'] == item then
                        hasweapon = true
                        break
                    end
                end

                if hasweapon then
                    MySQL.Async.insert('insert into kuce_oruzja(kolicina, owner, kuca, ime) values(@kol, @ow, @ku, @im)', {
                        ['@im'] = item,
                        ['@kol'] = amount,
                        ['@ow'] = xPlayer.getID(),
                        ['@ku'] = kuca
                    })
                    xPlayer.removeWeapon(item)
                    TriggerEvent("DiscordBot:SefKuce", "Igrac "..GetPlayerName(src).." je ostavio "..item.." sa "..amount.." metaka u sef kuce!")
                else
                    TriggerClientEvent('esx:showNotification', src, Strings['No_Weapon'])
                end
            end
        end

	end
end)
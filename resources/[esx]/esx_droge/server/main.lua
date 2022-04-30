ESX = nil
local Droge = {}
local Ucitao = false

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

MySQL.ready(function()
	UcitajDroge()
end)

function UcitajDroge()
	Droge = {}
	MySQL.Async.fetchAll(
      'SELECT * FROM droge',
      {},
      function(result)
        for i=1, #result, 1 do
			local data = json.decode(result[i].branje)
            local branje = vector3(data.x, data.y, data.z)
            local data2 = json.decode(result[i].prerada)
            local prerada = vector3(data2.x, data2.y, data2.z)
			table.insert(Droge, {ID = result[i].ID, vrsta = result[i].vrsta, branje = branje, prerada = prerada})
        end
        Ucitao = true
      end
    )
end

ESX.RegisterServerCallback('droge:DohvatiDroge', function(source, cb)
    while not Ucitao do
        Wait(100)
    end
	cb(Droge)
end)

RegisterServerEvent("droge:PostaviKoord")
AddEventHandler("droge:PostaviKoord", function(vrsta, br, koord)
    local _source = source	
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.getPerm() > 0 then
        local naso = false
        for i=1, #Droge, 1 do
            if Droge[i].vrsta == vrsta then
                naso = true
                if br == 1 then
                    Droge[i].branje = koord
                    MySQL.Async.execute('UPDATE droge SET branje = @kor WHERE ID = @id', {
                        ['@kor'] = json.encode(koord),
                        ['@id'] = Droge[i].ID
                    })
                else
                    Droge[i].prerada = koord
                    MySQL.Async.execute('UPDATE droge SET prerada = @kor WHERE ID = @id', {
                        ['@kor'] = json.encode(koord),
                        ['@id'] = Droge[i].ID
                    })
                end
                break
            end
        end
        if not naso then
            if br == 1 then
                MySQL.Async.insert('INSERT INTO droge (vrsta, branje) VALUES (@vr, @ko)',{
                    ['@vr'] = vrsta,
                    ['@ko'] = json.encode(koord)
                }, function(id)
                    table.insert(Droge, {ID = id, vrsta = vrsta, branje = koord, prerada = nil})
                    TriggerClientEvent("droge:VratiDroge", -1, Droge)
                end)
            else
                MySQL.Async.insert('INSERT INTO droge (vrsta, prerada) VALUES (@vr, @ko)',{
                    ['@vr'] = vrsta,
                    ['@ko'] = json.encode(koord)
                }, function(id)
                    table.insert(Droge, {ID = id, vrsta = vrsta, prerada = koord, branje = nil})
                    TriggerClientEvent("droge:VratiDroge", -1, Droge)
                end)
            end
        else
            TriggerClientEvent("droge:VratiDroge", -1, Droge)
        end
    end
end)

RegisterServerEvent("Heroin:get")
AddEventHandler("Heroin:get", function(torba)
    local _source = source	
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if torba then
		if xPlayer.getInventoryItem('gljive').count < 30*2 then
			local randa = math.random(1,3)
			if xPlayer.getInventoryItem('gljive').count+randa > 30*2 then
				xPlayer.addInventoryItem("gljive", 1)
			else
				xPlayer.addInventoryItem("gljive", randa)
			end
		else
			TriggerClientEvent('esx:showNotification', source, '~r~Ne mozete nositi vise gljiva')
		end
	else
		if xPlayer.getInventoryItem('gljive').count < 30 then
			local randa = math.random(1,3)
			if xPlayer.getInventoryItem('gljive').count+randa > 30 then
				xPlayer.addInventoryItem("gljive", 1)
			else
				xPlayer.addInventoryItem("gljive", randa)
			end
		else
			TriggerClientEvent('esx:showNotification', source, '~r~Ne mozete nositi vise gljiva')
		end
	end	
end)

ESX.RegisterUsableItem('heroin', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local quantity = xPlayer.getInventoryItem("heroin").count
	if quantity >= 1 then
		TriggerClientEvent('esx_koristiHeroin:useItem', source, 'heroin')
		Citizen.Wait(1000)
	end
end)

ESX.RegisterServerCallback('esx_koristiHeroin:getItemAmount', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local quantity = xPlayer.getInventoryItem(item).count

	cb(quantity)
end)

RegisterServerEvent('esx_koristiHeroin:removeItem')
AddEventHandler('esx_koristiHeroin:removeItem', function(item)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local quantity = xPlayer.getInventoryItem(item).count
	if quantity >= item then
		xPlayer.removeInventoryItem(item, 1)
	end
end)

function CancelProcessing(id)
	TriggerClientEvent('esx_koristiHeroin:removeEffect', id)
end

RegisterNetEvent('heroin:ProdajHeroin')
AddEventHandler('heroin:ProdajHeroin', function()
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	local naso = 0
	local tozu = xPlayer.getInventoryItem('heroin').count
	if tozu > 0 then
		local cijena = tozu * 400
		xPlayer.removeInventoryItem('heroin', tozu)
		xPlayer.addMoney(cijena)
		TriggerClientEvent('esx:showNotification', xPlayer.source, "Prodali ste "..tozu.."g heroina za $"..cijena..".")
		naso = 1
	end
	if naso == 0 then
		TriggerClientEvent('esx:showNotification', xPlayer.source, "Nemate heroina za prodati!")
	end
end)

ESX.RegisterServerCallback('Heroin:process', function (source, cb, torba)
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
			
	if xPlayer.getInventoryItem('gljive').count >= 3 then
		if torba == 40 or torba == 41 or torba == 44 or torba == 45 then
			if xPlayer.getInventoryItem('heroin').count < 10*2 then 
				xPlayer.removeInventoryItem('gljive', 3) 
				xPlayer.addInventoryItem('heroin', 1) 
				cb(true)
			else
				TriggerClientEvent('esx:showNotification', source, '~r~Nemate vise prostora')
				cb(false)
			end
		else
			if xPlayer.getInventoryItem('heroin').count < 10 then 
				xPlayer.removeInventoryItem('gljive', 3) 
				xPlayer.addInventoryItem('heroin', 1) 
				cb(true)
			else
				TriggerClientEvent('esx:showNotification', source, '~r~Nemate vise prrostora')
				cb(false)
			end
		end
	else
		TriggerClientEvent('esx:showNotification', source, '~r~Nemate dosta gljiva')
		cb(false)
	end
end)
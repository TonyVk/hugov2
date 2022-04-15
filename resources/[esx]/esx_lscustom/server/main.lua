ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local Vehicles = nil
local Zvukovi = {}

RegisterServerEvent('lscs:kupiPeraje')
AddEventHandler('lscs:kupiPeraje', function(model, price, veh)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	price = tonumber(price)

	if Config.IsMechanicJobOnly then

		--local societyAccount = nil
		--TriggerEvent('esx_addonaccount:getSharedAccount', 'society_mechanic', function(account)
			--societyAccount = account
		--end)
		--if price < societyAccount.money then
			TriggerClientEvent('esx_lscustom:installMod', _source)
			TriggerClientEvent('esx:showNotification', _source, _U('purchased'))
			--societyAccount.removeMoney(price)
			--price = 1.30*price
			TriggerClientEvent('esx_meha:PucajCijenu', _source, veh, price)
		--else
			--TriggerClientEvent('esx_lscustom:cancelInstallMod', _source)
			--TriggerClientEvent('esx:showNotification', _source, _U('not_enough_money'))
		--end

	else

		if price < xPlayer.getMoney() then
			TriggerClientEvent('esx_lscustom:installMod', _source)
			TriggerClientEvent('esx:showNotification', _source, _U('purchased'))
			xPlayer.removeMoney(price)
		else
			TriggerClientEvent('esx_lscustom:cancelInstallMod', _source)
			TriggerClientEvent('esx:showNotification', _source, _U('not_enough_money'))
		end

	end
end)

AddEventHandler("playerEnteredScope", function(data)
    local playerEntering, player = data["player"], data["for"]
	local veh = GetVehiclePedIsIn(GetPlayerPed(player))
	local net = NetworkGetNetworkIdFromEntity(veh)
	for i = 1, #Zvukovi do
		if Zvukovi[i].netid == net then
			TriggerClientEvent("vozila:NoviZvuk", playerEntering, tonumber(player), net, Zvukovi[i].zvuk)
			break
		end
	end
end)

RegisterNetEvent("vozila:PromjeniZvuk")
AddEventHandler('vozila:PromjeniZvuk', function(id, netid, zvuk)
	local naso = false
	for i = 1, #Zvukovi do
		if Zvukovi[i].netid == netid then
			Zvukovi[i].zvuk = zvuk
			naso = true
			break
		end
	end
	if not naso then
		table.insert(Zvukovi, {netid = netid, zvuk = zvuk})
	end
	TriggerClientEvent("vozila:NoviZvuk", -1, id, netid, zvuk)
end)

RegisterServerEvent('meh:PromjeniMjenjac')
AddEventHandler('meh:PromjeniMjenjac', function(br, plate)
	MySQL.Async.execute('UPDATE `owned_vehicles` SET `mjenjac` = @mj WHERE `plate` = @plate',
	{
		['@plate']   = plate,
		['@mj'] = br
	})
end)

RegisterServerEvent('meh:NaruciDijelove')
AddEventHandler('meh:NaruciDijelove', function(nar, id)
	local xPlayer = ESX.GetPlayerFromId(id)
	if xPlayer == nil then
		xPlayer = ESX.GetPlayerFromId(source)
	end
	MySQL.Async.execute('INSERT INTO meh_narudzbe(tablica, narudzba, vrijeme, broj) values (@tab, @nar, NOW(), @br)',
	{
		['@tab'] = nar[1].tablica,
		['@nar'] = json.encode(nar),
		['@br'] = xPlayer.getNumber()
	})
end)

RegisterServerEvent('motor:PromjeniMotor')
AddEventHandler('motor:PromjeniMotor', function(br, plate)
	MySQL.Async.execute('UPDATE `owned_vehicles` SET `motor` = @st WHERE `plate` = @plate',
	{
		['@plate'] = plate,
		['@st'] = br
	})
end)

RegisterServerEvent('stage:PromjeniStage')
AddEventHandler('stage:PromjeniStage', function(br, plate)
	MySQL.Async.execute('UPDATE `owned_vehicles` SET `stage` = @st WHERE `plate` = @plate',
	{
		['@plate']   = plate,
		['@st'] = br
	})
end)

RegisterServerEvent('ovjes:PromjeniOvjes')
AddEventHandler('ovjes:PromjeniOvjes', function(br, plate)
	MySQL.Async.execute('UPDATE `owned_vehicles` SET `zracni` = @st WHERE `plate` = @plate',
	{
		['@plate'] = plate,
		['@st'] = br
	})
end)

RegisterServerEvent('narudzbe:MakniDio')
AddEventHandler('narudzbe:MakniDio', function(nar, dio)
	local dijelovi = json.decode(nar.narudzba)
	for i=1, #dijelovi, 1 do
		if dijelovi[i].modType == dio then
			table.remove(dijelovi, i)
			break
		end
	end
	if #dijelovi == 0 then
		MySQL.Async.execute('DELETE FROM meh_narudzbe WHERE `ID` = @id',
		{
			['@id'] = nar.ID
		})
	else
		MySQL.Async.execute('UPDATE `meh_narudzbe` SET `narudzba` = @nar WHERE `ID` = @id',
		{
			['@id'] = nar.ID,
			['@nar'] = json.encode(dijelovi)
		})
	end
end)

ESX.RegisterServerCallback('meh:DohvatiNarudzbu', function(source, cb, tablica)
    MySQL.Async.fetchAll(
	'select ID, TIMESTAMPDIFF(MINUTE, vrijeme,NOW()) as min, tablica, narudzba from meh_narudzbe where tablica = @tab order by vrijeme limit 1',
	{
		['@tab'] = tablica
	},
	function(result)
		if #result ~= 0 then
			cb(result[1])
		else
			cb(0)
		end
    end)
end)

ESX.RegisterServerCallback('meh:DohvatiNarudzbe', function(source, cb)
    MySQL.Async.fetchAll(
	'select ID, TIMESTAMPDIFF(MINUTE, vrijeme,NOW()) as min, tablica, narudzba, broj from meh_narudzbe',{},
	function(result)
		if #result ~= 0 then
			cb(result)
		else
			cb(0)
		end
    end)
end)

ESX.RegisterServerCallback('stage:ProvjeriVozilo', function(source, cb, vehicleplate)
    MySQL.Async.fetchAll(
        'SELECT stage, motor, zracni, servis, kvar FROM owned_vehicles WHERE plate = @pl',
        {
            ['@pl'] = vehicleplate
        },
        function(result)
            if #result ~= 0 then
                cb(result[1])
			else
				cb(0)
            end
    end)
end)

RegisterServerEvent('esx_lscustom:refreshOwnedVehicle')
AddEventHandler('esx_lscustom:refreshOwnedVehicle', function(vehicleProps)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	MySQL.Async.fetchAll('SELECT vehicle FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = vehicleProps.plate
	}, function(result)
		if result[1] then
			local vehicle = json.decode(result[1].vehicle)

			if vehicleProps.model == vehicle.model then
				MySQL.Async.execute('UPDATE owned_vehicles SET vehicle = @vehicle WHERE plate = @plate', {
					['@plate'] = vehicleProps.plate,
					['@vehicle'] = json.encode(vehicleProps)
				})
			else
				TriggerEvent("DiscordBot:Anticheat", GetPlayerName(_source).."(".._source..") je pokusao zamjeniti model vozila!")
			end
		end
	end)
end)

ESX.RegisterServerCallback('esx_lscustom:getVehiclesPrices', function(source, cb)
	if Vehicles == nil then
		MySQL.Async.fetchAll('SELECT model, price FROM vehicles', {}, function(result)
			local vehicles = {}

			for i=1, #result, 1 do
				table.insert(vehicles, {
					model = result[i].model,
					price = result[i].price
				})
			end

			Vehicles = vehicles
			cb(Vehicles)
		end)
	else
		cb(Vehicles)
	end
end)
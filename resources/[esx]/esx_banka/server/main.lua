ESX = nil
local Bankomati = {}
local Ucitao = false

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('atm:DohvatiBankomate', function(source, cb)
    while not Ucitao do
        Wait(100)
    end
	cb(Bankomati)
end)

ESX.RegisterServerCallback('banka::server:GetPlayerName', function(source, cb)
	local _char = ESX.GetPlayerFromId(source)
	local _charname = _char.getRPName()
	MySQL.Async.fetchAll('SELECT ID, Tekst, Iznos from banka_transakcije WHERE Vlasnik = @vl ORDER BY ID desc limit 14', {['@vl'] = _char.getID()}, function(result)
		cb(_charname, result)
	end)
end)

MySQL.ready(function()
	UcitajBankomate()
end)

function UcitajBankomate()
	Bankomati = {}
	MySQL.Async.fetchAll(
      'SELECT ID, Koord, bKoord, Iznos FROM atm order by ID',
      {},
      function(result)
        for i=1, #result, 1 do
			local kord = nil
			if result[i].Koord then
				local ete = json.decode(result[i].Koord)
				kord = vector3(ete.x, ete.y, ete.z)
			end
			local kord2 = nil
			if result[i].bKoord then
				local ete2 = json.decode(result[i].bKoord)
            	kord2 = vector3(ete2.x, ete2.y, ete2.z)
			end
			table.insert(Bankomati, {ID = tonumber(result[i].ID), Koord = kord, bKoord = kord2, Iznos = tonumber(result[i].Iznos)})
        end
		Ucitao = true
		TriggerClientEvent("atm:VratiBankomate", -1, Bankomati)
      end
    )
end

RegisterNetEvent('atm:DodajBankomat')
AddEventHandler('atm:DodajBankomat', function(coord)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getPerm() >= 1 then
		MySQL.Async.insert('INSERT INTO atm (Koord) VALUES (@ko)',{
			['@ko'] = json.encode(coord)
		}, function(id)
			table.insert(Bankomati, {ID = id, Koord = vector3(coord.x, coord.y, coord.z), bKoord = nil, Iznos = 50000})
        	TriggerClientEvent("atm:VratiBankomate", -1, Bankomati)
		end)
    end
end)

RegisterNetEvent('atm:UrediIznos')
AddEventHandler('atm:UrediIznos', function(id, iznos)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getPerm() >= 1 then
        for i=1, #Bankomati, 1 do
            if Bankomati[i].ID == id then
                Bankomati[i].Iznos = iznos
                break
            end
        end
        MySQL.Async.execute('UPDATE atm SET `Iznos` = @iz WHERE ID = @id',{
            ['@iz'] = iznos,
            ['@id'] = id
        })
        TriggerClientEvent("atm:VratiBankomate", -1, Bankomati)
    end
end)

RegisterNetEvent('atm:SpremiKoord')
AddEventHandler('atm:SpremiKoord', function(id, koord)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getPerm() >= 1 then
        for i=1, #Bankomati, 1 do
            if Bankomati[i].ID == id then
                Bankomati[i].Koord = vector3(koord.x, koord.y, koord.z)
                break
            end
        end
        MySQL.Async.execute('UPDATE atm SET `Koord` = @ko WHERE ID = @id',{
            ['@ko'] = json.encode(koord),
            ['@id'] = id
        })
        TriggerClientEvent("atm:VratiBankomate", -1, Bankomati)
    end
end)

RegisterNetEvent('atm:ObrisiBankomat')
AddEventHandler('atm:ObrisiBankomat', function(id)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getPerm() >= 1 then
        for i=1, #Bankomati, 1 do
            if Bankomati[i].ID == id then
                table.remove(Bankomati, i)
                break
            end
        end
        MySQL.Async.execute('DELETE FROM atm WHERE ID = @id',{
            ['@id'] = id
        })
        TriggerClientEvent("atm:VratiBankomate", -1, Bankomati)
    end
end)

RegisterServerEvent('banka:VratiKredit')
AddEventHandler('banka:VratiKredit', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	local base = xPlayer.getAccount('bank').money
	MySQL.Async.fetchAll('SELECT kredit FROM users WHERE ID = @ident', {
		['@ident'] = xPlayer.getID()
	}, function(result)
		if result[1].kredit <= base then
			xPlayer.removeAccountMoney('bank', tonumber(result[1].kredit))
			TriggerEvent("banka:Povijest", xPlayer.source, (-1*tonumber(result[1].kredit)), "Vraćanje kredita")
			MySQL.Async.execute("UPDATE users SET kredit=0, rata=0 WHERE ID=@identifier", {['@identifier'] = xPlayer.getID()})
			TriggerClientEvent('esx:showAdvancedNotification', _source, 'Banka',
                               'Zatvaranje kredita',
                               'Kredit uspjesno zatvoren!',
                               'CHAR_BANK_MAZE', 9)
		else
			TriggerClientEvent('esx:showAdvancedNotification', _source, 'Banka',
                               'Zatvaranje kredita',
                               'Nemate dovoljno novca na racunu za zatvaranje kredita!',
                               'CHAR_BANK_MAZE', 9)
		end
	end)
end)

ESX.RegisterServerCallback('banka:DohvatiKredit', function(source, cb)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	MySQL.Async.fetchAll('SELECT kredit, rata, brplaca FROM users WHERE ID = @ident', {
		['@ident'] = xPlayer.getID()
	}, function(result)
		cb(result[1])
	end)
end)

RegisterServerEvent('banka:podignikredit')
AddEventHandler('banka:podignikredit', function(amount)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    amount = tonumber(amount)
    if amount == nil or (amount ~= 25000 and amount ~= 50000 and amount ~= 75000 and amount ~= 100000) then
        TriggerClientEvent('chatMessage', _source, "Krivi iznos kredita!")
    else
        xPlayer.addAccountMoney('bank', amount)
		TriggerEvent("banka:Povijest", xPlayer.source, tonumber(amount), "Isplata kredita")
		local amounte = 0
		local rata = 0
		if amount == 25000 then
			amounte = amount*1.10
			rata = 25000/100
		elseif amount == 50000 then
			amounte = amount*1.15
			rata = 50000/100
		elseif amount == 75000 then
			amounte = amount*1.20
			rata = 75000/100
		elseif amount == 100000 then
			amounte = amount*1.25
			rata = 100000/100
		end
		MySQL.Async.execute("UPDATE users SET kredit=@kr, rata=@rat WHERE ID=@identifier", {['@identifier'] = xPlayer.getID(), ['@kr'] = amounte, ['@rat'] = rata})
		ESX.SavePlayer(xPlayer, function() 
		end)
		local tekse = "Kredit od $"..amount.." uspjesno podignut!"
		TriggerClientEvent('esx:showAdvancedNotification', _source, 'Banka',
		'Podizanje kredita',
		tekse,
		'CHAR_BANK_MAZE', 9)
    end
end)

RegisterServerEvent('banka::server:depositvb')
AddEventHandler('banka::server:depositvb', function(amount, inMenu)
	local _src = source
	local _char = ESX.GetPlayerFromId(_src)
	amount = tonumber(amount)
	Citizen.Wait(50)
	if amount == nil or amount <= 0 or amount > _char.getMoney() then
		_char.showNotification("Netočan iznos!")
	else
		_char.removeMoney(amount)
		_char.addAccountMoney('bank', tonumber(amount))
		TriggerEvent("banka:Povijest", _char.source, tonumber(amount), "Spremanje novca na račun")
		_char.showNotification("Ostavio si $"..amount)
	end
end)

RegisterServerEvent('banka::server:withdrawvb')
AddEventHandler('banka::server:withdrawvb', function(amount, inMenu)
	local _src = source
	local _char = ESX.GetPlayerFromId(_src)
	local _base = 0
	amount = tonumber(amount)
	_base = _char.getAccount('bank').money
	Citizen.Wait(100)
	if amount == nil or amount <= 0 or amount > _base then
		_char.showNotification("Netočan iznos!")
	else
		_char.removeAccountMoney('bank', amount)
		TriggerEvent("banka:Povijest", _char.source, (-1*tonumber(amount)), "Podizanje novca s računa")
		_char.addMoney(amount)
		_char.showNotification("Podigao si sa racuna $"..amount)
	end
end)

RegisterServerEvent('banka::server:balance')
AddEventHandler('banka::server:balance', function(inMenu)
	local _src = source
	local _char = ESX.GetPlayerFromId(_src)
	local balance = _char.getAccount('bank').money
	TriggerClientEvent('banka::client:refreshbalance', _src, balance)
end)

RegisterServerEvent('banka::server:transfervb')
AddEventHandler('banka::server:transfervb', function(to, amountt, inMenu)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local zPlayer = ESX.GetPlayerFromId(tonumber(to))
	local balance = 0
	if zPlayer ~= nil then
		balance = xPlayer.getAccount('bank').money
		if tonumber(_source) == tonumber(to) then
			xPlayer.showNotification("Ne možeš slati sebi novac!")
		else
			if balance <= 0 or balance < tonumber(amountt) or tonumber(amountt) <= 0 then
				xPlayer.showNotification("Nemaš dovoljno novca na računu!")

			else
				xPlayer.removeAccountMoney('bank', tonumber(amountt))
				zPlayer.addAccountMoney('bank', tonumber(amountt))

				TriggerEvent("banka:Povijest", xPlayer.source, (-1*tonumber(amountt)), "Slanje novca igraču "..zPlayer.getRPName())
				TriggerEvent("banka:Povijest", zPlayer.source, tonumber(amountt), "Zaprimanje novca od igrača "..xPlayer.getRPName())
				
				zPlayer.showNotification("Primili ste novac "..amountt.."$ sa racuna: ".._source)
				xPlayer.showNotification("Poslali ste novac "..amountt.."$ na račun ID: "..to)
			end
		end
	else
		TriggerClientEvent('chatMessage', _source, "Neispravan broj racuna")
	end
end)

RegisterNetEvent('banka:Povijest')
AddEventHandler('banka:Povijest', function(id, br, tekst)
	local xPlayer = ESX.GetPlayerFromId(id)
	MySQL.Async.insert('INSERT INTO banka_transakcije (Vlasnik, Tekst, Iznos) VALUES (@vl, @te, @izn)',{
		['@vl'] = xPlayer.getID(),
		['@te'] = tekst,
		['@izn'] = br
	}, function(insertId)
		
	end)
end)
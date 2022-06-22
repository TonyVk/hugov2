ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('banka::server:GetPlayerName', function(source, cb)
	local _char = ESX.GetPlayerFromId(source)
	local _charname = _char.getRPName()
	MySQL.Async.fetchAll('SELECT ID, Tekst, Iznos from banka_transakcije WHERE Vlasnik = @vl ORDER BY ID desc limit 14', {['@vl'] = _char.getID()}, function(result)
		cb(_charname, result)
	end)
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
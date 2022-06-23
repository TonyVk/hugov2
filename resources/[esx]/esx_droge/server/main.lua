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
			local branje = nil
			if data ~= nil then
            	branje = vector3(data.x, data.y, data.z)
			end
			local heading = tonumber(result[i].heading)
			table.insert(Droge, {ID = result[i].ID, vrsta = result[i].vrsta, branje = branje, heading = heading, Ped = nil})
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
AddEventHandler("droge:PostaviKoord", function(vrsta, br, koord, head)
    local _source = source	
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.getPerm() > 0 then
        local naso = false
        for i=1, #Droge, 1 do
            if Droge[i].vrsta == vrsta then
                naso = true
                if br == 1 then
					Droge[i].heading = head
                    Droge[i].branje = koord
                    MySQL.Async.execute('UPDATE droge SET branje = @kor, heading = @head WHERE ID = @id', {
                        ['@kor'] = json.encode(koord),
						['@head'] = head,
                        ['@id'] = Droge[i].ID
                    })
                end
                break
            end
        end
        if not naso then
            if br == 1 then
                MySQL.Async.insert('INSERT INTO droge (vrsta, branje, heading) VALUES (@vr, @ko, @head)',{
                    ['@vr'] = vrsta,
					['@head'] = head,
                    ['@ko'] = json.encode(koord)
                }, function(id)
                    table.insert(Droge, {ID = id, vrsta = vrsta, branje = koord, heading = head, Ped = nil})
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
	for i=1, #Droge, 1 do
		if Droge[i].vrsta == 1 and Droge[i].branje ~= nil then
			if #(GetEntityCoords(GetPlayerPed(_source))-Droge[i].branje) <= 200 then
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
			else
				TriggerEvent("DiscordBot:Anticheat", GetPlayerName(_source).."[".._source.."] je pokusao pozvati event za dobijanje listova kokaina, a nije blizu lokacije!")
				TriggerEvent("AntiCheat:Citer", _source)
			end
			break
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

RegisterServerEvent("esx_drogica:get")
AddEventHandler("esx_drogica:get", function(torba)
    local _source = source
	for i=1, #Droge, 1 do
		if Droge[i].vrsta == 2 and Droge[i].branje ~= nil then
			if #(GetEntityCoords(GetPlayerPed(_source))-Droge[i].branje) <= 200 then
				local xPlayer = ESX.GetPlayerFromId(_source)
				local list = xPlayer.getInventoryItem('coke')
				if torba then
					if list.count < list.limit*2 then
						local randa = math.random(1,2)
						if list.count+randa > list.limit*2 then
							xPlayer.addInventoryItem("coke", 1)
							local por = "["..os.date("%X").."] ("..GetCurrentResourceName()..") Igrac "..GetPlayerName(_source).."("..xPlayer.identifier..") je dobio item coke x 1"
							TriggerEvent("SpremiLog", por)
						else
							xPlayer.addInventoryItem("coke", randa)
							local por = "["..os.date("%X").."] ("..GetCurrentResourceName()..") Igrac "..GetPlayerName(_source).."("..xPlayer.identifier..") je dobio item coke x "..randa
							TriggerEvent("SpremiLog", por)
						end
					else
						TriggerClientEvent('esx:showNotification', source, '~r~Ne mozete imati vise listova koke')
					end
				else
					if list.count < list.limit then
						local randa = math.random(1,2)
						if list.count+randa > list.limit then
							xPlayer.addInventoryItem("coke", 1)
							local por = "["..os.date("%X").."] ("..GetCurrentResourceName()..") Igrac "..GetPlayerName(_source).."("..xPlayer.identifier..") je dobio item coke x 1"
							TriggerEvent("SpremiLog", por)
						else
							xPlayer.addInventoryItem("coke", randa)
							local por = "["..os.date("%X").."] ("..GetCurrentResourceName()..") Igrac "..GetPlayerName(_source).."("..xPlayer.identifier..") je dobio item coke x "..randa
							TriggerEvent("SpremiLog", por)
						end
					else
						TriggerClientEvent('esx:showNotification', source, '~r~Ne mozete imati vise listova koke')
					end
				end	
			else
				TriggerEvent("DiscordBot:Anticheat", GetPlayerName(_source).."[".._source.."] je pokusao pozvati event za dobijanje listova kokaina, a nije blizu lokacije!")
				TriggerEvent("AntiCheat:Citer", _source)
			end
			break
		end
	end
end)

ESX.RegisterUsableItem('cocaine', function(source)
	--local xPlayer = ESX.GetPlayerFromId(source)
	--xPlayer.removeInventoryItem('cocaine', 1)
	
	TriggerClientEvent('esx_drogica:useItem', source, 'cocaine')

	Citizen.Wait(1000)
end)

ESX.RegisterServerCallback('esx_drogica:getItemAmount', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local quantity = xPlayer.getInventoryItem(item).count

	cb(quantity)
end)

RegisterServerEvent('esx_drogica:removeItem')
AddEventHandler('esx_drogica:removeItem', function(item)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem(item, 1)
end)
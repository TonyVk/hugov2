ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local Objekti = {}
local Radnici = {}

RegisterServerEvent('kamiooon:platituljanu')
AddEventHandler('kamiooon:platituljanu', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.posao.name == "kamion" then
		if Radnici[tostring(_source)] then
			xPlayer.addMoney(230)
			local por = "["..os.date("%X").."] ("..GetCurrentResourceName()..") Igrac "..GetPlayerName(_source).."("..xPlayer.identifier..") je dobio $230"
			TriggerEvent("SpremiLog", por)
			TriggerEvent("biznis:StaviUSef", "kamion", math.ceil(230*0.30))
		else
			TriggerEvent("DiscordBot:Anticheat", GetPlayerName(_source).."[".._source.."] je pokusao pozvati event za novac kamiondzije, a nije zapoceo posao")
			TriggerEvent("AntiCheat:Citer", _source)
		end
	else
        TriggerEvent("DiscordBot:Anticheat", GetPlayerName(_source).."[".._source.."] je pokusao pozvati event za novac kamiondzije, a nije zaposlen kao kamiondzija! ("..xPlayer.posao.name..")")
	    TriggerEvent("AntiCheat:Citer", _source)
	end
end)

RegisterServerEvent('kamiooon:platituljanu2')
AddEventHandler('kamiooon:platituljanu2', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.posao.name == "kamion" then
		if Radnici[tostring(_source)] then
			xPlayer.addMoney(250)
			local por = "["..os.date("%X").."] ("..GetCurrentResourceName()..") Igrac "..GetPlayerName(_source).."("..xPlayer.identifier..") je dobio $250"
			TriggerEvent("SpremiLog", por)
			TriggerEvent("biznis:StaviUSef", "kamion", math.ceil(250*0.30))
		else
			TriggerEvent("DiscordBot:Anticheat", GetPlayerName(_source).."[".._source.."] je pokusao pozvati event za novac kamiondzije, a nije zapoceo posao")
			TriggerEvent("AntiCheat:Citer", _source)
		end
	else
        TriggerEvent("DiscordBot:Anticheat", GetPlayerName(_source).."[".._source.."] je pokusao pozvati event za novac kamiondzije, a nije zaposlen kao kamiondzija! ("..xPlayer.posao.name..")")
	    TriggerEvent("AntiCheat:Citer", _source)
	end
end)

RegisterServerEvent('kamion:ZapoceoPosao')
AddEventHandler('kamion:ZapoceoPosao', function(br)
	local _source = source
	if br then
		Radnici[tostring(_source)] = true
	else
		Radnici[tostring(_source)] = nil
	end
end)

RegisterServerEvent('kamion:PosaljiObjekte')
AddEventHandler('kamion:PosaljiObjekte', function(obj)
	for i=1, #obj, 1 do
		if obj[i] ~= nil then
			table.insert(Objekti, {ID = obj[i].ID, Obj1 = obj[i].Obj1})
		end
	end
end)

RegisterServerEvent('kamion:MaknutObjekt')
AddEventHandler('kamion:MaknutObjekt', function(id)
	for i=1, #Objekti, 1 do
		if Objekti[i] ~= nil and Objekti[i].ID == id then
			Objekti[i].ID = nil
			Objekti[i].Obj1 = nil
			Objekti[i] = nil
			break
		end
	end
end)

AddEventHandler('playerDropped', function()
	for i=1, #Objekti, 1 do
		if Objekti[i] ~= nil and Objekti[i].ID == source then
			TriggerClientEvent("kamion:ObrisiObjekte", -1, Objekti[i].Obj1)
			Objekti[i].ID = nil
			Objekti[i].Obj1 = nil
			Objekti[i] = nil
			break
		end
	end
end)

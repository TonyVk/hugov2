ESX = nil

local Mafije = {}
local Rankovi = {}
local Koord = {}
local Vozila = {}
local Oruzja = {}
local Boje = {}
local EnableESXIdentity = true
local EnableLicenses = true
local Kutije = {}
local Skladiste = {}
local Kamioni = {}
local Guardiani = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

if Config.MaxInService ~= -1 then
  TriggerEvent('esx_service:activateService', 'britvasi', Config.MaxInService)
end

MySQL.ready(function()
	UcitajMafije()
end)

-- TriggerEvent('esx_phone:registerNumber', 'britvasi', _U('alert_britvasi'), true, true)
--TriggerEvent('esx_society:registerSociety', 'britvasi', 'Britvasi', 'society_britvasi', 'society_britvasi', 'society_britvasi', {type = 'public'})

RegisterServerEvent('mafije:giveWeapon')
AddEventHandler('mafije:giveWeapon', function(weapon, ammo)
  local xPlayer = ESX.GetPlayerFromId(source)
  xPlayer.addWeapon(weapon, ammo)
end)

RegisterServerEvent('mafija:Zaposli')
AddEventHandler('mafija:Zaposli', function(posao, id)
	local xPlayer = ESX.GetPlayerFromId(id)
	if xPlayer ~= nil then
		TriggerClientEvent("upit:OtvoriPitanje", id, "esx_mafije", "Upit za posao", "Pozvani ste da se zaposlite u mafiju "..posao.label..". Prihvacate?", {posao = posao, id = id})
	end
end)

RegisterServerEvent('mafija:Zaposli2')
AddEventHandler('mafija:Zaposli2', function(posao, id)
	local xPlayer = ESX.GetPlayerFromId(id)
	if xPlayer ~= nil then
		xPlayer.setJob(posao.id, 0)
		xPlayer.showNotification("Zaposleni ste u "..posao.label.."!")
		MySQL.Async.execute('UPDATE users SET `job` = @job, `job_grade` = 0 WHERE ID = @id', {
			['@id'] = xPlayer.getID(),
			['@job'] = tonumber(posao.id)
		})
	end
end)

function UcitajMafije()
	Mafije = {}
	Rankovi = {}
	Koord = {}
	Vozila = {}
	Oruzja = {}
	Boje = {}
	MySQL.Async.fetchAll(
      'SELECT * FROM mafije',
      {},
      function(result)
        for i=1, #result, 1 do
			local soc = "society_"..result[i].Ime
			TriggerEvent("RefreshAddone")
			TriggerEvent("RefreshSociety")
			TriggerEvent('esx_society:registerSociety', result[i].Ime, result[i].Label, soc, soc, soc, {type = 'public'})
			table.insert(Mafije, {Ime = result[i].Ime, Label = result[i].Label, Gradonacelnik = result[i].Gradonacelnik, Skladiste2 = result[i].Skladiste2, Skladiste = result[i].Skladiste, Posao = result[i].Posao, Avion = result[i].Avion})
			local data = json.decode(result[i].Rankovi)
			if data ~= nil then
				for a=1, #data do
					table.insert(Rankovi, {ID = data[a].ID, Mafija = result[i].Ime, Ime = data[a].Ime})
				end
			end
			local data2 = json.decode(result[i].Oruzarnica)
			table.insert(Koord, {Mafija = result[i].Ime, Ime = "Oruzarnica", Coord = data2})
			data2 = json.decode(result[i].Lider)
			table.insert(Koord, {Mafija = result[i].Ime, Ime = "Lider", Coord = data2})
			data2 = json.decode(result[i].SpawnV)
			table.insert(Koord, {Mafija = result[i].Ime, Ime = "SpawnV", Coord = data2})
			data2 = json.decode(result[i].DeleteV)
			table.insert(Koord, {Mafija = result[i].Ime, Ime = "DeleteV", Coord = data2})
			data2 = json.decode(result[i].DeleteV2)
			table.insert(Koord, {Mafija = result[i].Ime, Ime = "DeleteV2", Coord = data2})
			data2 = json.decode(result[i].Kokain)
			table.insert(Koord, {Mafija = result[i].Ime, Ime = "Kokain", Coord = data2})
			data2 = json.decode(result[i].KamionK)
			table.insert(Koord, {Mafija = result[i].Ime, Ime = "KamionK", Coord = data2})
			data2 = json.decode(result[i].Heroin)
			table.insert(Koord, {Mafija = result[i].Ime, Ime = "Heroin", Coord = data2})
			data2 = json.decode(result[i].KamionH)
			table.insert(Koord, {Mafija = result[i].Ime, Ime = "KamionH", Coord = data2})
			data2 = json.decode(result[i].LokVozila)
			table.insert(Koord, {Mafija = result[i].Ime, Ime = "LokVozila", Coord = data2})
			data2 = json.decode(result[i].CrateDrop)
			table.insert(Koord, {Mafija = result[i].Ime, Ime = "CrateDrop", Coord = data2})
			data2 = json.decode(result[i].Ulaz)
			table.insert(Koord, {Mafija = result[i].Ime, Ime = "Ulaz", Coord = data2})
			data2 = json.decode(result[i].Izlaz)
			table.insert(Koord, {Mafija = result[i].Ime, Ime = "Izlaz", Coord = data2})
			data2 = json.decode(result[i].LokVozila2)
			table.insert(Koord, {Mafija = result[i].Ime, Ime = "LokVozila2", Coord = data2})
			data2 = json.decode(result[i].KPosao)
			table.insert(Koord, {Mafija = result[i].Ime, Ime = "Posao", Coord = data2})
			data2 = json.decode(result[i].PosaoSpawn)
			table.insert(Koord, {Mafija = result[i].Ime, Ime = "PosaoSpawn", Coord = data2})
			local data3 = json.decode(result[i].Vozila)
			if data3 ~= nil then
				for b=1, #data3 do
					table.insert(Vozila, {Mafija = result[i].Ime, Ime = data3[b].Ime, Label = data3[b].Label})
				end
			end
			local data4 = json.decode(result[i].Oruzja)
			if data4 ~= nil then
				for c=1, #data4 do
					table.insert(Oruzja, {Mafija = result[i].Ime, Ime = data4[c].Ime, Cijena = data4[c].Cijena})
				end
			end
			local data5 = json.decode(result[i].Boje)
			if data5 ~= nil then
				for d=1, #data5 do
					if data5[d].Ime == "Vozilo" then
						table.insert(Boje, {Mafija = result[i].Ime, Ime = "Vozilo", R = data5[d].R, G = data5[d].G, B = data5[d].B})
					else
						table.insert(Boje, {Mafija = result[i].Ime, Ime = "Blip", Boja = data5[d].Boja})
					end
				end
			end
        end
      end
    )
	MySQL.Async.fetchAll(
      'SELECT * FROM mskladiste',
      {},
      function(result)
		for i=1, #result, 1 do
			table.insert(Skladiste, {Mafija = result[i].ime, Listovi = result[i].listovi, Kokain = result[i].kokain, Gljive = result[i].gljive, Heroin = result[i].heroin})
        end
      end
    )
end

RegisterNetEvent('mafije:ImalKoga')
AddEventHandler('mafije:ImalKoga', function(id, id2)
	TriggerClientEvent("mafije:JelTiOtvoren", id2, id)
end)

RegisterNetEvent('mafije:ProsljediKamion')
AddEventHandler('mafije:ProsljediKamion', function(netid, dostid, ob1, ob2, ob3, vrsta, job)
	table.insert(Kamioni, {NetID = netid, Dostava = dostid, Obj1 = ob1, Obj2 = ob2, Obj3 = ob3, Vrsta = vrsta, Posao = job})
	TriggerClientEvent("mafije:VratiKamione", -1, Kamioni)
end)

RegisterNetEvent('mafije:NarudzbeOruzja')
AddEventHandler('mafije:NarudzbeOruzja', function(vehid, objid, job, oruz)
	table.insert(Guardiani, {VehID = vehid, ObjID = objid, Posao = job, Oruzja = oruz})
	TriggerClientEvent("mafije:VratiGuardiane", -1, Guardiani)
end)

RegisterNetEvent('mafija:OdeJedan')
AddEventHandler('mafija:OdeJedan', function(plate, pr)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	MySQL.Async.execute('DELETE from ukradeni WHERE tablica = @pl', {
		['@pl'] = plate
	}, function(rowsChanged)
	end)
	MySQL.Async.execute('DELETE from owned_vehicles WHERE plate = @pl', {
		['@pl'] = plate
	}, function(rowsChanged)
	end)
	xPlayer.addMoney(pr)
	xPlayer.showNotification("Vozilo je 7 ili vise dana kod vas i dobili ste od njega $"..pr..".")
end)

RegisterNetEvent('mafija:MakniUkraden')
AddEventHandler('mafija:MakniUkraden', function(plate)
	MySQL.Async.execute('DELETE from ukradeni WHERE tablica = @pl', {
		['@pl'] = plate
	}, function(rowsChanged)
	end)
end)

ESX.RegisterServerCallback('mafija:DofatiDatum', function(source, cb, plate)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT * FROM ukradeni WHERE tablica = @plate', {
		['@plate'] = plate
	}, function(result)
		local d, m, y = string.match(result[1].datum, "(%d+)/(%d+)/(%d+)")
		if RacunajDane(d, m, y) >= 7 then
			cb(false)
		else
			cb(true)
		end
	end)
end)

function RacunajDane(d, m, y)
	reference = os.time{day=d, year=y, month=m}
	daysfrom = os.difftime(os.time(), reference) / (24 * 60 * 60) -- seconds in a day
	wholedays = math.floor(daysfrom)
	return wholedays;
end

RegisterNetEvent('mafije:MakniKamion')
AddEventHandler('mafije:MakniKamion', function(netid)
	for i=1, #Kamioni, 1 do
		if Kamioni[i] ~= nil then
			if Kamioni[i].NetID == netid then
				table.remove(Kamioni, i)
				break
			end
		end
	end
	TriggerClientEvent("mafije:VratiKamione", -1, Kamioni)
end)

ESX.RegisterServerCallback('mafija:DohvatiProdaje', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local posao = xPlayer.getJob().name
	local naso = false
	for i=1, #Kamioni, 1 do
		if Kamioni[i] ~= nil then
			if Kamioni[i].Posao == posao then
				naso = true
				cb(true)
				break
			end
		end
	end
	if not naso then
		cb(false)
	end
end)

ESX.RegisterServerCallback('mafije:OsobnoVozilo', function(source, cb, plate)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT 1 FROM owned_vehicles WHERE plate = @plate AND state = 0', {
		['@plate'] = plate
	}, function(result)
		cb(result[1] ~= nil)
	end)
end)

RegisterNetEvent('mafije:BucketajGa')
AddEventHandler('mafije:BucketajGa', function(br)
	local src = source
	SetPlayerRoutingBucket(src, br)
	if br == 0 then
		while GetPlayerRoutingBucket(src) ~= 0 do
			Wait(100)
		end
		TriggerClientEvent("mafije:OdradioBucket", src)
	end
end)

RegisterNetEvent('mafije:StanjeSkladista')
AddEventHandler('mafije:StanjeSkladista', function(maf, dr)
	local xPlayer = ESX.GetPlayerFromId(source)
	local naso = false
	for i=1, #Skladiste, 1 do
		if Skladiste[i].Mafija == maf then
			naso = true
			if dr == 1 then
				xPlayer.showNotification("U skladistu imate "..Skladiste[i].Listovi.." listova i "..Skladiste[i].Kokain.."kg kokaina")
			elseif dr == 2 then
				xPlayer.showNotification("U skladistu imate "..Skladiste[i].Gljive.." gljiva i "..Skladiste[i].Heroin.."kg heroina")
			end
			break
		end
	end
	if not naso then
		xPlayer.showNotification("U skladistu nemate nista!")
	end
end)

function PreradiGljive()
	for i=1, #Skladiste, 1 do
		if Skladiste[i] ~= nil and Skladiste[i].Gljive >= 100 and Skladiste[i].Heroin+50 <= 1200 then
			for j=1, #Mafije, 1 do
				if Mafije[j] ~= nil and Mafije[j].Ime == Skladiste[i].Mafija and Mafije[j].Skladiste2 == 1 then
					local societyAccount = nil
					local soc = "society_"..Skladiste[i].Mafija
					TriggerEvent('esx_addonaccount:getSharedAccount', soc, function(account)
						societyAccount = account
					end)
					if societyAccount.money >= 10000 then
						societyAccount.removeMoney(10000)
						societyAccount.save()
						Skladiste[i].Gljive = Skladiste[i].Gljive-100
						Skladiste[i].Heroin = Skladiste[i].Heroin+50
						MySQL.Async.execute('UPDATE mskladiste SET gljive = @list, heroin = @kok WHERE ime = @maf',{
							['@list'] = Skladiste[i].Gljive,
							['@kok'] = Skladiste[i].Heroin,
							['@maf'] = Skladiste[i].Mafija
						})
						TriggerClientEvent("mafije:PosaljiObavijest", -1, Skladiste[i].Mafija, "[Skladiste] 100 gljiva vam je uspjesno preradjeno u heroin (10000$)!")
					end
				end
			end
		end
		Wait(100)
	end
	TriggerClientEvent("mafije:UpdateSkladista", -1, Skladiste)
	SetTimeout(3600000, PreradiGljive)
end

SetTimeout(3600000, PreradiGljive)

function PreradiListove()
	for i=1, #Skladiste, 1 do
		if Skladiste[i] ~= nil and Skladiste[i].Listovi >= 100 and Skladiste[i].Kokain+50 <= 1200 then
			for j=1, #Mafije, 1 do
				if Mafije[j] ~= nil and Mafije[j].Ime == Skladiste[i].Mafija and Mafije[j].Skladiste == 1 then
					local societyAccount = nil
					local soc = "society_"..Skladiste[i].Mafija
					TriggerEvent('esx_addonaccount:getSharedAccount', soc, function(account)
						societyAccount = account
					end)
					if societyAccount.money >= 10000 then
						societyAccount.removeMoney(10000)
						societyAccount.save()
						Skladiste[i].Listovi = Skladiste[i].Listovi-100
						Skladiste[i].Kokain = Skladiste[i].Kokain+50
						MySQL.Async.execute('UPDATE mskladiste SET listovi = @list, kokain = @kok WHERE ime = @maf',{
							['@list'] = Skladiste[i].Listovi,
							['@kok'] = Skladiste[i].Kokain,
							['@maf'] = Skladiste[i].Mafija
						})
						TriggerClientEvent("mafije:PosaljiObavijest", -1, Skladiste[i].Mafija, "[Skladiste] 100 listova vam je uspjesno preradjeno u kokain (10000$)!")
					end
				end
			end
		end
		Wait(100)
	end
	TriggerClientEvent("mafije:UpdateSkladista", -1, Skladiste)
	SetTimeout(3600000, PreradiListove)
end

SetTimeout(3600000, PreradiListove)

RegisterNetEvent('mafije:OstaviListove2')
AddEventHandler('mafije:OstaviListove2', function(br, maf)
	local naso = false
	for i=1, #Skladiste, 1 do
		if Skladiste[i].Mafija == maf then
			naso = true
			Skladiste[i].Listovi = Skladiste[i].Listovi+br
			TriggerClientEvent("mafije:UpdateSkladista", -1, Skladiste)
			MySQL.Async.fetchScalar('SELECT ime FROM mskladiste WHERE ime = @maf', {
				['@maf'] = maf
			}, function(result)
				if result == nil then
					MySQL.Async.execute('INSERT INTO mskladiste (ime, listovi, kokain) VALUES (@maf, @list, 0)',{
						['@maf'] = maf,
						['@list'] = Skladiste[i].Listovi
					})
				else
					MySQL.Async.execute('UPDATE mskladiste SET listovi = @list WHERE ime = @maf',{
						['@list'] = Skladiste[i].Listovi,
						['@maf'] = maf
					})
				end
			end)
			break
		end
	end
	if not naso then
		table.insert(Skladiste, {Mafija = maf, Listovi = br, Kokain = 0, Heroin = 0, Gljive = 0})
		TriggerClientEvent("mafije:UpdateSkladista", -1, Skladiste)
		MySQL.Async.execute('INSERT INTO mskladiste (ime, listovi, kokain) VALUES (@maf, @list, 0)',{
			['@maf'] = maf,
			['@list'] = br
		})
	end
end)

RegisterNetEvent('mafije:OstaviListove')
AddEventHandler('mafije:OstaviListove', function(br, maf)
	local xPlayer = ESX.GetPlayerFromId(source)
	local item = xPlayer.getInventoryItem("coke")
	if item.count >= br and br > 0 then
		local naso = false
		for i=1, #Skladiste, 1 do
			if Skladiste[i].Mafija == maf then
				naso = true
				xPlayer.removeInventoryItem("coke", br)
				Skladiste[i].Listovi = Skladiste[i].Listovi+br
				xPlayer.showNotification("Ostavili ste "..br.." listova kokaina u labosu!")
				TriggerClientEvent("mafije:UpdateSkladista", -1, Skladiste)
				MySQL.Async.fetchScalar('SELECT ime FROM mskladiste WHERE ime = @maf', {
					['@maf'] = maf
				}, function(result)
					if result == nil then
						MySQL.Async.execute('INSERT INTO mskladiste (ime, listovi, kokain) VALUES (@maf, @list, 0)',{
							['@maf'] = maf,
							['@list'] = Skladiste[i].Listovi
						})
					else
						MySQL.Async.execute('UPDATE mskladiste SET listovi = @list WHERE ime = @maf',{
							['@list'] = Skladiste[i].Listovi,
							['@maf'] = maf
						})
					end
				end)
				break
			end
		end
		if not naso then
			xPlayer.removeInventoryItem("coke", br)
			table.insert(Skladiste, {Mafija = maf, Listovi = br, Kokain = 0, Heroin = 0, Gljive = 0})
			TriggerClientEvent("mafije:UpdateSkladista", -1, Skladiste)
			xPlayer.showNotification("Ostavili ste "..br.." listova kokaina u labosu!")
			MySQL.Async.execute('INSERT INTO mskladiste (ime, listovi, kokain) VALUES (@maf, @list, 0)',{
				['@maf'] = maf,
				['@list'] = br
			})
		end
	else
		xPlayer.showNotification("Nemate toliko listova!")
	end
end)

RegisterNetEvent('mafije:OstaviKoku')
AddEventHandler('mafije:OstaviKoku', function(br, maf)
	local xPlayer = ESX.GetPlayerFromId(source)
	local item = xPlayer.getInventoryItem("cocaine")
	if item.count >= br and br > 0 and br < 1201 then
		local naso = false
		for i=1, #Skladiste, 1 do
			if Skladiste[i].Mafija == maf then
				naso = true
				if Skladiste[i].Kokain+br <= 1200 then
					xPlayer.removeInventoryItem("cocaine", br)
					Skladiste[i].Kokain = Skladiste[i].Kokain+br
					xPlayer.showNotification("Ostavili ste "..br.."kg kokaina u labosu!")
					TriggerClientEvent("mafije:UpdateSkladista", -1, Skladiste)
					MySQL.Async.fetchScalar('SELECT ime FROM mskladiste WHERE ime = @maf', {
						['@maf'] = maf
					}, function(result)
						if result == nil then
							MySQL.Async.execute('INSERT INTO mskladiste (ime, listovi, kokain) VALUES (@maf, 0, @kok)',{
								['@maf'] = maf,
								['@kok'] = Skladiste[i].Kokain
							})
						else
							MySQL.Async.execute('UPDATE mskladiste SET kokain = @kok WHERE ime = @maf',{
								['@kok'] = Skladiste[i].Kokain,
								['@maf'] = maf
							})
						end
					end)
				else
					xPlayer.showNotification("Ne stane vam toliko u skladiste (1200kg max)!")
				end
				break
			end
		end
		if not naso then
			xPlayer.removeInventoryItem("cocaine", br)
			table.insert(Skladiste, {Mafija = maf, Listovi = 0, Kokain = br, Heroin = 0, Gljive = 0})
			TriggerClientEvent("mafije:UpdateSkladista", -1, Skladiste)
			xPlayer.showNotification("Ostavili ste "..br.."kg kokaina u labosu!")
			MySQL.Async.execute('INSERT INTO mskladiste (ime, listovi, kokain) VALUES (@maf, 0, @kok)',{
				['@maf'] = maf,
				['@kok'] = br
			})
		end
	else
		xPlayer.showNotification("Nemate toliko kokaina/ne stane vam toliko u skladiste!")
	end
end)

RegisterServerEvent('mafije:UzmiKoku')
AddEventHandler('mafije:UzmiKoku', function(count, maf, torba)
  	local itemName = "cocaine"
  	local xPlayer = ESX.GetPlayerFromId(source)
  	local sourceItem = xPlayer.getInventoryItem(itemName)

	local naso = false
	for i=1, #Skladiste, 1 do
		if Skladiste[i].Mafija == maf then
			  naso = true
			  if Skladiste[i].Kokain >= count then
				if torba then
					if sourceItem.limit ~= -1 and (sourceItem.count + count) <= sourceItem.limit*2 then
						xPlayer.addInventoryItem("cocaine", count)
						local por = "["..os.date("%X").."] ("..GetCurrentResourceName()..") Igrac "..GetPlayerName(source).."("..xPlayer.identifier..") je dobio item cocaine x "..count
						TriggerEvent("SpremiLog", por)
						Skladiste[i].Kokain = Skladiste[i].Kokain-count
						xPlayer.showNotification("Uzeli ste "..count.."kg kokaina iz labosa!")
						TriggerClientEvent("mafije:UpdateSkladista", -1, Skladiste)
						MySQL.Async.execute('UPDATE mskladiste SET kokain = @kok WHERE ime = @maf',{
							['@kok'] = Skladiste[i].Kokain,
							['@maf'] = maf
						})
					else
						if sourceItem.limit == -1 then
							xPlayer.addInventoryItem("cocaine", count)
							local por = "["..os.date("%X").."] ("..GetCurrentResourceName()..") Igrac "..GetPlayerName(source).."("..xPlayer.identifier..") je dobio item cocaine x "..count
							TriggerEvent("SpremiLog", por)
							Skladiste[i].Kokain = Skladiste[i].Kokain-count
							xPlayer.showNotification("Uzeli ste "..count.."kg kokaina iz labosa!")
							TriggerClientEvent("mafije:UpdateSkladista", -1, Skladiste)
							MySQL.Async.execute('UPDATE mskladiste SET kokain = @kok WHERE ime = @maf',{
								['@kok'] = Skladiste[i].Kokain,
								['@maf'] = maf
							})
						else
							TriggerClientEvent('esx:showNotification', xPlayer.source, "Ne stane vam vise u inventory!")
						end
					end
				else
					if sourceItem.limit ~= -1 and (sourceItem.count + count) <= sourceItem.limit then
						xPlayer.addInventoryItem("cocaine", count)
						local por = "["..os.date("%X").."] ("..GetCurrentResourceName()..") Igrac "..GetPlayerName(source).."("..xPlayer.identifier..") je dobio item cocaine x "..count
						TriggerEvent("SpremiLog", por)
						Skladiste[i].Kokain = Skladiste[i].Kokain-count
						xPlayer.showNotification("Uzeli ste "..count.."kg kokaina iz labosa!")
						TriggerClientEvent("mafije:UpdateSkladista", -1, Skladiste)
						MySQL.Async.execute('UPDATE mskladiste SET kokain = @kok WHERE ime = @maf',{
							['@kok'] = Skladiste[i].Kokain,
							['@maf'] = maf
						})
					else
						if sourceItem.limit == -1 then
							xPlayer.addInventoryItem("cocaine", count)
							local por = "["..os.date("%X").."] ("..GetCurrentResourceName()..") Igrac "..GetPlayerName(source).."("..xPlayer.identifier..") je dobio item cocaine x "..count
							TriggerEvent("SpremiLog", por)
							Skladiste[i].Kokain = Skladiste[i].Kokain-count
							xPlayer.showNotification("Uzeli ste "..count.."kg kokaina iz labosa!")
							TriggerClientEvent("mafije:UpdateSkladista", -1, Skladiste)
							MySQL.Async.execute('UPDATE mskladiste SET kokain = @kok WHERE ime = @maf',{
								['@kok'] = Skladiste[i].Kokain,
								['@maf'] = maf
							})
						else
							TriggerClientEvent('esx:showNotification', xPlayer.source, "Ne stane vam vise u inventory!")
						end
					end
				end
			  else
				  xPlayer.showNotification("Nemate toliko u skladistu!")
			  end
			  break
		end
	end
	if not naso then
		xPlayer.showNotification("Nemate toliko u skladistu!")
	end
end)

RegisterNetEvent('mafije:OstaviGljive')
AddEventHandler('mafije:OstaviGljive', function(br, maf)
	local xPlayer = ESX.GetPlayerFromId(source)
	local item = xPlayer.getInventoryItem("gljive")
	if item.count >= br and br > 0 then
		local naso = false
		for i=1, #Skladiste, 1 do
			if Skladiste[i].Mafija == maf then
				naso = true
				xPlayer.removeInventoryItem("gljive", br)
				Skladiste[i].Gljive = Skladiste[i].Gljive+br
				xPlayer.showNotification("Ostavili ste "..br.." gljiva u labosu!")
				TriggerClientEvent("mafije:UpdateSkladista", -1, Skladiste)
				MySQL.Async.fetchScalar('SELECT ime FROM mskladiste WHERE ime = @maf', {
					['@maf'] = maf
				}, function(result)
					if result == nil then
						MySQL.Async.execute('INSERT INTO mskladiste (ime, gljive, heroin) VALUES (@maf, @glj, 0)',{
							['@maf'] = maf,
							['@glj'] = Skladiste[i].Gljive
						})
					else
						MySQL.Async.execute('UPDATE mskladiste SET gljive = @list WHERE ime = @maf',{
							['@list'] = Skladiste[i].Gljive,
							['@maf'] = maf
						})
					end
				end)
				break
			end
		end
		if not naso then
			xPlayer.removeInventoryItem("gljive", br)
			table.insert(Skladiste, {Mafija = maf, Gljive = br, Heroin = 0, Kokain = 0, Listovi = 0})
			TriggerClientEvent("mafije:UpdateSkladista", -1, Skladiste)
			xPlayer.showNotification("Ostavili ste "..br.." gljiva u labosu!")
			MySQL.Async.execute('INSERT INTO mskladiste (ime, gljive, heroin) VALUES (@maf, @glj, 0)',{
				['@maf'] = maf,
				['@glj'] = br
			})
		end
	else
		xPlayer.showNotification("Nemate toliko gljiva!")
	end
end)

RegisterNetEvent('mafije:OstaviGljive2')
AddEventHandler('mafije:OstaviGljive2', function(br, maf)
	local naso = false
	for i=1, #Skladiste, 1 do
		if Skladiste[i].Mafija == maf then
			naso = true
			Skladiste[i].Gljive = Skladiste[i].Gljive+br
			TriggerClientEvent("mafije:UpdateSkladista", -1, Skladiste)
			MySQL.Async.fetchScalar('SELECT ime FROM mskladiste WHERE ime = @maf', {
				['@maf'] = maf
			}, function(result)
				if result == nil then
					MySQL.Async.execute('INSERT INTO mskladiste (ime, gljive, heroin) VALUES (@maf, @glj, 0)',{
						['@maf'] = maf,
						['@glj'] = Skladiste[i].Gljive
					})
				else
					MySQL.Async.execute('UPDATE mskladiste SET gljive = @list WHERE ime = @maf',{
						['@list'] = Skladiste[i].Gljive,
						['@maf'] = maf
					})
				end
			end)
			break
		end
	end
	if not naso then
		table.insert(Skladiste, {Mafija = maf, Gljive = br, Heroin = 0, Kokain = 0, Listovi = 0})
		TriggerClientEvent("mafije:UpdateSkladista", -1, Skladiste)
		MySQL.Async.execute('INSERT INTO mskladiste (ime, gljive, heroin) VALUES (@maf, @glj, 0)',{
			['@maf'] = maf,
			['@glj'] = br
		})
	end
end)

RegisterNetEvent('mafije:OstaviHeroin')
AddEventHandler('mafije:OstaviHeroin', function(br, maf)
	local xPlayer = ESX.GetPlayerFromId(source)
	local item = xPlayer.getInventoryItem("heroin")
	if item.count >= br and br > 0 and br < 1201 then
		local naso = false
		for i=1, #Skladiste, 1 do
			if Skladiste[i].Mafija == maf then
				naso = true
				if Skladiste[i].Heroin+br <= 1200 then
					xPlayer.removeInventoryItem("heroin", br)
					Skladiste[i].Heroin = Skladiste[i].Heroin+br
					xPlayer.showNotification("Ostavili ste "..br.."kg heroina u labosu!")
					TriggerClientEvent("mafije:UpdateSkladista", -1, Skladiste)
					MySQL.Async.fetchScalar('SELECT ime FROM mskladiste WHERE ime = @maf', {
						['@maf'] = maf
					}, function(result)
						if result == nil then
							MySQL.Async.execute('INSERT INTO mskladiste (ime, gljive, heroin) VALUES (@maf, 0, @her)',{
								['@maf'] = maf,
								['@her'] = Skladiste[i].Heroin
							})
						else
							MySQL.Async.execute('UPDATE mskladiste SET heroin = @her WHERE ime = @maf',{
								['@her'] = Skladiste[i].Heroin,
								['@maf'] = maf
							})
						end
					end)
				else
					xPlayer.showNotification("Ne stane vam toliko u skladiste (1200kg max)!")
				end
				break
			end
		end
		if not naso then
			xPlayer.removeInventoryItem("heroin", br)
			table.insert(Skladiste, {Mafija = maf, Gljive = 0, Heroin = br, Kokain = 0, Listovi = 0})
			TriggerClientEvent("mafije:UpdateSkladista", -1, Skladiste)
			xPlayer.showNotification("Ostavili ste "..br.."kg heroina u labosu!")
			MySQL.Async.execute('INSERT INTO mskladiste (ime, gljive, heroin) VALUES (@maf, 0, @her)',{
				['@maf'] = maf,
				['@her'] = br
			})
		end
	else
		xPlayer.showNotification("Nemate toliko heroina/ne stane vam toliko u skladiste!")
	end
end)

RegisterNetEvent('mafije:OstHerProd')
AddEventHandler('mafije:OstHerProd', function(maf)
	local xPlayer = ESX.GetPlayerFromId(source)
	local naso = false
	local br = 300
	for i=1, #Skladiste, 1 do
		if Skladiste[i].Mafija == maf then
			naso = true
			if (Skladiste[i].Heroin+br) > 1200 then
				br = 1200-Skladiste[i].Heroin
			end
			Skladiste[i].Heroin = Skladiste[i].Heroin+br
			xPlayer.showNotification("Dobili ste "..br.."kg heroina u skladiste!")
			TriggerClientEvent("mafije:UpdateSkladista", -1, Skladiste)
			MySQL.Async.fetchScalar('SELECT ime FROM mskladiste WHERE ime = @maf', {
				['@maf'] = maf
			}, function(result)
				if result == nil then
					MySQL.Async.execute('INSERT INTO mskladiste (ime, gljive, heroin) VALUES (@maf, 0, @her)',{
						['@maf'] = maf,
						['@her'] = Skladiste[i].Heroin
					})
				else
					MySQL.Async.execute('UPDATE mskladiste SET heroin = @her WHERE ime = @maf',{
						['@her'] = Skladiste[i].Heroin,
						['@maf'] = maf
					})
				end
			end)
			break
		end
	end
	if not naso then
		table.insert(Skladiste, {Mafija = maf, Gljive = 0, Heroin = br, Kokain = 0, Listovi = 0})
		TriggerClientEvent("mafije:UpdateSkladista", -1, Skladiste)
		xPlayer.showNotification("Dobili ste "..br.."kg heroina u skladiste!")
		MySQL.Async.execute('INSERT INTO mskladiste (ime, gljive, heroin) VALUES (@maf, 0, @her)',{
			['@maf'] = maf,
			['@her'] = br
		})
	end
end)

RegisterServerEvent('mafije:UzmiHeroin')
AddEventHandler('mafije:UzmiHeroin', function(count, maf, torba)
  	local itemName = "heroin"
  	local xPlayer = ESX.GetPlayerFromId(source)
  	local sourceItem = xPlayer.getInventoryItem(itemName)

	local naso = false
	for i=1, #Skladiste, 1 do
		if Skladiste[i].Mafija == maf then
			  naso = true
			  if Skladiste[i].Heroin >= count then
				if torba then
					if sourceItem.limit ~= -1 and (sourceItem.count + count) <= sourceItem.limit*2 then
						xPlayer.addInventoryItem("heroin", count)
						local por = "["..os.date("%X").."] ("..GetCurrentResourceName()..") Igrac "..GetPlayerName(source).."("..xPlayer.identifier..") je dobio item heroin x "..count
						TriggerEvent("SpremiLog", por)
						Skladiste[i].Heroin = Skladiste[i].Heroin-count
						xPlayer.showNotification("Uzeli ste "..count.."kg heroina iz labosa!")
						TriggerClientEvent("mafije:UpdateSkladista", -1, Skladiste)
						MySQL.Async.execute('UPDATE mskladiste SET heroin = @her WHERE ime = @maf',{
							['@her'] = Skladiste[i].Heroin,
							['@maf'] = maf
						})
					else
						if sourceItem.limit == -1 then
							xPlayer.addInventoryItem("heroin", count)
							local por = "["..os.date("%X").."] ("..GetCurrentResourceName()..") Igrac "..GetPlayerName(source).."("..xPlayer.identifier..") je dobio item heroin x "..count
							TriggerEvent("SpremiLog", por)
							Skladiste[i].Heroin = Skladiste[i].Heroin-count
							xPlayer.showNotification("Uzeli ste "..count.."kg heroina iz labosa!")
							TriggerClientEvent("mafije:UpdateSkladista", -1, Skladiste)
							MySQL.Async.execute('UPDATE mskladiste SET heroin = @her WHERE ime = @maf',{
								['@her'] = Skladiste[i].Heroin,
								['@maf'] = maf
							})
						else
							TriggerClientEvent('esx:showNotification', xPlayer.source, "Ne stane vam vise u inventory!")
						end
					end
				else
					if sourceItem.limit ~= -1 and (sourceItem.count + count) <= sourceItem.limit then
						xPlayer.addInventoryItem("heroin", count)
						local por = "["..os.date("%X").."] ("..GetCurrentResourceName()..") Igrac "..GetPlayerName(source).."("..xPlayer.identifier..") je dobio item heroin x "..count
						TriggerEvent("SpremiLog", por)
						Skladiste[i].Heroin = Skladiste[i].Heroin-count
						xPlayer.showNotification("Uzeli ste "..count.."kg heroina iz labosa!")
						TriggerClientEvent("mafije:UpdateSkladista", -1, Skladiste)
						MySQL.Async.execute('UPDATE mskladiste SET heroin = @her WHERE ime = @maf',{
							['@her'] = Skladiste[i].Heroin,
							['@maf'] = maf
						})
					else
						if sourceItem.limit == -1 then
							xPlayer.addInventoryItem("heroin", count)
							local por = "["..os.date("%X").."] ("..GetCurrentResourceName()..") Igrac "..GetPlayerName(source).."("..xPlayer.identifier..") je dobio item heroin x "..count
							TriggerEvent("SpremiLog", por)
							Skladiste[i].Heroin = Skladiste[i].Heroin-count
							xPlayer.showNotification("Uzeli ste "..count.."kg heroina iz labosa!")
							TriggerClientEvent("mafije:UpdateSkladista", -1, Skladiste)
							MySQL.Async.execute('UPDATE mskladiste SET heroin = @her WHERE ime = @maf',{
								['@her'] = Skladiste[i].Heroin,
								['@maf'] = maf
							})
						else
							TriggerClientEvent('esx:showNotification', xPlayer.source, "Ne stane vam vise u inventory!")
						end
					end
				end
			  else
				  xPlayer.showNotification("Nemate toliko u skladistu!")
			  end
			  break
		end
	end
	if not naso then
		xPlayer.showNotification("Nemate toliko u skladistu!")
	end
end)

for i=1, #Config.Weapons, 1 do
	ESX.RegisterUsableItem(string.lower(Config.Weapons[i].name), function(source)
		local xPlayer = ESX.GetPlayerFromId(source)
		TriggerClientEvent('esx:showNotification', source, "Uzeli ste "..Config.Weapons[i].label.." iz inventoryja!")
		xPlayer.removeInventoryItem(string.lower(Config.Weapons[i].name), 1)
		xPlayer.addWeapon(Config.Weapons[i].name, 250)
	end)
end

RegisterCommand("f", function(source, args, rawCommandString)
	local _source = source
	local targetXPlayer = ESX.GetPlayerFromId(_source)
	local naso = 0
	for i=1, #Mafije, 1 do
		if Mafije[i] ~= nil and Mafije[i].Ime == targetXPlayer.job.name then
			naso = 1
			break
		end
	end
	if naso == 1 or targetXPlayer.job.name == "ballas" or targetXPlayer.job.name == "zemunski" then
		if args[1] ~= nil then
			local name = getIdentity(_source)
		 	local fal = name.firstname .. " " .. name.lastname
			TriggerClientEvent("esx_mafije:PosaljiMafia", -1, table.concat(args, " "), fal, targetXPlayer.job.name)
		else
			name = "System"..": "
			message = "/f [Poruka]"
			TriggerClientEvent('chat:addMessage', _source, { args = { name, message }, color = r,g,b })
		end	
	else
		name = "System"..":"
		message = " Nemate pristup ovoj komandi"
		TriggerClientEvent('chat:addMessage', _source, { args = { name, message }, color = r,g,b })	
	end
end, false)

function getIdentity(source)
	local identifier = GetPlayerIdentifiers(source)[1]
	local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
	if result[1] ~= nil then
		local identity = result[1]

		return {
			identifier = identity['identifier'],
			firstname = identity['firstname'],
			lastname = identity['lastname'],
			dateofbirth = identity['dateofbirth'],
			sex = identity['sex'],
			height = identity['height']
			
		}
	else
		return nil
	end
end

RegisterNetEvent('mafije:SaljemOtvoren')
AddEventHandler('mafije:SaljemOtvoren', function(id, menu)
	TriggerClientEvent("mafije:VracamOtvoren", id, menu)
end)

RegisterNetEvent('mafije:NapraviMafiju')
AddEventHandler('mafije:NapraviMafiju', function(maf, lab)
		local Postoji = 0
		for i=1, #Mafije, 1 do
			if Mafije[i] ~= nil and Mafije[i].Ime == maf then
				Postoji = 1
			end
		end
		if Postoji == 0 then
			local label = lab
			MySQL.Async.execute('INSERT INTO mafije (Ime, Label) VALUES (@ime, @lab)',{
				['@ime'] = maf,
				['@lab'] = label
			})
			
			table.insert(Mafije, {Ime = maf, Label = lab, Posao = 0, Skladiste = 0, Skladiste2 = 0, Avion = 0})
			TriggerClientEvent("mafije:UpdateMafije", -1, Mafije)
			MySQL.Async.fetchAll('select max(pID)+1 as br from jobs', {}, function(rez)
				MySQL.Async.insert('INSERT INTO jobs (pID, name, label, whitelisted) VALUES (@id, @ime, @lab, @white)',{
					['@id'] = rez[1].br,
					['@ime'] = maf,
					['@lab'] = label,
					['@white'] = 1
				}, function(insertId)
					MySQL.Async.execute('INSERT INTO addon_inventory (name, label, shared) VALUES (@ime, @lab, @sh)',{
						['@ime'] = insertId,
						['@lab'] = label,
						['@sh'] = 1
					})
				end)
			end)
			
			local soc = "society_"..maf
			
			MySQL.Async.execute('INSERT INTO addon_account (name, label, shared) VALUES (@ime, @lab, @sh)',{
				['@ime'] = soc,
				['@lab'] = label,
				['@sh'] = 1
			})
			
			MySQL.Async.execute('INSERT INTO datastore (name, label, shared) VALUES (@ime, @lab, @sh)',{
				['@ime'] = soc,
				['@lab'] = label,
				['@sh'] = 1
			})
			TriggerClientEvent('esx:showNotification', source, 'Mafija '..label..' uspjesno kreirana!')
			SetTimeout(2000, function()
				TriggerEvent("RefreshAddone")
				TriggerEvent("RefreshSociety")
				TriggerEvent("RefreshDatastore")
				TriggerEvent("RefreshInventory")
				TriggerEvent('esx_society:registerSociety', maf, label, soc, soc, soc, {type = 'public'})
				TriggerEvent("RefreshPoslove")
			end)
		else
			TriggerClientEvent('esx:showNotification', source, 'Mafija sa tim imenom vec postoji!')
		end
end)

RegisterNetEvent('mafije:ObrisiMafiju')
AddEventHandler('mafije:ObrisiMafiju', function(maf)
		local Postoji = 0
		for i=1, #Mafije, 1 do
			if Mafije[i] ~= nil and Mafije[i].Ime == maf then
				Postoji = 1
				table.remove(Mafije, i)
			end
		end
		if Postoji == 1 then
			MySQL.Async.execute('DELETE FROM mafije WHERE Ime = @ime',{
				['@ime'] = maf
			})
			
			for i=#Koord,1,-1 do
				if Koord[i] ~= nil and Koord[i].Mafija == maf then
					table.remove(Koord, i)
				end
			end
			
			for i=#Rankovi,1,-1 do
				if Rankovi[i] ~= nil and Rankovi[i].Mafija == maf then
					table.remove(Rankovi, i)
				end
			end
			
			for i=#Vozila,1,-1 do
				if Vozila[i] ~= nil and Vozila[i].Mafija == maf then
					table.remove(Vozila, i)
				end
			end
			
			for i=#Oruzja,1,-1 do
				if Oruzja[i] ~= nil and Oruzja[i].Mafija == maf then
					table.remove(Oruzja, i)
				end
			end
			
			for i=#Boje,1,-1 do
				if Boje[i] ~= nil and Boje[i].Mafija == maf then
					table.remove(Boje, i)
				end
			end
			
			for i=#Skladiste,1,-1 do
				if Skladiste[i] ~= nil and Skladiste[i].Mafija == maf then
					table.remove(Skladiste, i)
				end
			end

			MySQL.Async.fetchAll('select pID from jobs where name = @name', { ['@name'] = maf }, function(rez)
				MySQL.Async.execute('DELETE FROM addon_inventory WHERE name = @ime',{
					['@ime'] = rez[1].pID
				})
				
				MySQL.Async.execute('DELETE FROM addon_inventory_items WHERE inventory_name = @ime',{
					['@ime'] = rez[1].pID
				})
			end)
			
			MySQL.Async.execute('DELETE FROM jobs WHERE name = @ime',{
				['@ime'] = maf
			})
			
			MySQL.Async.execute('DELETE FROM job_grades WHERE job_name = @ime',{
				['@ime'] = maf
			})
			
			local soc = "society_"..maf
			
			MySQL.Async.execute('DELETE FROM addon_account_data WHERE account_name = @ime',{
				['@ime'] = soc
			})
			
			MySQL.Async.execute('DELETE FROM addon_account WHERE name = @ime',{
				['@ime'] = soc
			})
			
			MySQL.Async.execute('DELETE FROM datastore WHERE name = @ime',{
				['@ime'] = soc
			})
			
			MySQL.Async.execute('DELETE FROM datastore_data WHERE name = @ime',{
				['@ime'] = soc
			})
			
			MySQL.Async.execute('DELETE FROM mskladiste WHERE ime = @ime',{
				['@ime'] = maf
			})
			TriggerClientEvent('esx:showNotification', source, 'Mafija '..maf..' uspjesno obrisana!')
			SetTimeout(2000, function()
				TriggerEvent("RefreshAddone")
				TriggerEvent("RefreshSociety")
				TriggerEvent("RefreshDatastore")
				TriggerEvent("RefreshInventory")
				TriggerEvent("RefreshPoslove")
				
				TriggerClientEvent("mafije:PosaljiVozila", -1, maf, Vozila)
				TriggerClientEvent("mafije:PosaljiOruzja", -1, maf, Oruzja)
				TriggerClientEvent("mafije:UpdateKoord", -1, Koord)
				TriggerClientEvent("mafije:UpdateBoje", -1, 3, maf, Boje)
				TriggerClientEvent("mafije:UpdateRankove", -1, Rankovi)
				TriggerClientEvent("mafije:UpdateMafije", -1, Mafije)
				TriggerClientEvent("mafije:UpdateSkladista", -1, Skladiste)
			end)
		else
			TriggerClientEvent('esx:showNotification', source, 'Mafija sa tim imenom ne postoji!')
		end
end)

RegisterNetEvent('mafije:DodajBoju')
AddEventHandler('mafije:DodajBoju', function(maf, br, bojaid, r, g, b)
		local Test2 = 0
		for i=1, #Mafije, 1 do
			if Mafije[i] ~= nil and Mafije[i].Ime == maf then
				Test2 = 1
			end
		end
		if Test2 == 1 then
			if tonumber(br) == 1 then
					local Postoji = 0
					for i=1, #Boje, 1 do
						if Boje[i] ~= nil and Boje[i].Mafija == maf and Boje[i].Ime == "Vozilo" then
							Boje[i].R = r
							Boje[i].G = g
							Boje[i].B = b
							Postoji = 1
						end
					end
					if Postoji == 0 then
						table.insert(Boje, {Mafija = maf, Ime = "Vozilo", R = r, G = g, B = b})
					end
					
					local Temp = {}
					for i=1, #Boje, 1 do
						if Boje[i] ~= nil and Boje[i].Mafija == maf then
							if Boje[i].R then
								table.insert(Temp, {Ime = Boje[i].Ime, R = Boje[i].R, G = Boje[i].G, B = Boje[i].B})
							else
								table.insert(Temp, {Ime = Boje[i].Ime, Boja = Boje[i].Boja})
							end
						end
					end
					
					MySQL.Async.execute('UPDATE mafije SET Boje = @boj WHERE Ime = @im', {
						['@boj'] = json.encode(Temp),
						['@im'] = maf
					})
					TriggerClientEvent("mafije:UpdateBoje", -1, 1, maf, Boje)
			elseif tonumber(br) == 2 then
					local Postoji = 0
					for i=1, #Boje, 1 do
						if Boje[i] ~= nil and Boje[i].Mafija == maf and Boje[i].Ime == "Blip" then
							Boje[i].Boja = bojaid
							Postoji = 1
						end
					end
					if Postoji == 0 then
						table.insert(Boje, {Mafija = maf, Ime = "Blip", Boja = bojaid})
					end
					
					local Temp = {}
					for i=1, #Boje, 1 do
						if Boje[i] ~= nil and Boje[i].Mafija == maf then
							if Boje[i].R then
								table.insert(Temp, {Ime = Boje[i].Ime, R = Boje[i].R, G = Boje[i].G, B = Boje[i].B})
							else
								table.insert(Temp, {Ime = Boje[i].Ime, Boja = Boje[i].Boja})
							end
						end
					end
					
					MySQL.Async.execute('UPDATE mafije SET Boje = @boj WHERE Ime = @im', {
						['@boj'] = json.encode(Temp),
						['@im'] = maf
					})
					TriggerClientEvent("mafije:UpdateBoje", -1, 2, maf, Boje)
			end
		else
			TriggerClientEvent('esx:showNotification', source, 'Mafija ne postoji!')
		end
end)

RegisterNetEvent('mafije:PromjeniIme')
AddEventHandler('mafije:PromjeniIme', function(maf, ime, label)
	local src = source
	for i=1, #Mafije, 1 do
		if Mafije[i] ~= nil and Mafije[i].Ime == maf then
			Mafije[i].Label = label
			Mafije[i].Ime = ime
			Mafije[i].Skladiste = 0
			Mafije[i].Skladiste2 = 0
		end
	end
	MySQL.Async.execute('UPDATE mafije SET Ime = @ime, Label = @lab, Skladiste = 0 WHERE Ime = @im', {
		['@ime'] = ime,
		['@lab'] = label,
		['@im'] = maf
	})
	MySQL.Async.execute('UPDATE jobs SET name = @ime, label = @lab WHERE name = @im', {
		['@ime'] = ime,
		['@lab'] = label,
		['@im'] = maf
	})
	local soc = "society_"..maf
	local soc2 = "society_"..ime
	MySQL.Async.execute('UPDATE addon_account SET name = @ime, label = @lab WHERE name = @im', {
		['@ime'] = soc2,
		['@lab'] = label,
		['@im'] = soc
	})
	MySQL.Async.execute('UPDATE addon_account_data SET account_name = @ime WHERE account_name = @im', {
		['@ime'] = soc2,
		['@im'] = soc
	})
	MySQL.Async.execute('UPDATE addon_inventory SET name = @ime, label = @lab WHERE name = @im', {
		['@ime'] = soc2,
		['@lab'] = label,
		['@im'] = soc
	})
	MySQL.Async.execute('UPDATE addon_inventory_items SET inventory_name = @ime WHERE inventory_name = @im', {
		['@ime'] = soc2,
		['@im'] = soc
	})
	MySQL.Async.execute('UPDATE datastore SET name = @ime, label = @lab WHERE name = @im', {
		['@ime'] = soc2,
		['@lab'] = label,
		['@im'] = soc
	})
	MySQL.Async.execute('UPDATE datastore_data SET name = @ime WHERE name = @im', {
		['@ime'] = soc2,
		['@im'] = soc
	})
	MySQL.Async.execute('UPDATE job_grades SET job_name = @ime WHERE job_name = @im', {
		['@ime'] = ime,
		['@im'] = maf
	})
	MySQL.Async.execute('DELETE FROM mskladiste WHERE ime = @im', {
		['@im'] = maf
	})
	if Config.Blipovi == true then
		TriggerClientEvent("mafije:UpdateImeBlipa", -1, maf, ime)
	end
	for i=1, #Vozila, 1 do
		if Vozila[i] ~= nil and Vozila[i].Mafija == maf then
			Vozila[i].Mafija = ime
		end
	end
	for i=1, #Rankovi, 1 do
		if Rankovi[i] ~= nil and Rankovi[i].Mafija == maf then
			Rankovi[i].Mafija = ime
		end
	end
	for i=1, #Oruzja, 1 do
		if Oruzja[i] ~= nil and Oruzja[i].Mafija == maf then
			Oruzja[i].Mafija = ime
		end
	end
	for i=1, #Koord, 1 do
		if Koord[i] ~= nil and Koord[i].Mafija == maf then
			Koord[i].Mafija = ime
		end
	end
	for i=1, #Boje, 1 do
		if Boje[i] ~= nil and Boje[i].Mafija == maf then
			Boje[i].Mafija = ime
		end
	end
	for i=1, #Skladiste, 1 do
		if Skladiste[i].Mafija == maf then
			table.remove(Skladiste, i)
		end
	end
	SetTimeout(2000, function()
		TriggerEvent("RefreshAddone")
		TriggerEvent("RefreshSociety")
		TriggerEvent('esx_society:registerSociety', ime, label, soc2, soc2, soc2, {type = 'public'})
		TriggerEvent("RefreshDatastore")
		TriggerEvent("RefreshInventory")
		TriggerEvent("RefreshPoslove")
				
		TriggerClientEvent("mafije:PosaljiVozila", -1, maf, Vozila)
		TriggerClientEvent("mafije:PosaljiOruzja", -1, maf, Oruzja)
		TriggerClientEvent("mafije:UpdateKoord", -1, Koord)
		TriggerClientEvent("mafije:UpdateBoje", -1, 3, maf, Boje)
		TriggerClientEvent("mafije:UpdateRankove", -1, Rankovi)
		TriggerClientEvent("mafije:UpdateMafije", -1, Mafije)
		TriggerClientEvent("mafije:UpdateSkladista", -1, Skladiste)
		local xPlayers 	= ESX.GetPlayers()
		for i=1, #xPlayers, 1 do
			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
			if xPlayer.job.name == maf then
				SetTimeout(1000, function()
					xPlayer.setJob(ime, xPlayer.job.grade)
				end)
			end
		end
	end)
	TriggerClientEvent('esx:showNotification', src, 'Uspjesno promjenjeno ime(label) mafiji '..maf..' u '..label..'!')
end)

RegisterNetEvent('mafije:DodajOruzje')
AddEventHandler('mafije:DodajOruzje', function(maf, ime, cij, staroime)
		local Test2 = 0
		if staroime == nil then
			for i=1, #Oruzja, 1 do
				if Oruzja[i] ~= nil and Oruzja[i].Mafija == maf and Oruzja[i].Ime == ime then
					Test2 = 1
				end
			end
		else
			for i=1, #Oruzja, 1 do
				if Oruzja[i] ~= nil and Oruzja[i].Mafija == maf and Oruzja[i].Ime == staroime then
					Test2 = 1
				end
			end
		end
		if Test2 == 0 then
			table.insert(Oruzja, {Mafija = maf, Ime = ime, Cijena = cij})
			
			local Temp = {}
			for i=1, #Oruzja, 1 do
				if Oruzja[i] ~= nil and Oruzja[i].Mafija == maf then
					table.insert(Temp, {Ime = Oruzja[i].Ime, Cijena = Oruzja[i].Cijena})
				end
			end
			
			MySQL.Async.execute('UPDATE mafije SET Oruzja = @or WHERE Ime = @im', {
				['@or'] = json.encode(Temp),
				['@im'] = maf
			})
			TriggerClientEvent("mafije:PosaljiOruzja", -1, maf, Oruzja)
			TriggerClientEvent('esx:showNotification', source, 'Oruzje '..ime..' je uspjesno dodano mafiji '..maf..'!')
		else
			for i=1, #Oruzja, 1 do
				if Oruzja[i] ~= nil and Oruzja[i].Mafija == maf and Oruzja[i].Ime == staroime then
					Oruzja[i].Ime = ime
					Oruzja[i].Cijena = cij
				end
			end
			
			local Temp = {}
			for i=1, #Oruzja, 1 do
				if Oruzja[i] ~= nil and Oruzja[i].Mafija == maf then
					table.insert(Temp, {Ime = Oruzja[i].Ime, Cijena = Oruzja[i].Cijena})
				end
			end
			
			MySQL.Async.execute('UPDATE mafije SET Oruzja = @or WHERE Ime = @im', {
				['@or'] = json.encode(Temp),
				['@im'] = maf
			})
			TriggerClientEvent("mafije:PosaljiOruzja", -1, maf, Oruzja)
			TriggerClientEvent('esx:showNotification', source, 'Oruzje '..ime..' je uspjesno azurirano mafiji '..maf..'!')
		end
end)

RegisterNetEvent('mafije:ObrisiOruzje')
AddEventHandler('mafije:ObrisiOruzje', function(ime, maf)
		local Postoji = 0
		for i=1, #Oruzja, 1 do
			if Oruzja[i] ~= nil and Oruzja[i].Ime == ime and Oruzja[i].Mafija == maf then
				Postoji = 1
				table.remove(Oruzja, i)
			end
		end
		if Postoji == 1 then
			local Temp = {}
			for h=1, #Oruzja, 1 do
				if Oruzja[h] ~= nil and Oruzja[h].Mafija == maf then
					table.insert(Temp, {Ime = Oruzja[h].Ime, Cijena = Oruzja[h].Cijena})
				end
			end
				
			MySQL.Async.execute('UPDATE mafije SET Oruzja = @or WHERE Ime = @im', {
				['@or'] = json.encode(Temp),
				['@im'] = maf
			})
			
			TriggerClientEvent("mafije:PosaljiOruzja", -1, maf, Oruzja)
			TriggerClientEvent('esx:showNotification', source, 'Oruzje '..ime..' uspjesno obrisano mafiji '..maf..'!')
		end
end)

RegisterNetEvent('mafije:DodajVozilo')
AddEventHandler('mafije:DodajVozilo', function(maf, ime, lab, staroime)
		local Test2 = 0
		if staroime == nil then
			for i=1, #Vozila, 1 do
				if Vozila[i] ~= nil and Vozila[i].Ime == ime and Vozila[i].Mafija == maf then
					Test2 = 1
				end
			end
		else
			for i=1, #Vozila, 1 do
				if Vozila[i] ~= nil and Vozila[i].Ime == staroime and Vozila[i].Mafija == maf then
					Test2 = 1
				end
			end
		end
		if Test2 == 0 then
			table.insert(Vozila, {Mafija = maf, Ime = ime, Label = lab})
			
			local Temp = {}
			for i=1, #Vozila, 1 do
				if Vozila[i] ~= nil and Vozila[i].Mafija == maf then
					table.insert(Temp, {Ime = Vozila[i].Ime, Label = Vozila[i].Label})
				end
			end
			
			MySQL.Async.execute('UPDATE mafije SET Vozila = @voz WHERE Ime = @im', {
				['@voz'] = json.encode(Temp),
				['@im'] = maf
			})
			TriggerClientEvent("mafije:PosaljiVozila", -1, maf, Vozila)
			TriggerClientEvent('esx:showNotification', source, 'Vozilo '..lab..'('..ime..') uspjesno dodano mafiji '..maf..'!')
		else
			for i=1, #Vozila, 1 do
				if Vozila[i] ~= nil and Vozila[i].Ime == staroime then
					Vozila[i].Ime = ime
					Vozila[i].Label = lab
				end
			end
			local Temp = {}
			for i=1, #Vozila, 1 do
				if Vozila[i] ~= nil and Vozila[i].Mafija == maf then
					table.insert(Temp, {Ime = Vozila[i].Ime, Label = Vozila[i].Label})
				end
			end
			
			MySQL.Async.execute('UPDATE mafije SET Vozila = @voz WHERE Ime = @im', {
				['@voz'] = json.encode(Temp),
				['@im'] = maf
			})
			TriggerClientEvent("mafije:PosaljiVozila", -1, maf, Vozila)
			TriggerClientEvent('esx:showNotification', source, 'Vozilo '..lab..'('..ime..') uspjesno azurirano mafiji '..maf..'!')
		end
end)

RegisterNetEvent('mafije:ObrisiVozilo')
AddEventHandler('mafije:ObrisiVozilo', function(ime, maf)
		local Postoji = 0
		for i=1, #Vozila, 1 do
			if Vozila[i] ~= nil and Vozila[i].Ime == ime and Vozila[i].Mafija == maf then
				Postoji = 1
				table.remove(Vozila, i)
			end
		end
		if Postoji == 1 then
			local Temp = {}
			for i=1, #Vozila, 1 do
				if Vozila[i] ~= nil and Vozila[i].Mafija == maf then
					table.insert(Temp, {Ime = Vozila[i].Ime, Label = Vozila[i].Label})
				end
			end
			
			MySQL.Async.execute('UPDATE mafije SET Vozila = @voz WHERE Ime = @im', {
				['@voz'] = json.encode(Temp),
				['@im'] = maf
			})
			
			TriggerClientEvent("mafije:PosaljiVozila", -1, maf, Vozila)
			TriggerClientEvent('esx:showNotification', source, 'Vozilo '..ime..' uspjesno obrisano mafiji '..maf..'!')
		end
end)

RegisterNetEvent('mafije:IsplatiSve')
AddEventHandler('mafije:IsplatiSve', function(maf)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	xPlayer.addMoney(4000)
	xPlayer.showNotification("Dobili ste 4000$ od dostave kokaina!")
	if maf ~= nil then
		local societyAccount = nil
		local soc = "society_"..maf
		TriggerEvent('esx_addonaccount:getSharedAccount', soc, function(account)
			societyAccount = account
		end)
		societyAccount.addMoney(25000)
		societyAccount.save()
		xPlayer.showNotification("Vasa mafija je dobila 25000$ od prodaje 300kg kokaina!")
	end
end)

RegisterNetEvent('mafije:IsplatiSve2')
AddEventHandler('mafije:IsplatiSve2', function(maf, vr)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	if vr == 1 then
		xPlayer.addMoney(4000)
		xPlayer.showNotification("Dobili ste 4000$ od dostave heroina!")
		if maf ~= nil then
			local societyAccount = nil
			local soc = "society_"..maf
			TriggerEvent('esx_addonaccount:getSharedAccount', soc, function(account)
				societyAccount = account
			end)
			societyAccount.addMoney(25000)
			societyAccount.save()
			xPlayer.showNotification("Vasa mafija je dobila 25000$ od prodaje 300kg heroina!")
		end
	elseif vr == 2 then
		xPlayer.addMoney(4750)
		xPlayer.showNotification("Dobili ste 4750$ od dostave heroina!")
		if maf ~= nil then
			local societyAccount = nil
			local soc = "society_"..maf
			TriggerEvent('esx_addonaccount:getSharedAccount', soc, function(account)
				societyAccount = account
			end)
			societyAccount.addMoney(35000)
			societyAccount.save()
			xPlayer.showNotification("Vasa mafija je dobila 35000$ od prodaje 300kg heroina!")
		end
	end
end)

RegisterNetEvent('mafije:ObrisiRank')
AddEventHandler('mafije:ObrisiRank', function(id, maf)
		local Postoji = 0
		for i=1, #Rankovi, 1 do
			if Rankovi[i] ~= nil and Rankovi[i].ID == id and Rankovi[i].Mafija == maf then
				Postoji = 1
				table.remove(Rankovi, i)
			end
		end
		if Postoji == 1 then
			local Temp = {}
			for i=1, #Rankovi, 1 do
				if Rankovi[i] ~= nil and Rankovi[i].Mafija == maf then
					table.insert(Temp, {ID = Rankovi[i].ID, Ime = Rankovi[i].Ime})
				end
			end
			
			MySQL.Async.execute('UPDATE mafije SET Rankovi = @ran WHERE Ime = @im', {
				['@ran'] = json.encode(Temp),
				['@im'] = maf
			})
			MySQL.Async.execute('DELETE FROM job_grades WHERE grade = @idic AND job_name = @maf',{
				['@idic'] = id,
				['@maf'] = maf
			})
			
			TriggerClientEvent("mafije:UpdateRankove", -1, Rankovi)
			TriggerEvent("RefreshPoslove")
			TriggerEvent("RefreshSociety")
			TriggerClientEvent('esx:showNotification', source, 'Rank '..id..' uspjesno obrisan mafiji '..maf..'!')
		end
end)

RegisterServerEvent('mafije:depositMoney')
AddEventHandler('mafije:depositMoney', function(maf, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local society = "society_"..maf
	amount = ESX.Math.Round(tonumber(amount))

	if amount > 0 and xPlayer.getMoney() >= amount then
		TriggerEvent('esx_addonaccount:getSharedAccount', society, function(account)
			xPlayer.removeMoney(amount)
			account.addMoney(amount)
			account.save()
			ESX.SavePlayer(xPlayer, function() 
			end)
		end)

		TriggerClientEvent('esx:showNotification', xPlayer.source, "Ostavili ste u sef $"..ESX.Math.GroupDigits(amount))
	else
		TriggerClientEvent('esx:showNotification', xPlayer.source, "Krivi iznos")
	end
end)

RegisterServerEvent('mafije:dajStanje')
AddEventHandler('mafije:dajStanje', function(maf)
	local xPlayer = ESX.GetPlayerFromId(source)
	local society = "society_"..maf
	TriggerEvent('esx_addonaccount:getSharedAccount', society, function(account)
		xPlayer.showNotification("U sefu imate $"..account.money)
	end)
end)

RegisterServerEvent('mafije:kupiAvion')
AddEventHandler('mafije:kupiAvion', function(maf)
	local xPlayer = ESX.GetPlayerFromId(source)
	local society = "society_"..maf
	for i=1, #Mafije, 1 do
		if Mafije[i].Ime == maf then
			if Mafije[i].Avion == 0 then
				TriggerEvent('esx_addonaccount:getSharedAccount', society, function(account)
					if account.money >= 100000 then
						account.removeMoney(100000)
						account.save()
						xPlayer.showNotification("Kupili ste avion za $100000!")
						Mafije[i].Avion = 1
						MySQL.Async.execute('UPDATE mafije SET Avion = 1 WHERE Ime = @maf',{
							['@maf'] = maf
						})
						TriggerClientEvent("mafije:UpdateMafije", -1, Mafije)
					else
						xPlayer.showNotification("Nemate dovoljno novca u sefu!")
					end
				end)
			else
				xPlayer.showNotification("Vec imate avion!")
			end
			break
		end
	end
end)

RegisterNetEvent('mafije:NapraviRank')
AddEventHandler('mafije:NapraviRank', function(maf, id, ime, lab)
		local Postoji = 0
		for i=1, #Rankovi, 1 do
			if Rankovi[i] ~= nil and Rankovi[i].ID == id and Rankovi[i].Mafija == maf then
				Postoji = 1
			end
		end
		if Postoji == 0 then
			table.insert(Rankovi, {ID = id, Mafija = maf, Ime = ime})
			
			local Temp = {}
			for i=1, #Rankovi, 1 do
				if Rankovi[i] ~= nil and Rankovi[i].Mafija == maf then
					table.insert(Temp, {ID = Rankovi[i].ID, Ime = Rankovi[i].Ime})
				end
			end
			
			MySQL.Async.execute('UPDATE mafije SET Rankovi = @ran WHERE Ime = @im', {
				['@ran'] = json.encode(Temp),
				['@im'] = maf
			})
			MySQL.Async.execute('INSERT INTO job_grades (job_name, grade, name, label, salary, skin_male, skin_female) VALUES (@ime, @gr, @nam, @lab, @sal, @skm, @skf)',{
				['@ime'] = maf,
				['@gr'] = id,
				['@nam'] = ime,
				['@lab'] = lab,
				['@sal'] = 300,
				['@skm'] = '{}',
				['@skf'] = '{}'
			})
			
			TriggerEvent("RefreshPoslove")
			TriggerEvent("RefreshSociety")
			TriggerClientEvent("mafije:UpdateRankove", -1, Rankovi)
			TriggerClientEvent('esx:showNotification', source, 'Rank '..lab..'('..ime..') uspjesno kreiran za mafiju '..maf..'!')
		else
			for i=1, #Rankovi, 1 do
				if Rankovi[i] ~= nil and Rankovi[i].Mafija == maf and Rankovi[i].ID == id then
					Rankovi[i].Ime = ime
				end
			end
			
			local Temp = {}
			for i=1, #Rankovi, 1 do
				if Rankovi[i] ~= nil and Rankovi[i].Mafija == maf then
					table.insert(Temp, {ID = Rankovi[i].ID, Ime = Rankovi[i].Ime})
				end
			end
			MySQL.Async.execute('UPDATE mafije SET Rankovi = @ran WHERE Ime = @im', {
				['@ran'] = json.encode(Temp),
				['@im'] = maf
			})
			
			MySQL.Async.execute('UPDATE job_grades SET name = @nam, label = @lab WHERE grade = @idic AND job_name = @mafija', {
				['@nam'] = ime,
				['@lab'] = lab,
				['@idic'] = id,
				['@mafija'] = maf,
			})
			
			TriggerEvent("RefreshPoslove")
			TriggerEvent("RefreshSociety")
			TriggerClientEvent("mafije:UpdateRankove", -1, Rankovi)
			TriggerClientEvent('esx:showNotification', source, 'Rank '..lab..'('..ime..') uspjesno azuriran za mafiju '..maf..'!')
			
			local xPlayers 	= ESX.GetPlayers()

			for i=1, #xPlayers, 1 do
				local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
				if xPlayer.job.name == maf then
					SetTimeout(1000, function()
						xPlayer.setJob(xPlayer.job.name, xPlayer.job.grade)
					end)
				end
			end
		end
end)

ESX.RegisterServerCallback('mafije:DohvatiKamion', function(source, cb, netid)
	local naso = false
	for i=1, #Kamioni, 1 do
		if Kamioni[i] ~= nil then
			if Kamioni[i].NetID == netid then
				naso = true
				cb(Kamioni[i])
				table.remove(Kamioni, i)
				TriggerClientEvent("mafije:VratiKamione", -1, Kamioni)
				break
			end
		end
	end
	if not naso then
		cb(false)
	end
end)

ESX.RegisterServerCallback('mafije:MorelProdaja', function(source, cb, maf)
	local naso = false
	for i=1, #Skladiste, 1 do
		if Skladiste[i].Mafija == maf then
			if Skladiste[i].Kokain >= 300 then
				naso = true
				Skladiste[i].Kokain = Skladiste[i].Kokain-300
				MySQL.Async.execute('UPDATE mskladiste SET kokain = @kok WHERE ime = @maf',{
					['@kok'] = Skladiste[i].Kokain,
					['@maf'] = Skladiste[i].Mafija
				})
				TriggerClientEvent("mafije:UpdateSkladista", -1, Skladiste)
				cb(true)
			end
			break
		end
	end
	if not naso then
		cb(false)
	end
end)

ESX.RegisterServerCallback('mafije:MorelProdaja2', function(source, cb, maf)
	local naso = false
	for i=1, #Skladiste, 1 do
		if Skladiste[i].Mafija == maf then
			if Skladiste[i].Heroin >= 300 then
				naso = true
				Skladiste[i].Heroin = Skladiste[i].Heroin-300
				MySQL.Async.execute('UPDATE mskladiste SET heroin = @her WHERE ime = @maf',{
					['@her'] = Skladiste[i].Heroin,
					['@maf'] = Skladiste[i].Mafija
				})
				TriggerClientEvent("mafije:UpdateSkladista", -1, Skladiste)
				cb(true)
			end
			break
		end
	end
	if not naso then
		cb(false)
	end
end)

ESX.RegisterServerCallback('mafije:KupiSkladiste', function(source, cb, maf)
	local naso = false
	local societyAccount = nil
	local soc = "society_"..maf
	TriggerEvent('esx_addonaccount:getSharedAccount', soc, function(account)
		societyAccount = account
	end)
	if societyAccount.money >= 100000 then
		societyAccount.removeMoney(100000)
		societyAccount.save()
		for i=1, #Mafije, 1 do
			if Mafije[i].Ime == maf then
				if Mafije[i].Skladiste == 0 then
					naso = true
					Mafije[i].Skladiste = 1
					MySQL.Async.execute('UPDATE mafije SET Skladiste = 1 WHERE Ime = @maf',{
						['@maf'] = maf
					})
					TriggerClientEvent("mafije:UpdateMafije", -1, Mafije)
					TriggerClientEvent("mafije:UpdateSBlip", -1, maf)
					cb(true)
				end
				break
			end
		end
		if not naso then
			cb(false)
		end
	else
		cb(false)
	end
end)

ESX.RegisterServerCallback('mafije:KupiSkladiste2', function(source, cb, maf)
	local naso = false
	local societyAccount = nil
	local soc = "society_"..maf
	TriggerEvent('esx_addonaccount:getSharedAccount', soc, function(account)
		societyAccount = account
	end)
	if societyAccount.money >= 100000 then
		societyAccount.removeMoney(100000)
		societyAccount.save()
		for i=1, #Mafije, 1 do
			if Mafije[i].Ime == maf then
				if Mafije[i].Skladiste2 == 0 then
					naso = true
					Mafije[i].Skladiste2 = 1
					MySQL.Async.execute('UPDATE mafije SET Skladiste2 = 1 WHERE Ime = @maf',{
						['@maf'] = maf
					})
					TriggerClientEvent("mafije:UpdateMafije", -1, Mafije)
					TriggerClientEvent("mafije:UpdateS2Blip", -1, maf)
					cb(true)
				end
				break
			end
		end
		if not naso then
			cb(false)
		end
	else
		cb(false)
	end
end)

ESX.RegisterServerCallback('mafije:DohvatiMafije', function(source, cb)
	local vracaj = {maf = Mafije, kor = Koord, voz = Vozila, oruz = Oruzja, boj = Boje, rank = Rankovi, sklad = Skladiste}
	cb(vracaj)
end)

ESX.RegisterServerCallback('mafije:DohvatiMafijev2', function(source, cb)
	cb(Mafije)
end)

ESX.RegisterServerCallback('mafije:DohvatiMafijev3', function(source, cb)
	local vracaj = {maf = Mafije, boj = Boje}
	cb(vracaj)
end)

ESX.RegisterServerCallback('mafije:DohvatiKutiju', function(source, cb, maf)
	local naso = 0
	for i=1, #Kutije, 1 do
		if Kutije[i] ~= nil and Kutije[i].Mafija == maf then
			cb(Kutije[i])
			naso = 1
		end
	end
	if naso == 0 then
		cb(nil)
	end
end)

RegisterNetEvent('mafije:ResetirajOruzje')
AddEventHandler('mafije:ResetirajOruzje', function(maf)
	for i=1, #Kutije, 1 do
		if Kutije[i] ~= nil and Kutije[i].Mafija == maf then
			table.remove(Kutije, i)
		end
	end
	TriggerClientEvent("mafije:ResetOruzja", -1, maf)
end)

RegisterNetEvent('mafije:SpremiCoord')
AddEventHandler('mafije:SpremiCoord', function(ime, coord, br, head)
	local x,y,z = table.unpack(coord)
	z = z-1
	local cordara = {}
	table.insert(cordara, x)
	table.insert(cordara, y)
	table.insert(cordara, z)
	if br == 1 then
		MySQL.Async.execute('UPDATE mafije SET Oruzarnica = @cor WHERE Ime = @im', {
			['@cor'] = json.encode(cordara),
			['@im'] = ime
		})
		local Postoji = 0
		for i=1, #Koord, 1 do
			if Koord[i] ~= nil and Koord[i].Mafija == ime and Koord[i].Ime == "Oruzarnica" then
				Koord[i].Coord = cordara
				Postoji = 1
			end
		end
		if Postoji == 0 then
			table.insert(Koord, {Mafija = ime, Ime = "Oruzarnica", Coord = cordara})
		end
		TriggerClientEvent('esx:showNotification', source, 'Koordinate oruzarnice su uspjesno spremljene za mafiju '..ime..'!')
		TriggerClientEvent("mafije:UpdateKoord", -1, Koord)
	elseif br == 2 then
		MySQL.Async.execute('UPDATE mafije SET Lider = @cor WHERE Ime = @im', {
			['@cor'] = json.encode(cordara),
			['@im'] = ime
		})
		local Postoji = 0
		for i=1, #Koord, 1 do
			if Koord[i] ~= nil and Koord[i].Mafija == ime and Koord[i].Ime == "Lider" then
				Koord[i].Coord = cordara
				Postoji = 1
			end
		end
		if Postoji == 0 then
			table.insert(Koord, {Mafija = ime, Ime = "Lider", Coord = cordara})
		end
		TriggerClientEvent('esx:showNotification', source, 'Koordinate lider menua su uspjesno spremljene za mafiju '..ime..'!')
		TriggerClientEvent("mafije:UpdateKoord", -1, Koord)
	elseif br == 3 then
		MySQL.Async.execute('UPDATE mafije SET SpawnV = @cor WHERE Ime = @im', {
			['@cor'] = json.encode(cordara),
			['@im'] = ime
		})
		local Postoji = 0
		for i=1, #Koord, 1 do
			if Koord[i] ~= nil and Koord[i].Mafija == ime and Koord[i].Ime == "SpawnV" then
				Koord[i].Coord = cordara
				Postoji = 1
			end
		end
		if Postoji == 0 then
			table.insert(Koord, {Mafija = ime, Ime = "SpawnV", Coord = cordara})
		end
		TriggerClientEvent('esx:showNotification', source, 'Koordinate spawna vozila(marker) su uspjesno spremljene za mafiju '..ime..'!')
		TriggerClientEvent("mafije:KreirajBlip", -1, cordara, ime, 1)
		TriggerClientEvent("mafije:UpdateKoord", -1, Koord)
	elseif br == 4 then
		MySQL.Async.execute('UPDATE mafije SET DeleteV = @cor WHERE Ime = @im', {
			['@cor'] = json.encode(cordara),
			['@im'] = ime
		})
		local Postoji = 0
		for i=1, #Koord, 1 do
			if Koord[i] ~= nil and Koord[i].Mafija == ime and Koord[i].Ime == "DeleteV" then
				Koord[i].Coord = cordara
				Postoji = 1
			end
		end
		if Postoji == 0 then
			table.insert(Koord, {Mafija = ime, Ime = "DeleteV", Coord = cordara})
		end
		TriggerClientEvent('esx:showNotification', source, 'Koordinate brisanja vozila su uspjesno spremljene za mafiju '..ime..'!')
		TriggerClientEvent("mafije:UpdateKoord", -1, Koord)
	elseif br == 5 then
		local cordare = {}
		table.insert(cordare, x)
		table.insert(cordare, y)
		table.insert(cordare, z)
		table.insert(cordare, head)
		MySQL.Async.execute('UPDATE mafije SET LokVozila = @cor WHERE Ime = @im', {
			['@cor'] = json.encode(cordare),
			['@im'] = ime
		})
		local Postoji = 0
		for i=1, #Koord, 1 do
			if Koord[i] ~= nil and Koord[i].Mafija == ime and Koord[i].Ime == "LokVozila" then
				Koord[i].Coord = cordare
				Postoji = 1
			end
		end
		if Postoji == 0 then
			table.insert(Koord, {Mafija = ime, Ime = "LokVozila", Coord = cordare})
		end
		TriggerClientEvent('esx:showNotification', source, 'Koordinate spawna vozila su uspjesno spremljene za mafiju '..ime..'!')
		TriggerClientEvent("mafije:UpdateKoord", -1, Koord)
	elseif br == 6 then
		MySQL.Async.execute('UPDATE mafije SET CrateDrop = @cor WHERE Ime = @im', {
			['@cor'] = json.encode(cordara),
			['@im'] = ime
		})
		local Postoji = 0
		for i=1, #Koord, 1 do
			if Koord[i] ~= nil and Koord[i].Mafija == ime and Koord[i].Ime == "CrateDrop" then
				Koord[i].Coord = cordara
				Postoji = 1
			end
		end
		if Postoji == 0 then
			table.insert(Koord, {Mafija = ime, Ime = "CrateDrop", Coord = cordara})
		end
		TriggerClientEvent('esx:showNotification', source, 'Koordinate crate dropa su uspjesno spremljene za mafiju '..ime..'!')
		TriggerClientEvent("mafije:UpdateKoord", -1, Koord)
	elseif br == 7 then
		MySQL.Async.execute('UPDATE mafije SET Ulaz = @cor WHERE Ime = @im', {
			['@cor'] = json.encode(cordara),
			['@im'] = ime
		})
		local Postoji = 0
		for i=1, #Koord, 1 do
			if Koord[i] ~= nil and Koord[i].Mafija == ime and Koord[i].Ime == "Ulaz" then
				Koord[i].Coord = cordara
				Postoji = 1
			end
		end
		if Postoji == 0 then
			table.insert(Koord, {Mafija = ime, Ime = "Ulaz", Coord = cordara})
		end
		TriggerClientEvent('esx:showNotification', source, 'Koordinate ulaza u kucu su uspjesno spremljene za mafiju '..ime..'!')
		TriggerClientEvent("mafije:UpdateKoord", -1, Koord)
	elseif br == 8 then
		MySQL.Async.execute('UPDATE mafije SET Izlaz = @cor WHERE Ime = @im', {
			['@cor'] = json.encode(cordara),
			['@im'] = ime
		})
		local Postoji = 0
		for i=1, #Koord, 1 do
			if Koord[i] ~= nil and Koord[i].Mafija == ime and Koord[i].Ime == "Izlaz" then
				Koord[i].Coord = cordara
				Postoji = 1
			end
		end
		if Postoji == 0 then
			table.insert(Koord, {Mafija = ime, Ime = "Izlaz", Coord = cordara})
		end
		TriggerClientEvent('esx:showNotification', source, 'Koordinate izlaza iz kuce su uspjesno spremljene za mafiju '..ime..'!')
		TriggerClientEvent("mafije:UpdateKoord", -1, Koord)
	elseif br == 9 then
		local cordare = {}
		table.insert(cordare, x)
		table.insert(cordare, y)
		table.insert(cordare, z)
		table.insert(cordare, head)
		MySQL.Async.execute('UPDATE mafije SET LokVozila2 = @cor WHERE Ime = @im', {
			['@cor'] = json.encode(cordare),
			['@im'] = ime
		})
		local Postoji = 0
		for i=1, #Koord, 1 do
			if Koord[i] ~= nil and Koord[i].Mafija == ime and Koord[i].Ime == "LokVozila2" then
				Koord[i].Coord = cordare
				Postoji = 1
			end
		end
		if Postoji == 0 then
			table.insert(Koord, {Mafija = ime, Ime = "LokVozila2", Coord = cordare})
		end
		TriggerClientEvent('esx:showNotification', source, 'Koordinate spawna plovila su uspjesno spremljene za mafiju '..ime..'!')
		TriggerClientEvent("mafije:UpdateKoord", -1, Koord)
	elseif br == 10 then
		MySQL.Async.execute('UPDATE mafije SET DeleteV2 = @cor WHERE Ime = @im', {
			['@cor'] = json.encode(cordara),
			['@im'] = ime
		})
		local Postoji = 0
		for i=1, #Koord, 1 do
			if Koord[i] ~= nil and Koord[i].Mafija == ime and Koord[i].Ime == "DeleteV2" then
				Koord[i].Coord = cordara
				Postoji = 1
			end
		end
		if Postoji == 0 then
			table.insert(Koord, {Mafija = ime, Ime = "DeleteV2", Coord = cordara})
		end
		TriggerClientEvent('esx:showNotification', source, 'Koordinate brisanja plovila su uspjesno spremljene za mafiju '..ime..'!')
		TriggerClientEvent("mafije:UpdateKoord", -1, Koord)
	elseif br == 11 then
		MySQL.Async.execute('UPDATE mafije SET Kokain = @cor WHERE Ime = @im', {
			['@cor'] = json.encode(cordara),
			['@im'] = ime
		})
		local Postoji = 0
		for i=1, #Koord, 1 do
			if Koord[i] ~= nil and Koord[i].Mafija == ime and Koord[i].Ime == "Kokain" then
				Koord[i].Coord = cordara
				Postoji = 1
			end
		end
		if Postoji == 0 then
			table.insert(Koord, {Mafija = ime, Ime = "Kokain", Coord = cordara})
		end
		TriggerClientEvent('esx:showNotification', source, 'Koordinate labosa za kokain su uspjesno spremljene za mafiju '..ime..'!')
		TriggerClientEvent("mafije:UpdateKoord", -1, Koord)
		TriggerClientEvent("mafije:KreirajBlip", -1, cordara, ime, 2)
	elseif br == 12 then
		local cordare = {}
		table.insert(cordare, x)
		table.insert(cordare, y)
		table.insert(cordare, z)
		table.insert(cordare, head)
		MySQL.Async.execute('UPDATE mafije SET KamionK = @cor WHERE Ime = @im', {
			['@cor'] = json.encode(cordare),
			['@im'] = ime
		})
		local Postoji = 0
		for i=1, #Koord, 1 do
			if Koord[i] ~= nil and Koord[i].Mafija == ime and Koord[i].Ime == "KamionK" then
				Koord[i].Coord = cordare
				Postoji = 1
			end
		end
		if Postoji == 0 then
			table.insert(Koord, {Mafija = ime, Ime = "KamionK", Coord = cordare})
		end
		TriggerClientEvent('esx:showNotification', source, 'Koordinate spawna kamiona za kokain su uspjesno spremljene za mafiju '..ime..'!')
		TriggerClientEvent("mafije:UpdateKoord", -1, Koord)
	elseif br == 13 then
		MySQL.Async.execute('UPDATE mafije SET KPosao = @cor WHERE Ime = @im', {
			['@cor'] = json.encode(cordara),
			['@im'] = ime
		})
		local Postoji = 0
		for i=1, #Koord, 1 do
			if Koord[i] ~= nil and Koord[i].Mafija == ime and Koord[i].Ime == "Posao" then
				Koord[i].Coord = cordara
				Postoji = 1
			end
		end
		if Postoji == 0 then
			table.insert(Koord, {Mafija = ime, Ime = "Posao", Coord = cordara})
		end
		TriggerClientEvent('esx:showNotification', source, 'Koordinate uzimanja legalnog posla za mafiju '..ime..' su spremljene!')
		TriggerClientEvent("mafije:UpdateKoord", -1, Koord)
		TriggerClientEvent("mafije:KreirajBlip", -1, cordara, ime, 3)
	elseif br == 14 then
		local cordare = {}
		table.insert(cordare, x)
		table.insert(cordare, y)
		table.insert(cordare, z)
		table.insert(cordare, head)
		MySQL.Async.execute('UPDATE mafije SET PosaoSpawn = @cor WHERE Ime = @im', {
			['@cor'] = json.encode(cordare),
			['@im'] = ime
		})
		local Postoji = 0
		for i=1, #Koord, 1 do
			if Koord[i] ~= nil and Koord[i].Mafija == ime and Koord[i].Ime == "PosaoSpawn" then
				Koord[i].Coord = cordare
				Postoji = 1
			end
		end
		if Postoji == 0 then
			table.insert(Koord, {Mafija = ime, Ime = "PosaoSpawn", Coord = cordare})
		end
		TriggerClientEvent('esx:showNotification', source, 'Koordinate spawna kamiona za legalni posao su uspjesno spremljene za mafiju '..ime..'!')
		TriggerClientEvent("mafije:UpdateKoord", -1, Koord)
	elseif br == 15 then
		MySQL.Async.execute('UPDATE mafije SET Heroin = @cor WHERE Ime = @im', {
			['@cor'] = json.encode(cordara),
			['@im'] = ime
		})
		local Postoji = 0
		for i=1, #Koord, 1 do
			if Koord[i] ~= nil and Koord[i].Mafija == ime and Koord[i].Ime == "Heroin" then
				Koord[i].Coord = cordara
				Postoji = 1
			end
		end
		if Postoji == 0 then
			table.insert(Koord, {Mafija = ime, Ime = "Heroin", Coord = cordara})
		end
		TriggerClientEvent('esx:showNotification', source, 'Koordinate labosa za heroin su uspjesno spremljene za mafiju '..ime..'!')
		TriggerClientEvent("mafije:UpdateKoord", -1, Koord)
		TriggerClientEvent("mafije:KreirajBlip", -1, cordara, ime, 4)
	elseif br == 16 then
		local cordare = {}
		table.insert(cordare, x)
		table.insert(cordare, y)
		table.insert(cordare, z)
		table.insert(cordare, head)
		MySQL.Async.execute('UPDATE mafije SET KamionH = @cor WHERE Ime = @im', {
			['@cor'] = json.encode(cordare),
			['@im'] = ime
		})
		local Postoji = 0
		for i=1, #Koord, 1 do
			if Koord[i] ~= nil and Koord[i].Mafija == ime and Koord[i].Ime == "KamionH" then
				Koord[i].Coord = cordare
				Postoji = 1
			end
		end
		if Postoji == 0 then
			table.insert(Koord, {Mafija = ime, Ime = "KamionH", Coord = cordare})
		end
		TriggerClientEvent('esx:showNotification', source, 'Koordinate spawna kamiona za heroin su uspjesno spremljene za mafiju '..ime..'!')
		TriggerClientEvent("mafije:UpdateKoord", -1, Koord)
	end
end)

RegisterServerEvent('mafije:PlatiDostavu')
AddEventHandler('mafije:PlatiDostavu', function(id, maf)
	local sourceXPlayer = ESX.GetPlayerFromId(source)
	local soc = "society_"..maf
	TriggerEvent('esx_addonaccount:getSharedAccount', soc, function(account)
		if id == 1 then
			account.addMoney(700)
			account.save()
			sourceXPlayer.addMoney(350)
			ESX.SavePlayer(sourceXPlayer, function() 
			end)
		elseif id == 2 then
			account.addMoney(1500)
			account.save()
			sourceXPlayer.addMoney(750)
			ESX.SavePlayer(sourceXPlayer, function() 
			end)
		end
	end)
end)

RegisterNetEvent('mafije:SpremiPostavke')
AddEventHandler('mafije:SpremiPostavke', function(ime, br)
	if br == 1 then
		for i=1, #Mafije, 1 do
			if Mafije[i] ~= nil and Mafije[i].Ime == ime then
				if Mafije[i].Posao == 0 then
					Mafije[i].Posao = 1
					TriggerClientEvent('esx:showNotification', source, 'Omogucili ste legalan posao za mafiju '..ime..'!')
				else
					Mafije[i].Posao = 0
					TriggerClientEvent('esx:showNotification', source, 'Onemogucili ste legalan posao za mafiju '..ime..'!')
				end
				MySQL.Async.execute('UPDATE mafije SET Posao = @br, KPosao = "{}", PosaoSpawn = "{}" WHERE Ime = @im', {
					['@br'] = Mafije[i].Posao,
					['@im'] = ime
				})
				for i=1, #Koord, 1 do
					if Koord[i] ~= nil and Koord[i].Mafija == ime and Koord[i].Ime == "Posao" then
						table.remove(Koord, i)
					end
					if Koord[i] ~= nil and Koord[i].Mafija == ime and Koord[i].Ime == "PosaoSpawn" then
						table.remove(Koord, i)
					end
				end
				TriggerClientEvent("mafije:UpdateMafije", -1, Mafije)
				TriggerClientEvent("mafije:UpdateKoord", -1, Koord)
				TriggerClientEvent("mafije:KreirajBlip", -1, {x = 0, y = 0, z = 0}, ime, 3)
				break
			end
		end
	end
end)

local ZVrijeme = {}

RegisterServerEvent('mafije:zapljeni6')
AddEventHandler('mafije:zapljeni6', function(target, itemType, itemName, amount, torba, imalweap)
	if ZVrijeme ~= nil and ZVrijeme[target] ~= nil then
		if GetGameTimer()-ZVrijeme[target] > 200 then
			local sourceXPlayer = ESX.GetPlayerFromId(source)
			local targetXPlayer = ESX.GetPlayerFromId(target)

			if itemType == 'item_standard' then

				local label = sourceXPlayer.getInventoryItem(itemName).label
				local xItem = sourceXPlayer.getInventoryItem(itemName)
				local xItem2 = targetXPlayer.getInventoryItem(itemName)
			
				if torba then
					if xItem.limit ~= -1 and (xItem.count + amount) > xItem.limit*2 then
						TriggerClientEvent('esx:showNotification', sourceXPlayer.source, "Ne stane vam vise "..label.." u inventory!")
					else
						if targetXPlayer ~= nil then
							if xItem2.count >= amount then
								targetXPlayer.removeInventoryItem(itemName, amount)
								sourceXPlayer.addInventoryItem(itemName, amount)
								local por = "["..os.date("%X").."] ("..GetCurrentResourceName()..") Igrac "..GetPlayerName(source).."("..sourceXPlayer.identifier..") je dobio item "..itemName.." x "..amount
								TriggerEvent("SpremiLog", por)
								TriggerEvent("DiscordBot:Oduzimanje", sourceXPlayer.name.."["..sourceXPlayer.source.."] je oduzeo "..amount.." "..itemName.." od igraca "..targetXPlayer.name.."["..targetXPlayer.source.."]")
								TriggerClientEvent('esx:showNotification', sourceXPlayer.source, "Oduzeli ste ~y~x" .. amount .. ' ' .. label .."~s~ od ~b~" .. targetXPlayer.name)
								TriggerClientEvent('esx:showNotification', targetXPlayer.source, '~b~' .. sourceXPlayer.name .. "~s~ je oduzeo od vas ~y~x" .. amount .. ' ' .. label )
							end
						end
					end
				else
					if xItem.limit ~= -1 and (xItem.count + amount) > xItem.limit then
						TriggerClientEvent('esx:showNotification', sourceXPlayer.source, "Ne stane vam vise "..label.." u inventory!")
					else
						if targetXPlayer ~= nil then
							if xItem2.count >= amount then
								targetXPlayer.removeInventoryItem(itemName, amount)
								sourceXPlayer.addInventoryItem(itemName, amount)
								local por = "["..os.date("%X").."] ("..GetCurrentResourceName()..") Igrac "..GetPlayerName(source).."("..sourceXPlayer.identifier..") je dobio item "..itemName.." x "..amount
								TriggerEvent("SpremiLog", por)
								TriggerEvent("DiscordBot:Oduzimanje", sourceXPlayer.name.."["..sourceXPlayer.source.."] je oduzeo "..amount.." "..itemName.." od igraca "..targetXPlayer.name.."["..targetXPlayer.source.."]")
								TriggerClientEvent('esx:showNotification', sourceXPlayer.source, "Oduzeli ste ~y~x" .. amount .. ' ' .. label .."~s~ od ~b~" .. targetXPlayer.name)
								TriggerClientEvent('esx:showNotification', targetXPlayer.source, '~b~' .. sourceXPlayer.name .. "~s~ je oduzeo od vas ~y~x" .. amount .. ' ' .. label )
							end
						end
					end
				end
			end

		  if itemType == 'item_account' then
			if targetXPlayer.getMoney() >= amount then
				targetXPlayer.removeMoney(amount)
				sourceXPlayer.addMoney(amount)
				TriggerEvent("DiscordBot:Oduzimanje", sourceXPlayer.name.."["..sourceXPlayer.source.."] je oduzeo $"..amount.." od igraca "..targetXPlayer.name.."["..targetXPlayer.source.."]")
				TriggerClientEvent('esx:showNotification', sourceXPlayer.source, "Oduzeli ste ~y~$" .. amount .. "~s~ od ~b~" .. targetXPlayer.name)
				TriggerClientEvent('esx:showNotification', targetXPlayer.source, '~b~' .. sourceXPlayer.name .. "~s~ je oduzeo od vas ~y~$" .. amount)
			end
		  end

		  if itemType == 'item_weapon' then
			if targetXPlayer.hasWeapon(itemName) then
				targetXPlayer.removeWeapon(itemName)
				if imalweap then
					local sourceItem = sourceXPlayer.getInventoryItem(string.lower(itemName))
					if not torba then
						if sourceItem.limit ~= -1 and (sourceItem.count + 1) <= sourceItem.limit then
							sourceXPlayer.addInventoryItem(string.lower(itemName), 1)
						else
							xPlayer.showNotification("Ne stane vam vise u inventory!")
						end
					else
						if sourceItem.limit ~= -1 and (sourceItem.count + 1) <= sourceItem.limit*2 then
							sourceXPlayer.addInventoryItem(string.lower(itemName), 1)
						else
							xPlayer.showNotification("Ne stane vam vise u inventory!")
						end
					end
				else
					sourceXPlayer.addWeapon(itemName, amount)
				end
				TriggerEvent("DiscordBot:Oduzimanje", sourceXPlayer.name.."["..sourceXPlayer.source.."] je oduzeo oruzje "..itemName.." sa "..amount.." metaka od igraca "..targetXPlayer.name.."["..targetXPlayer.source.."]")
				TriggerClientEvent('esx:showNotification', sourceXPlayer.source, "Oduzeli ste ~y~x1" .. ESX.GetWeaponLabel(itemName) .. "~s~ od ~b~" .. targetXPlayer.name)
				TriggerClientEvent('esx:showNotification', targetXPlayer.source, '~b~' .. sourceXPlayer.name .. "~s~ je oduzeo od vas ~y~x1 " .. ESX.GetWeaponLabel(itemName))
			end
		  end
		  ZVrijeme[target] = GetGameTimer()
		end
	else
			local sourceXPlayer = ESX.GetPlayerFromId(source)
			local targetXPlayer = ESX.GetPlayerFromId(target)

			if itemType == 'item_standard' then

				local label = sourceXPlayer.getInventoryItem(itemName).label
				local xItem = sourceXPlayer.getInventoryItem(itemName)
				local xItem2 = targetXPlayer.getInventoryItem(itemName)
			
				if torba then
					if xItem.limit ~= -1 and (xItem.count + amount) > xItem.limit*2 then
						TriggerClientEvent('esx:showNotification', sourceXPlayer.source, "Ne stane vam vise "..label.." u inventory!")
					else
						if targetXPlayer ~= nil then
							if xItem2.count >= amount then
								targetXPlayer.removeInventoryItem(itemName, amount)
								sourceXPlayer.addInventoryItem(itemName, amount)
								local por = "["..os.date("%X").."] ("..GetCurrentResourceName()..") Igrac "..GetPlayerName(source).."("..sourceXPlayer.identifier..") je dobio item "..itemName.." x "..amount
								TriggerEvent("SpremiLog", por)
								TriggerEvent("DiscordBot:Oduzimanje", sourceXPlayer.name.."["..sourceXPlayer.source.."] je oduzeo "..amount.."x"..itemName.." od igraca "..targetXPlayer.name.."["..targetXPlayer.source.."]")
								TriggerClientEvent('esx:showNotification', sourceXPlayer.source, "Oduzeli ste ~y~x" .. amount .. ' ' .. label .."~s~ od ~b~" .. targetXPlayer.name)
								TriggerClientEvent('esx:showNotification', targetXPlayer.source, '~b~' .. sourceXPlayer.name .. "~s~ je oduzeo od vas ~y~x" .. amount .. ' ' .. label )
							end
						end
					end
				else
					if xItem.limit ~= -1 and (xItem.count + amount) > xItem.limit then
						TriggerClientEvent('esx:showNotification', sourceXPlayer.source, "Ne stane vam vise "..label.." u inventory!")
					else
						if targetXPlayer ~= nil then
							if xItem2.count >= amount then
								targetXPlayer.removeInventoryItem(itemName, amount)
								sourceXPlayer.addInventoryItem(itemName, amount)
								local por = "["..os.date("%X").."] ("..GetCurrentResourceName()..") Igrac "..GetPlayerName(source).."("..sourceXPlayer.identifier..") je dobio item "..itemName.." x "..amount
								TriggerEvent("SpremiLog", por)
								TriggerEvent("DiscordBot:Oduzimanje", sourceXPlayer.name.."["..sourceXPlayer.source.."] je oduzeo "..amount.." "..itemName.." od igraca "..targetXPlayer.name.."["..targetXPlayer.source.."]")
								TriggerClientEvent('esx:showNotification', sourceXPlayer.source, "Oduzeli ste ~y~x" .. amount .. ' ' .. label .."~s~ od ~b~" .. targetXPlayer.name)
								TriggerClientEvent('esx:showNotification', targetXPlayer.source, '~b~' .. sourceXPlayer.name .. "~s~ je oduzeo od vas ~y~x" .. amount .. ' ' .. label )
							end
						end
					end
				end
			end

		  if itemType == 'item_account' then
			if targetXPlayer.getMoney() >= amount then
				targetXPlayer.removeMoney(amount)
				sourceXPlayer.addMoney(amount)
				TriggerEvent("DiscordBot:Oduzimanje", sourceXPlayer.name.."["..sourceXPlayer.source.."] je oduzeo $"..amount.." od igraca "..targetXPlayer.name.."["..targetXPlayer.source.."]")
				TriggerClientEvent('esx:showNotification', sourceXPlayer.source, "Oduzeli ste ~y~$" .. amount .. "~s~ od ~b~" .. targetXPlayer.name)
				TriggerClientEvent('esx:showNotification', targetXPlayer.source, '~b~' .. sourceXPlayer.name .. "~s~ je oduzeo od vas ~y~$" .. amount)
			end
		  end

		  if itemType == 'item_weapon' then
			if targetXPlayer.hasWeapon(itemName) then
				targetXPlayer.removeWeapon(itemName)
				if imalweap then
					local sourceItem = sourceXPlayer.getInventoryItem(string.lower(itemName))
					if not torba then
						if sourceItem.limit ~= -1 and (sourceItem.count + 1) <= sourceItem.limit then
							sourceXPlayer.addInventoryItem(string.lower(itemName), 1)
						else
							xPlayer.showNotification("Ne stane vam vise u inventory!")
						end
					else
						if sourceItem.limit ~= -1 and (sourceItem.count + 1) <= sourceItem.limit*2 then
							sourceXPlayer.addInventoryItem(string.lower(itemName), 1)
						else
							xPlayer.showNotification("Ne stane vam vise u inventory!")
						end
					end
				else
					sourceXPlayer.addWeapon(itemName, amount)
				end
				TriggerEvent("DiscordBot:Oduzimanje", sourceXPlayer.name.."["..sourceXPlayer.source.."] je oduzeo oruzje "..itemName.." sa "..amount.." metaka od igraca "..targetXPlayer.name.."["..targetXPlayer.source.."]")
				TriggerClientEvent('esx:showNotification', sourceXPlayer.source, "Oduzeli ste ~y~x1" .. ESX.GetWeaponLabel(itemName) .. "~s~ od ~b~" .. targetXPlayer.name)
				TriggerClientEvent('esx:showNotification', targetXPlayer.source, '~b~' .. sourceXPlayer.name .. "~s~ je oduzeo od vas ~y~x1 " .. ESX.GetWeaponLabel(itemName))
			end
		  end
		  ZVrijeme[target] = GetGameTimer()
	end
end)

RegisterNetEvent('mafije:SpawnVozilo')
AddEventHandler('mafije:SpawnVozilo', function(vehicle, co, he)
	local _source = source
	local veh = CreateVehicle(vehicle.model, co, he, true, false)
	while not DoesEntityExist(veh) do
		Wait(100)
	end
	local netid = NetworkGetNetworkIdFromEntity(veh)
	Wait(500)
	TriggerClientEvent("mafije:VratiVozilo", _source, netid, vehicle, co)
end)

RegisterServerEvent('mafije:handcuff')
AddEventHandler('mafije:handcuff', function(target)
  TriggerClientEvent('mafije:handcuff', target)
end)

RegisterServerEvent('mafije:drag')
AddEventHandler('mafije:drag', function(target)
  local _source = source
  TriggerClientEvent('mafije:drag', target, _source)
end)

RegisterServerEvent('mafije:putInVehicle')
AddEventHandler('mafije:putInVehicle', function(target)
  TriggerClientEvent('mafije:putInVehicle', target)
end)

RegisterServerEvent('mafije:OutVehicle')
AddEventHandler('mafije:OutVehicle', function(target)
    TriggerClientEvent('mafije:OutVehicle', target)
end)

RegisterServerEvent('mafije:getStockItem')
AddEventHandler('mafije:getStockItem', function(itemName, count, maf, torba)
  local soc = maf
  local xPlayer = ESX.GetPlayerFromId(source)
  local sourceItem = xPlayer.getInventoryItem(itemName)

  TriggerEvent('esx_addoninventory:getSharedInventory', soc, function(inventory)

    local item = inventory.getItem(itemName)

    if item.count >= count then
		if torba then
			if sourceItem.limit ~= -1 and (sourceItem.count + count) <= sourceItem.limit*2 then
				inventory.removeItem(itemName, count)
				xPlayer.addInventoryItem(itemName, count)
				local por = "["..os.date("%X").."] ("..GetCurrentResourceName()..") Igrac "..GetPlayerName(source).."("..xPlayer.identifier..") je dobio item "..itemName.." x "..count
				TriggerEvent("SpremiLog", por)
				TriggerClientEvent('esx:showNotification', xPlayer.source, "Uzeli ste x" .. count .. ' ' .. item.label)
			else
				if sourceItem.limit == -1 then
					inventory.removeItem(itemName, count)
					xPlayer.addInventoryItem(itemName, count)
					local por = "["..os.date("%X").."] ("..GetCurrentResourceName()..") Igrac "..GetPlayerName(source).."("..xPlayer.identifier..") je dobio item "..itemName.." x "..count
					TriggerEvent("SpremiLog", por)
					TriggerClientEvent('esx:showNotification', xPlayer.source, "Uzeli ste x" .. count .. ' ' .. item.label)
				else
					TriggerClientEvent('esx:showNotification', xPlayer.source, "Ne stane vam vise u inventory!")
				end
			end
		else
			if sourceItem.limit ~= -1 and (sourceItem.count + count) <= sourceItem.limit then
				inventory.removeItem(itemName, count)
				xPlayer.addInventoryItem(itemName, count)
				local por = "["..os.date("%X").."] ("..GetCurrentResourceName()..") Igrac "..GetPlayerName(source).."("..xPlayer.identifier..") je dobio item "..itemName.." x "..count
				TriggerEvent("SpremiLog", por)
				TriggerClientEvent('esx:showNotification', xPlayer.source, "Uzeli ste x" .. count .. ' ' .. item.label)
			else
				if sourceItem.limit == -1 then
					inventory.removeItem(itemName, count)
					xPlayer.addInventoryItem(itemName, count)
					local por = "["..os.date("%X").."] ("..GetCurrentResourceName()..") Igrac "..GetPlayerName(source).."("..xPlayer.identifier..") je dobio item "..itemName.." x "..count
					TriggerEvent("SpremiLog", por)
					TriggerClientEvent('esx:showNotification', xPlayer.source, "Uzeli ste x" .. count .. ' ' .. item.label)
				else
					TriggerClientEvent('esx:showNotification', xPlayer.source, "Ne stane vam vise u inventory!")
				end
			end
		end
    else
		TriggerClientEvent('esx:showNotification', xPlayer.source, "Krivi iznos")
    end

  end)

end)

RegisterServerEvent('mafije:SaljiCrate')
AddEventHandler('mafije:SaljiCrate', function(par, job)
    TriggerClientEvent('mafije:VratiCrate', -1, par, job)
end)

RegisterServerEvent('mafije:BrisiCrate')
AddEventHandler('mafije:BrisiCrate', function(id, job)
	for i=1, #Kutije, 1 do
		if Kutije[i] ~= nil and Kutije[i].Mafija == job then
			Kutije[i].Pokupljen = true
		end
	end
    TriggerClientEvent('mafije:ObrisiCrate', -1, id, job)
end)

RegisterServerEvent('mafije:SpremiNetID')
AddEventHandler('mafije:SpremiNetID', function(id, job)
	for i=1, #Kutije, 1 do
		if Kutije[i] ~= nil and Kutije[i].Mafija == job then
			Kutije[i].NetID = id
		end
	end
end)

RegisterServerEvent('mafije:SpremiIme')
AddEventHandler('mafije:SpremiIme', function(maf, ime, br)
	local naso = 0
	for i=1, #Kutije, 1 do
		if Kutije[i] ~= nil and Kutije[i].Mafija == maf then
			Kutije[i].Oruzja = ime
			Kutije[i].Broj = br
			naso = 1
		end
	end
	if naso == 0 then
		table.insert(Kutije, {Mafija = maf, Oruzja = ime, Broj = br, Pokupljen = false, NetID = nil})
	end
    TriggerClientEvent('mafije:VratiIme', -1, maf, ime, br)
end)

RegisterServerEvent('mafije:makniOruzjeItem')
AddEventHandler('mafije:makniOruzjeItem', function(itemName, count)
  local xPlayer = ESX.GetPlayerFromId(source)
  xPlayer.removeInventoryItem(itemName, count)
end)

RegisterServerEvent('mafije:putStockItems')
AddEventHandler('mafije:putStockItems', function(itemName, count, maf)
	local soc = maf
	local kol = count
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer ~= nil then
		local sourceItem = xPlayer.getInventoryItem(itemName)
		TriggerEvent('esx_addoninventory:getSharedInventory', soc, function(inventory)
			local item = inventory.getItem(itemName)
			if sourceItem.count >= kol and kol > 0 then
			xPlayer.removeInventoryItem(itemName, kol)
			inventory.addItem(itemName, kol)
			TriggerClientEvent('esx:showNotification', xPlayer.source, "Dodali ste x" .. kol .. ' ' .. item.label)
			else
			TriggerClientEvent('esx:showNotification', xPlayer.source, "Krivi iznos")
			end
	  	end)
  	else
		TriggerClientEvent('esx:showNotification', source, "Greska! Pokusajte ponovno ili odite relog!")
  	end
end)

ESX.RegisterServerCallback('mafije:getOtherPlayerData', function(source, cb, target)

  if EnableESXIdentity then

    local xPlayer = ESX.GetPlayerFromId(target)

    local identifier = GetPlayerIdentifiers(target)[1]

    local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {
      ['@identifier'] = identifier
    })

    local user      = result[1]
    local firstname     = user['firstname']
    local lastname      = user['lastname']
    local sex           = user['sex']
    local dob           = user['dateofbirth']
    local height        = user['height'] .. " Inches"

    local data = {
      name        = GetPlayerName(target),
      job         = xPlayer.job,
      inventory   = xPlayer.inventory,
      novac       = xPlayer.getMoney(),
      weapons     = xPlayer.loadout,
      firstname   = firstname,
      lastname    = lastname,
      sex         = sex,
      dob         = dob,
      height      = height
    }

    TriggerEvent('esx_status:getStatus', source, 'drunk', function(status)

      if status ~= nil then
        data.drunk = math.floor(status.percent)
      end

    end)

    if EnableLicenses then

      TriggerEvent('esx_license:getLicenses', source, function(licenses)
        data.licenses = licenses
        cb(data)
      end)

    else
      cb(data)
    end

  else

    local xPlayer = ESX.GetPlayerFromId(target)

    local data = {
      name       = GetPlayerName(target),
      job        = xPlayer.job,
      inventory  = xPlayer.inventory,
      accounts   = xPlayer.accounts,
      weapons    = xPlayer.loadout
    }

    TriggerEvent('esx_status:getStatus', target, 'drunk', function(status)

      if status ~= nil then
        data.drunk = math.floor(status.percent)
      end

    end)

    TriggerEvent('esx_license:getLicenses', target, function(licenses)
      data.licenses = licenses
    end)

    cb(data)

  end

end)

ESX.RegisterServerCallback('mafije:getFineList', function(source, cb, category)

  MySQL.Async.fetchAll(
    'SELECT * FROM fine_types_mafia WHERE category = @category',
    {
      ['@category'] = category
    },
    function(fines)
      cb(fines)
    end
  )

end)

ESX.RegisterServerCallback('mafije:getVehicleInfos', function(source, cb, plate)

  if EnableESXIdentity then

    MySQL.Async.fetchAll(
      'SELECT * FROM owned_vehicles',
      {},
      function(result)

        local foundIdentifier = nil

        for i=1, #result, 1 do

          local vehicleData = json.decode(result[i].vehicle)

          if vehicleData.plate == plate then
            foundIdentifier = result[i].owner
            break
          end

        end

        if foundIdentifier ~= nil then

          MySQL.Async.fetchAll(
            'SELECT * FROM users WHERE ID = @identifier',
            {
              ['@identifier'] = foundIdentifier
            },
            function(result)

              local ownerName = result[1].firstname .. " " .. result[1].lastname

              local infos = {
                plate = plate,
                owner = ownerName
              }

              cb(infos)

            end
          )

        else

          local infos = {
          plate = plate
          }

          cb(infos)

        end

      end
    )

  else

    MySQL.Async.fetchAll(
      'SELECT * FROM owned_vehicles',
      {},
      function(result)

        local foundIdentifier = nil

        for i=1, #result, 1 do

          local vehicleData = json.decode(result[i].vehicle)

          if vehicleData.plate == plate then
            foundIdentifier = result[i].owner
            break
          end

        end

        if foundIdentifier ~= nil then

          MySQL.Async.fetchAll(
            'SELECT * FROM users WHERE ID = @identifier',
            {
              ['@identifier'] = foundIdentifier
            },
            function(result)

              local infos = {
                plate = plate,
                owner = result[1].name
              }

              cb(infos)

            end
          )

        else

          local infos = {
          plate = plate
          }

          cb(infos)

        end

      end
    )

  end

end)

ESX.RegisterServerCallback('mafije:getArmoryWeapons', function(source, cb, mafija)
  local soc = "society_"..mafija
  TriggerEvent('esx_datastore:getSharedDataStore', soc, function(store)
    local weapons = store.get('weapons')

    if weapons == nil then
      weapons = {}
    end

    cb(weapons)

  end)

end)

ESX.RegisterServerCallback('mafije:addArmoryWeapon', function(source, cb, weaponName, am, maf)
  local soc = "society_"..maf
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)
  if xPlayer ~= nil then
	  xPlayer.removeWeapon(weaponName)

	  TriggerEvent('esx_datastore:getSharedDataStore', soc, function(store)

		local weapons = store.get('weapons')

		if weapons == nil then
		  weapons = {}
		end

		local foundWeapon = false

		for i=1, #weapons, 1 do
		  if weapons[i].name == weaponName then
			weapons[i].count = weapons[i].count + 1
			weapons[i].ammo = weapons[i].ammo+am
			foundWeapon = true
		  end
		end

		if not foundWeapon then
		  table.insert(weapons, {
			name  = weaponName,
			count = 1,
			ammo = am
		  })
		end

		 store.set('weapons', weapons)

		 cb()

	  end)
  else
	TriggerClientEvent('esx:showNotification', _source, "Greska! Pokusajte ponovno ili odite relog!")
  end
end)

ESX.RegisterServerCallback('mafije:dajWeaponItem', function(source, cb, weaponName, am, maf)
	local src = source
	local soc = "society_"..maf
	local xPlayer = ESX.GetPlayerFromId(src)
	local sourceItem = xPlayer.getInventoryItem(string.lower(weaponName))
	local nemos = 0
	if sourceItem.limit ~= -1 and (sourceItem.count + 1) <= sourceItem.limit then
		xPlayer.addInventoryItem(string.lower(weaponName), 1)
		local por = "["..os.date("%X").."] ("..GetCurrentResourceName()..") Igrac "..GetPlayerName(src).."("..xPlayer.identifier..") je dobio item "..weaponName.." x 1"
		TriggerEvent("SpremiLog", por)
	else
		xPlayer.showNotification("Ne stane vam vise u inventory!")
		nemos = 1
	end
	
	if nemos == 0 then
		TriggerEvent('esx_datastore:getSharedDataStore', soc, function(store)

			local weapons = store.get('weapons')

			if weapons == nil then
			  weapons = {}
			end

			local foundWeapon = false

			for i=1, #weapons, 1 do
			  if weapons[i].name == weaponName then
				weapons[i].count = (weapons[i].count > 0 and weapons[i].count - 1 or 0)
				weapons[i].ammo = (weapons[i].ammo > 0 and weapons[i].ammo - am or 0)
				foundWeapon = true
			  end
			end

			if not foundWeapon then
			  table.insert(weapons, {
				name  = weaponName,
				count = 0,
				ammo = 0
			  })
			end

			 store.set('weapons', weapons)

		end)
	end
	cb()
end)

RegisterNetEvent('mafije:DajOruzje')
AddEventHandler('mafije:DajOruzje', function(oruzje, job)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	if xPlayer.job.name == job then
		xPlayer.addWeapon(oruzje, 250)
	end
end)

ESX.RegisterServerCallback('mafije:removeArmoryWeapon', function(source, cb, weaponName, am, maf)
	local src = source
	local soc = "society_"..maf
	local xPlayer = ESX.GetPlayerFromId(src)
	
	xPlayer.addWeapon(weaponName, am)
	
	TriggerEvent('esx_datastore:getSharedDataStore', soc, function(store)

		local weapons = store.get('weapons')

		if weapons == nil then
		  weapons = {}
		end

		local foundWeapon = false

		for i=1, #weapons, 1 do
		  if weapons[i].name == weaponName then
			weapons[i].count = (weapons[i].count > 0 and weapons[i].count - 1 or 0)
			weapons[i].ammo = (weapons[i].ammo > 0 and weapons[i].ammo - am or 0)
			foundWeapon = true
		  end
		end

		if not foundWeapon then
		  table.insert(weapons, {
			name  = weaponName,
			count = 0,
			ammo = 0
		  })
		end

		 store.set('weapons', weapons)

		 cb()

	end)

end)

ESX.RegisterServerCallback('kupistvari', function(source, cb, stvar, maf)
	local xPlayer = ESX.GetPlayerFromId(source)
	if stvar == "laptop" then
		local xItem = xPlayer.getInventoryItem('net_cracker')
		if (xItem.count + 1) <= xItem.limit then
			if xPlayer.getMoney() >= 25000 then
			  xPlayer.removeMoney(25000)
			  xPlayer.addInventoryItem('net_cracker', 1)
			  local por = "["..os.date("%X").."] ("..GetCurrentResourceName()..") Igrac "..GetPlayerName(source).."("..xPlayer.identifier..") je dobio item net_cracker x 1"
			  TriggerEvent("SpremiLog", por)
			  cb(true)
			else
			  cb(false)
			end
		else
			cb(false)
		end
	elseif stvar == "termit" then
		local xItem = xPlayer.getInventoryItem('thermite')
		if (xItem.count + 1) <= xItem.limit then
			if xPlayer.getMoney() >= 5000 then
			  xPlayer.removeMoney(5000)
			  xPlayer.addInventoryItem('thermite', 1)
			  local por = "["..os.date("%X").."] ("..GetCurrentResourceName()..") Igrac "..GetPlayerName(source).."("..xPlayer.identifier..") je dobio item thermite x 1"
			  TriggerEvent("SpremiLog", por)
			  cb(true)
			else
			  cb(false)
			end
		else
			cb(false)
		end
	elseif stvar == "ktijelo" then
		local xItem = xPlayer.getInventoryItem('ktijelo')
		if (xItem.count + 1) <= xItem.limit then
			local soc = "society_"..maf
			TriggerEvent('esx_addonaccount:getSharedAccount', soc, function(account)
				if account.money >= 5000 then
					account.removeMoney(5000)
					xPlayer.addInventoryItem('ktijelo', 1)
					cb(true)
				else
					cb(false)
				end
			end)
		else
			cb(false)
		end
	elseif stvar == "ctijelo" then
		local xItem = xPlayer.getInventoryItem('ctijelo')
		if (xItem.count + 1) <= xItem.limit then
			local soc = "society_"..maf
			TriggerEvent('esx_addonaccount:getSharedAccount', soc, function(account)
				if account.money >= 6000 then
					account.removeMoney(6000)
					xPlayer.addInventoryItem('ctijelo', 1)
					cb(true)
				else
					cb(false)
				end
			end)
		else
			cb(false)
		end
	elseif stvar == "stijelo" then
		local xItem = xPlayer.getInventoryItem('stijelo')
		if (xItem.count + 1) <= xItem.limit then
			local soc = "society_"..maf
			TriggerEvent('esx_addonaccount:getSharedAccount', soc, function(account)
				if account.money >= 7000 then
					account.removeMoney(7000)
					xPlayer.addInventoryItem('stijelo', 1)
					cb(true)
				else
					cb(false)
				end
			end)
		else
			cb(false)
		end
	elseif stvar == "smtijelo" then
		local xItem = xPlayer.getInventoryItem('smtijelo')
		if (xItem.count + 1) <= xItem.limit then
			local soc = "society_"..maf
			TriggerEvent('esx_addonaccount:getSharedAccount', soc, function(account)
				if account.money >= 4500 then
					account.removeMoney(4500)
					xPlayer.addInventoryItem('smtijelo', 1)
					cb(true)
				else
					cb(false)
				end
			end)
		else
			cb(false)
		end
	else
		cb(false)
	end
end)

ESX.RegisterServerCallback('mafije:piku4', function(source, cb, amount, maf)
	local soc = "society_"..maf
	TriggerEvent('esx_addonaccount:getSharedAccount', soc, function(account)
		if account.money >= amount then
			cb(true)
		else
			cb(false)
		end
	end)
end)

ESX.RegisterServerCallback('mafije:piku5', function(source, cb, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local soc = "society_"..xPlayer.getJob().name
	TriggerEvent('esx_addonaccount:getSharedAccount', soc, function(account)
		if account and account.money and amount then
			if account.money >= amount then
				account.removeMoney(amount)
				cb(true)
			else
				cb(false)
			end
		else
			cb(false)
		end
	end)
end)

ESX.RegisterServerCallback('mafije:getStockItems', function(source, cb, maf)
  local soc = maf
  TriggerEvent('esx_addoninventory:getSharedInventory', soc, function(inventory)
    cb(inventory.items)
  end)

end)

ESX.RegisterServerCallback('mafije:getPlayerInventory', function(source, cb)

  local xPlayer = ESX.GetPlayerFromId(source)
  local items   = xPlayer.inventory

  cb({
    items = items
  })

end)

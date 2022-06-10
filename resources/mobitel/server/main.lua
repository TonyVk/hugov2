ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local MobInfo = {}
local zadnjiPoziv = 10
local PhoneNumbers = {}
local HitniPozivi = {
  {orga = "police", broj = 192, ime = "Policija"},
  {orga = "ambulance", broj = 193, ime = "Bolnica"},
  {orga = "mechanic", broj = 194, ime = "Mehanicar"},
  {orga = "taxi", broj = 195, ime = "Taxi"}
}

ESX.RegisterServerCallback('mobitel:DohvatiPoruke', function(source, cb)
    local _source = source
	  local xPlayer = ESX.GetPlayerFromId(_source)
    MySQL.Async.fetchAll('SELECT transmitter, receiver, message, IF(display is not null, display , transmitter) as display, coord, orgBroj \
    FROM phone_messages \
    left join phone_users_contacts on (phone_users_contacts.number = phone_messages.transmitter or phone_users_contacts.number = phone_messages.receiver) and phone_users_contacts.identifier=@id \
    where phone_messages.receiver = @broj or phone_messages.transmitter = @broj order by phone_messages.time desc', {
        ['@id'] = xPlayer.getID(),
        ['@broj'] = xPlayer.getNumber()
    }, function(por)
      for i=1, #por, 1 do
        for j=1, #HitniPozivi, 1 do
          if HitniPozivi[j].broj == por[i].transmitter then
            por[i].display = HitniPozivi[j].ime
          end
        end
      end
		  cb(por, xPlayer.getNumber())
    end)
end)

ESX.RegisterServerCallback('mobitel:DohvatiKontakte', function(source, cb)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    MySQL.Async.fetchAll('select number, display from phone_users_contacts where identifier = @id', {
        ['@id'] = xPlayer.getID()
    }, function(kon)
		  cb(kon)
    end)
end)

ESX.RegisterServerCallback('mobitel:ImalMobitel', function(source, cb)
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)
  local xItem = xPlayer.getInventoryItem("mobitel")
  if xItem.count > 0 then
    cb(true)
  else
    cb(false)
  end
end)

ESX.RegisterServerCallback('mobitel:DohvatiHitne', function(source, cb)
  local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
  cb(PhoneNumbers, xPlayer.getNumber())
end)

ESX.RegisterServerCallback('mobitel:DohvatiBroj', function(source, cb)
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)
  cb(xPlayer.getNumber())
end)

function ImalSignala(src)
  local centarGrada = vector3(86.756629943848,-989.32501220703,29.407320022583)
  local centarPaleto = vector3(-176.29887390137, 6363.9033203125, 31.396242141724)
  local centarSandy = vector3(1813.2326660156, 3796.2780761719, 33.625762939453)
  local pos = GetEntityCoords(GetPlayerPed(src))
  if #(centarGrada-pos) >= 2800 and pos.z < 100 and #(centarPaleto-pos) >= 680 and #(centarSandy-pos) >= 580 then
    return false
  else
    return true
  end
end

RegisterNetEvent('mobitel:Nazovi')
AddEventHandler('mobitel:Nazovi', function(br)
  local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local brojIgraca = tonumber(xPlayer.getNumber())
  br = tonumber(br)
  if brojIgraca ~= br then
    MySQL.Async.fetchAll('SELECT users.identifier FROM users WHERE users.phone_number = @phone_number', {
      ['@phone_number'] = br
    }, function (result)
          if #result > 0 then
              getSourceFromIdentifier(result[1].identifier, function (srcTo)
                  if srcTo ~= nil then
                    if ImalSignala(srcTo) then
                      local indexCall = zadnjiPoziv
                      zadnjiPoziv = zadnjiPoziv + 1
                      MobInfo[indexCall] = {
                          id = indexCall,
                          pozivatelj = _source,
                          pozivatelj_broj = brojIgraca,
                          primatelj = srcTo,
                          primatelj_broj = br
                      }
                      TriggerClientEvent('mobitel:Pozivanje', _source, MobInfo[indexCall], true)
                      TriggerClientEvent('mobitel:Pozivanje', srcTo, MobInfo[indexCall], false)
                    else
                      TriggerClientEvent('mobitel:BrojNePostoji', _source, false)
                    end
                  else
                      TriggerClientEvent('mobitel:BrojNePostoji', _source, false)
                  end
              end)
          else
              TriggerClientEvent('mobitel:BrojNePostoji', _source, true)
          end
      end)
    else
      TriggerClientEvent('mobitel:BrojNePostoji', _source, false)
    end
end)

RegisterNetEvent('mobitel:PosaljiPoruku')
AddEventHandler('mobitel:PosaljiPoruku', function(br, poruka)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local brojIgraca = tonumber(xPlayer.getNumber())
  br = tonumber(br)
  if brojIgraca ~= br then
    MySQL.Async.fetchAll('SELECT users.identifier FROM users WHERE users.phone_number = @phone_number', {
      ['@phone_number'] = br
    }, function (result)
          if #result > 0 then
            getSourceFromIdentifier(result[1].identifier, function (srcTo)
              if srcTo ~= nil then
                if ImalSignala(srcTo) then
                  MySQL.Async.insert('INSERT INTO phone_messages (transmitter, receiver, message) VALUES (@br, @br2, @por)',{
                      ['@br'] = brojIgraca,
                      ['@br2'] = br,
                      ['@por'] = poruka
                  }, function(insertId)
                    
                  end)
                  TriggerClientEvent('mobitel:NovaPoruka', _source, br, true)
                  TriggerClientEvent('mobitel:NovaPoruka', srcTo, brojIgraca, false)
                else
                  TriggerClientEvent('mobitel:BrojNePostoji', _source, false)
                end
              else
                MySQL.Async.insert('INSERT INTO phone_messages (transmitter, receiver, message) VALUES (@br, @br2, @por)',{
                  ['@br'] = brojIgraca,
                  ['@br2'] = br,
                  ['@por'] = poruka
                }, function(insertId)

                end)
                TriggerClientEvent('mobitel:NovaPoruka', _source, br, true)
              end
            end)
          else
              TriggerClientEvent('mobitel:BrojNePostoji', _source, true)
          end
      end)
    else
      TriggerClientEvent('mobitel:BrojNePostoji', _source, false)
    end
end)

RegisterNetEvent('mobitel:DodajKontakt')
AddEventHandler('mobitel:DodajKontakt', function(br, ime)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    MySQL.Async.fetchAll('SELECT users.identifier FROM users WHERE users.phone_number = @phone_number', {
		['@phone_number'] = br
	}, function (result)
        if #result > 0 then
            MySQL.Async.insert('INSERT INTO phone_users_contacts (identifier, number, display) VALUES (@id, @br, @ime)',{
                ['@id'] = xPlayer.getID(),
                ['@br'] = br,
                ['@ime'] = ime
            }, function(insertId)
                TriggerClientEvent("mobitel:DodanKontakt", _source)
            end)
        else
            TriggerClientEvent('mobitel:BrojNePostoji', _source, true)
        end
    end)
end)

RegisterNetEvent('mobitel:ObrisiKontakt')
AddEventHandler('mobitel:ObrisiKontakt', function(br)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    MySQL.Async.execute('DELETE FROM phone_users_contacts WHERE identifier = @id AND number = @br', {
        ['@id'] = xPlayer.getID(),
        ['@br'] = br
    }, function(data)

    end)
    TriggerClientEvent('mobitel:ObrisanKontakt', _source)
end)

RegisterNetEvent('mobitel:PrihvatiPoziv')
AddEventHandler('mobitel:PrihvatiPoziv', function(info)
    local _source = source
    TriggerClientEvent('mobitel:PrihvacenPoziv', _source, info, false)
    TriggerClientEvent('mobitel:PrihvacenPoziv', info.pozivatelj, info, true)
end)

RegisterNetEvent('mobitel:Prekini')
AddEventHandler('mobitel:Prekini', function(info)
    if info ~= nil then
        TriggerClientEvent('mobitel:PrekinutPoziv', info.primatelj)
        TriggerClientEvent('mobitel:PrekinutPoziv', info.pozivatelj)
    end
end)

function getSourceFromIdentifier(identifier, cb)
    local naso = false
    TriggerEvent("es:getPlayers", function(users)
        for k , user in pairs(users) do
            if (user.getIdentifier ~= nil and user.getIdentifier() == identifier) or (user.identifier == identifier) then
                cb(k)
                naso = true
                return
            end
        end
    end)
    if not naso then
        cb(nil)
    end
end

RegisterServerEvent('esx_addons_gcphone:startCall')
AddEventHandler('esx_addons_gcphone:startCall', function (number, message, coords)
  local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
  if PhoneNumbers[number] ~= nil then
		getPhoneNumber(source, function (phone) 
		  notifyAlertSMS(number, {
        message = message,
        coord = json.encode(coords),
        numero = phone,
        orgBr = xPlayer.getNumber()
		  }, PhoneNumbers[number].sources)
		end)
  else
    print('= WARNING = Broj ne postoji : ' .. number)
  end
end)

function notifyAlertSMS (number, alert, listSrc)
  if PhoneNumbers[number] ~= nil then
	  local mess = alert.message
    for k, _ in pairs(listSrc) do
      getPhoneNumber(tonumber(k), function (n)
        if n ~= nil then
            --   TriggerEvent('xenknight:_internalAddMessage', number, n, mess, 0, function (smsMess)
            --     TriggerClientEvent("xenknight:receiveMessage", tonumber(k), smsMess)
            --   end)
            PosaljiPoruku(tonumber(k), number, n, mess, alert.coord, alert.orgBr)
        end
      end)
    end
  end
end

function PosaljiPoruku(src, br, br2, poruka, koord, orgBr)
  local _source = src
	local xPlayer = ESX.GetPlayerFromId(_source)
	local brojIgraca = br2
  local ime = br
  for i=1, #HitniPozivi, 1 do
    if HitniPozivi[i].orga == br then
      br = HitniPozivi[i].broj
      ime = HitniPozivi[i].ime
      break
    end
  end
  MySQL.Async.insert('INSERT INTO phone_messages (transmitter, receiver, message, coord, orgBroj) VALUES (@br, @br2, @por, @kor, @org)',{
      ['@br'] = br,
      ['@br2'] = brojIgraca,
      ['@por'] = poruka,
      ['@kor'] = koord,
      ['@org'] = orgBr
  }, function(insertId)

  end)
  TriggerClientEvent('mobitel:NovaPoruka', _source, ime, false)
end

RegisterNetEvent('mobitel:PosaljiPoruku2')
AddEventHandler('mobitel:PosaljiPoruku2', function(br, poruka, koord, orgBr)
    local sourcePlayer = tonumber(source)
    TriggerClientEvent('mobitel:NovaPoruka', sourcePlayer, br, true)
    if PhoneNumbers[br] ~= nil then
      getPhoneNumber(sourcePlayer, function (phone) 
        notifyAlertSMS(br, {
          message = poruka,
          coord = koord,
          numero = phone,
          orgBr = orgBr
        }, PhoneNumbers[br].sources)
      end)
    end
end)

AddEventHandler('esx_phone:registerNumber', function(number, type, sharePos, hasDispatch, hideNumber, hidePosIfAnon)
  print('= INFO = Registriran novi broj ' .. number .. ' => ' .. type)
	local hideNumber    = hideNumber    or false
	local hidePosIfAnon = hidePosIfAnon or false

	PhoneNumbers[number] = {
		type          = type,
    sources       = {},
    alerts        = {}
	}
end)

AddEventHandler('esx:setJob', function(source, job, lastJob)
  if lastJob.name == "sipa" then
	lastJob.name = "police"
  end
  if PhoneNumbers[lastJob.name] ~= nil then
    TriggerEvent('mobitel:removeSource', lastJob.name, source)
  end
  if job.name == "sipa" then
	job.name = "police"
  end
  if PhoneNumbers[job.name] ~= nil then
    TriggerEvent('mobitel:addSource', job.name, source)
  end
end)

AddEventHandler('mobitel:addSource', function(number, source)
	PhoneNumbers[number].sources[tostring(source)] = true
end)

AddEventHandler('mobitel:removeSource', function(number, source)
	PhoneNumbers[number].sources[tostring(source)] = nil
end)

-- RegisterServerEvent('xenknight:sendMessage')
-- AddEventHandler('xenknight:sendMessage', function(number, message)
--     local sourcePlayer = tonumber(source)
--     if PhoneNumbers[number] ~= nil then
--       getPhoneNumber(source, function (phone) 
--         notifyAlertSMS(number, {
--           message = message,
--           numero = phone,
--         }, PhoneNumbers[number].sources)
--       end)
--     end
-- end)

AddEventHandler('esx:playerLoaded', function(source)

  local xPlayer = ESX.GetPlayerFromId(source)

  MySQL.Async.fetchScalar('SELECT phone_number FROM users WHERE ID = @identifier',{
    ['@identifier'] = xPlayer.getID()
  }, function(result)
    local phoneNumber = result
    if phoneNumber == '0' or phoneNumber == nil then
      repeat
        phoneNumber = getPhoneRandomNumber()
        local id = getIdentifierByPhoneNumber(phoneNumber)
      until id == nil
      MySQL.Async.insert("UPDATE users SET phone_number = @myPhoneNumber WHERE ID = @identifier", { 
          ['@myPhoneNumber'] = phoneNumber,
          ['@identifier'] = xPlayer.getID()
      }, function ()
          
      end)
    end
    xPlayer.set('phoneNumber', phoneNumber)
    xPlayer.setNumber(phoneNumber)
    local posao = xPlayer.job.name
    if xPlayer.job.name == "sipa" then
      posao = "police"
    end
    if PhoneNumbers[posao] ~= nil then
      TriggerEvent('mobitel:addSource', posao, source)
    end
  end)
end)

function getPhoneRandomNumber()
  local numBase0 = math.random(100,999)
  local numBase1 = math.random(0,9999)
  local num = string.format("%03d%04d", numBase0, numBase1)
  return num
end

function getIdentifierByPhoneNumber(phone_number) 
  local result = MySQL.Sync.fetchAll("SELECT users.identifier FROM users WHERE users.phone_number = @phone_number", {
      ['@phone_number'] = phone_number
  })
  if result[1] ~= nil then
      return result[1].identifier
  end
  return nil
end

AddEventHandler('esx:playerDropped', function(source)
  local source = source
  local xPlayer = ESX.GetPlayerFromId(source)
  local posao = xPlayer.job.name
  if xPlayer.job.name == "sipa" then
	posao = "police"
  end
  if PhoneNumbers[posao] ~= nil then
    TriggerEvent('mobitel:removeSource', posao, source)
  end
end)


function getPhoneNumber (source, callback) 
  local xPlayer = ESX.GetPlayerFromId(source)
  if xPlayer == nil then
    callback(nil)
  else
    callback(xPlayer.getNumber())
  end
end
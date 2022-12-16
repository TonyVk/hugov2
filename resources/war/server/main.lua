ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local TrajeWar = false
local Minute = 5
local CekajMinute = 1 --Broj minuta koliko se ceka start wara
local MaxBr = 5
local IgrTim1 = 0
local IgrTim2 = 0
local SpawnTim1 = 0
local SpawnTim2 = 0
local Tim1Score = 0
local Tim2Score = 0
local Igraci = {}
local PoceoWar = false

ESX.RegisterServerCallback('War:PokreniWar', function(source, cb, id, id2, br, vr)
    local srcPlayer = ESX.GetPlayerFromId(source)
	local xPlayer = ESX.GetPlayerFromId(id)
    local xPlayer2 = ESX.GetPlayerFromId(id2)
    if not TrajeWar then
        if xPlayer and xPlayer2 then
            if xPlayer.job.grade_name == "boss" then
                if xPlayer2.job.grade_name == "boss" then
                    TrajeWar = true
                    PoceoWar = false
                    Minute = tonumber(vr)
                    MaxBr = tonumber(br)
                    CekajMinute = 1
                    Igraci = {}
                    Tim1Score = 0
                    Tim2Score = 0
                    SpawnTim1 = 0
                    SpawnTim2 = 0
                    IgrTim1 = 0
                    IgrTim2 = 0
                    TriggerClientEvent("war:Pozovi", id, 1, PoceoWar)
                    TriggerClientEvent("war:Pozovi", id2, 2, PoceoWar)
                    SetPlayerRoutingBucket(id, 69)
                    SetPlayerRoutingBucket(id2, 69)
                    TriggerClientEvent("War:SyncMinute", -1, Minute)
                    SetTimeout(60000, PratiStart)
                    cb(true)
                else
                    srcPlayer.showNotification("Igrac 2 nije lider!")
                    cb(false)
                end
            else
                srcPlayer.showNotification("Igrac 1 nije lider!")
                cb(false)
            end
        else
            srcPlayer.showNotification("Netko od igraca nije online!")
            cb(false)
        end
    else
        srcPlayer.showNotification("Vec traje war!")
        cb(false)
    end
end)

RegisterNetEvent('War:PozoviIgraca')
AddEventHandler('War:PozoviIgraca', function(id)
    local xPlayer = ESX.GetPlayerFromId(source)
    local yPlayer = ESX.GetPlayerFromId(id)
	if TrajeWar then
        if xPlayer.job.grade_name == "boss" then
            if Igraci[tostring(source)] then
                if yPlayer ~= nil then
                    if xPlayer.job.id == yPlayer.job.id then
                        if Igraci[tostring(id)] == nil then
                            if Igraci[tostring(source)] == 1 then
                                if IgrTim1+1 > MaxBr then
                                    xPlayer.showNotification("Vec vas ima "..MaxBr.." u waru!")
                                else
                                    TriggerClientEvent("war:Pozovi", id, Igraci[tostring(source)], PoceoWar)
                                end
                            elseif Igraci[tostring(source)] == 2 then
                                if IgrTim2+1 > MaxBr then
                                    xPlayer.showNotification("Vec vas ima "..MaxBr.." u waru!")
                                else
                                    TriggerClientEvent("war:Pozovi", id, Igraci[tostring(source)], PoceoWar)
                                end
                            end
                        else
                            xPlayer.showNotification("Igrac je vec u waru!")
                        end
                    else
                        xPlayer.showNotification("Taj igrac nije clan vase mafije!")
                    end
                else
                    xPlayer.showNotification("Igrac nije online!")
                end
            else
                xPlayer.showNotification("Greska skripte, ne vodite se kao igrac wara!")
            end
        else
            xPlayer.showNotification("Niste lider!")
        end
    else
        xPlayer.showNotification("War nije pokrenut!")
    end
end)

RegisterNetEvent('War:IzbaciIgraca')
AddEventHandler('War:IzbaciIgraca', function(id)
    local xPlayer = ESX.GetPlayerFromId(source)
    local yPlayer = ESX.GetPlayerFromId(tonumber(id))
	if TrajeWar then
        if xPlayer.job.grade_name == "boss" then
            if Igraci[tostring(id)] then
                if yPlayer ~= nil then
                    if xPlayer.job.id == yPlayer.job.id then
                        TriggerClientEvent("war:Zavrsi", tonumber(id), false)
                        SetPlayerRoutingBucket(tonumber(id), 0)
                        Igraci[tostring(id)] = nil
                    else
                        xPlayer.showNotification("Taj igrac nije clan vaseg tima!")
                    end
                else
                    xPlayer.showNotification("Igrac nije online!")
                end
            else
                xPlayer.showNotification("Igrac nije u waru!")
            end
        else
            xPlayer.showNotification("Niste lider!")
        end
    else
        xPlayer.showNotification("War nije pokrenut!")
    end
end)

ESX.RegisterServerCallback('War:DohvatiSpawn', function(source, cb, tim)
    local xPlayer = ESX.GetPlayerFromId(source)
    if tim == 1 then
        if IgrTim1+1 > MaxBr then
            xPlayer.showNotification("Niste spawnani u war zato što je premašen limit igraca!")
            cb(false)
        else
            IgrTim1 = IgrTim1+1
            SpawnTim1 = SpawnTim1+1
            Igraci[tostring(source)] = tim
            SetPlayerRoutingBucket(source, 69)
            TriggerClientEvent("War:SyncMinute", -1, Minute)
            cb(SpawnTim1)
        end
    elseif tim == 2 then
        if IgrTim2+1 > MaxBr then
            xPlayer.showNotification("Niste spawnani u war zato što je premašen limit igraca!")
            cb(false)
        else
            IgrTim2 = IgrTim2+1
            SpawnTim2 = SpawnTim2+1
            Igraci[tostring(source)] = tim
            SetPlayerRoutingBucket(source, 69)
            TriggerClientEvent("War:SyncMinute", -1, Minute)
            cb(SpawnTim2)
        end
    end
end)

RegisterNetEvent('war:Zaustavi')
AddEventHandler('war:Zaustavi', function()
    local xPlayer = ESX.GetPlayerFromId(source)
	if TrajeWar then
        if Tim1Score > Tim2Score then
            TriggerClientEvent('War:VratiPoruku', -1, "Tim 1 je pobjedio tim 2 ("..Tim1Score..":"..Tim2Score..")")
        elseif Tim2Score > Tim1Score then
            TriggerClientEvent('War:VratiPoruku', -1, "Tim 2 je pobjedio tim 1 ("..Tim2Score..":"..Tim1Score..")")
        else
            TriggerClientEvent('War:VratiPoruku', -1, "War je zavrsio izjednaceno ("..Tim1Score..":"..Tim2Score..")")
        end
        for k,v in pairs(Igraci) do
            TriggerClientEvent("war:Zavrsi", tonumber(k), true)
            SetPlayerRoutingBucket(tonumber(k), 0)
            Igraci[k] = nil
        end
        TrajeWar = false
        PoceoWar = false
        Minute = 5
        MaxBr = 5
        IgrTim1 = 0
        IgrTim2 = 0
        SpawnTim1 = 0
        SpawnTim2 = 0
        Igraci = {}
        xPlayer.showNotification("Uspjesno zaustavljen war!")
    else
        xPlayer.showNotification("War nije pokrenut!")
    end
end)

RegisterNetEvent("War:PosaljiPoruku")
AddEventHandler('War:PosaljiPoruku', function(str)
    TriggerClientEvent('War:VratiPoruku', -1, str)
end)

RegisterNetEvent("War:PosaljiKill")
AddEventHandler('War:PosaljiKill', function(id, id2)
	local targetXPlayer = ESX.GetPlayerFromId(id) --killer
	local targetXPlayer2 = ESX.GetPlayerFromId(id2) --victim
	local Isti = 0
	if targetXPlayer.job.name == targetXPlayer2.job.name then
		Isti = 1
	else
		Isti = 0
	end

    if Igraci[tostring(targetXPlayer.source)] and Igraci[tostring(targetXPlayer2.source)] then
        if Isti == 0 then
            if Igraci[tostring(targetXPlayer.source)] == 1 then
                Tim1Score = Tim1Score+5
                local str = "[Tim 1] ~r~"..GetPlayerName(targetXPlayer.source).." ~w~je ubio [Tim 2] ~r~"..GetPlayerName(targetXPlayer2.source).." ~w~(+5 bodova za tim 1)"
                TriggerClientEvent('War:VratiPoruku', -1, str)
            elseif Igraci[tostring(targetXPlayer.source)] == 2 then
                Tim2Score = Tim2Score+5
                local str = "[Tim 2] ~r~"..GetPlayerName(targetXPlayer.source).." ~w~je ubio [Tim 1] ~r~"..GetPlayerName(targetXPlayer2.source).." ~w~(+5 bodova za tim 2)"
                TriggerClientEvent('War:VratiPoruku', -1, str)
            end
        else
            if Igraci[tostring(targetXPlayer.source)] == 1 then
                Tim1Score = Tim1Score-2
                local str = "[Tim 1] ~r~"..GetPlayerName(targetXPlayer.source).." ~w~je ubio svoga clana tima (-2 boda za tim 1)"
                TriggerClientEvent('War:VratiPoruku', -1, str)
            elseif Igraci[tostring(targetXPlayer.source)] == 2 then
                Tim2Score = Tim2Score-2
                local str = "[Tim 2] ~r~"..GetPlayerName(targetXPlayer.source).." ~w~je ubio svoga clana tima (-2 boda za tim 2)"
                TriggerClientEvent('War:VratiPoruku', -1, str)
            end
        end
        TriggerClientEvent('War:VratiKill', targetXPlayer.source)
        TriggerClientEvent("War:SyncScore", -1, Tim1Score, Tim2Score)
    end
end)

AddEventHandler('playerDropped', function()
	local Source = tostring(source)

	if Igraci[Source] then
		if Igraci[Source] == 1 then
            IgrTim1 = IgrTim1-1
            TriggerClientEvent('War:VratiPoruku', -1, "Timu 1 fali igrac. Jedan igrac je napustio server.")
            if IgrTim1 <= 0 then
                if TrajeWar then
                    TriggerClientEvent('War:VratiPoruku', -1, "Tim 1 je napustio war, te su zbog toga izgubili!")
                    for k,v in pairs(Igraci) do
                        TriggerClientEvent("war:Zavrsi", tonumber(k), true)
                        SetPlayerRoutingBucket(tonumber(k), 0)
                        Igraci[k] = nil
                    end
                    TrajeWar = false
                    PoceoWar = false
                    Minute = 5
                    MaxBr = 5
                    IgrTim1 = 0
                    IgrTim2 = 0
                    SpawnTim1 = 0
                    SpawnTim2 = 0
                    Igraci = {}
                end
            end
        elseif Igraci[Source] == 2 then
            IgrTim2 = IgrTim2-1
            TriggerClientEvent('War:VratiPoruku', -1, "Timu 2 fali igrac. Jedan igrac je napustio server.")
            if IgrTim2 <= 0 then
                if TrajeWar then
                    TriggerClientEvent('War:VratiPoruku', -1, "Tim 2 je napustio war, te su zbog toga izgubili!")
                    for k,v in pairs(Igraci) do
                        TriggerClientEvent("war:Zavrsi", tonumber(k), true)
                        SetPlayerRoutingBucket(tonumber(k), 0)
                        Igraci[k] = nil
                    end
                    TrajeWar = false
                    PoceoWar = false
                    Minute = 5
                    MaxBr = 5
                    IgrTim1 = 0
                    IgrTim2 = 0
                    SpawnTim1 = 0
                    SpawnTim2 = 0
                    Igraci = {}
                end
            end
        end
        Igraci[Source] = nil
	end
end)

RegisterNetEvent("War:Samoubojstvo")
AddEventHandler('War:Samoubojstvo', function(tim)
    if tim == 1 then
        Tim1Score = Tim1Score-1
        local str = "[Tim 1] ~r~"..GetPlayerName(source).." ~w~se ubio sam (-1 bod za tim 1)"
		TriggerClientEvent('War:VratiPoruku', -1, str)
    elseif tim == 2 then
        Tim2Score = Tim2Score-1
        local str = "[Tim 2] ~r~"..GetPlayerName(source).." ~w~se ubio sam (-1 bod za tim 2)"
	    TriggerClientEvent('War:VratiPoruku', -1, str)
    end
    TriggerClientEvent("War:SyncScore", -1, Tim1Score, Tim2Score)
end)

function PratiVrijeme()
    if PoceoWar then
        if Minute > 1 then
            Minute = Minute-1
            TriggerClientEvent("War:SyncMinute", -1, Minute)
            SetTimeout(60000, PratiVrijeme)
        else
            if Tim1Score > Tim2Score then
                TriggerClientEvent('War:VratiPoruku', -1, "Tim 1 je pobjedio tim 2 ("..Tim1Score..":"..Tim2Score..")")
            elseif Tim2Score > Tim1Score then
                TriggerClientEvent('War:VratiPoruku', -1, "Tim 2 je pobjedio tim 1 ("..Tim2Score..":"..Tim1Score..")")
            else
                TriggerClientEvent('War:VratiPoruku', -1, "War je zavrsio izjednaceno ("..Tim1Score..":"..Tim2Score..")")
            end
            for k,v in pairs(Igraci) do
                TriggerClientEvent("war:Zavrsi", tonumber(k), true)
                Igraci[k] = nil
            end
            TrajeWar = false
            Minute = 5
            MaxBr = 5
            IgrTim1 = 0
            IgrTim2 = 0
            SpawnTim1 = 0
            SpawnTim2 = 0
            Igraci = {}
        end
    end
end

function PratiStart()
    if TrajeWar then
        if CekajMinute > 1 then
            CekajMinute = CekajMinute-1
            SetTimeout(60000, PratiStart)
        else
            PoceoWar = true
            TriggerClientEvent("War:UnfreezeIgrace", -1)
            SetTimeout(60000, PratiVrijeme)
            TriggerClientEvent('War:VratiPoruku', -1, "War je zapoceo! Sretno!")
        end
    end
end
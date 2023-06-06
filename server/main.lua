ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local press = false
local a = nil
local b = nil
local c = nil
local f =nil
local g =nil




    ESX.RegisterUsableItem(Config.Itemuse, function(source)

        local _source = source
        local xPlayer = ESX.GetPlayerFromId(_source)
        local xPlayers = ESX.GetPlayers()
        local cops = 0

        for i = 1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            if xPlayer.job.name == 'police' then cops = cops + 1 end
        end
        if not press then
            if not press and cops >= Config.PoliceWant then

                if Config.removeItemuse then
                    xPlayer.removeInventoryItem(Config.Itemuse, 1)
                    TriggerClientEvent("SPG_HOLDPROP", source)
                    Citizen.Wait(100)

                    TriggerClientEvent('SPG_StartSell', source)

                else
                    TriggerClientEvent("SPG_HOLDPROP", source)
                    Citizen.Wait(100)
                    TriggerClientEvent('SPG_StartSell', source)

                end
                press = true
            else
                TriggerClientEvent("pNotify:SendNotification", source, {
                    text = Config.noCopsText,
                    type = Config.noCopstype,
                    timeout = Config.noCopstime * 1000,
                    layout = Config.noCopslaout
                })
            end
        end
        Citizen.Wait(Config.timeSell * 1000)
        press = false
    end)

    RegisterServerEvent("Suphapong_sellDrug")
    AddEventHandler("Suphapong_sellDrug", function(name)
        press = false
        local _source = source
        local xPlayer = ESX.GetPlayerFromId(_source)
        xPlayer.getName()
        local luckItem = math.random(Config.randomsell[1], Config.randomsell[2]) -- todo sell

        local xItem = xPlayer.getInventoryItem(name)
        local pay = 0
        local prince = 0
        for k, v in pairs(Config['sellDrug']) do

            if v.sell['name'] == name then

                prince = math.random(v.sell['amount'][1], v.sell['amount'][2])

            end

        end

        if xItem.count >= 1 then
            if xItem.count >= luckItem then
                pay = luckItem * prince
                xPlayer.removeInventoryItem(xItem.name, luckItem)
                if Config.cleanmoney == true then
                    xPlayer.addMoney(pay)
                else
                    xPlayer.addAccountMoney('black_money', pay)
                end
                
            else
                pay = xItem.count * prince
                xPlayer.removeInventoryItem(xItem.name, xItem.count)
                if Config.cleanmoney == true then
                    xPlayer.addMoney(pay)
                else
                    xPlayer.addAccountMoney('black_money', pay)
                end
                
            end

            local identifiers = ExtractIdentifiers()
            local steam = identifiers.steam

            sendToDiscord("คุณ " .. xPlayer.getName(),
                          "ได้เงินจำนวน [" .. pay .. "] บาท จากการขาย [" ..
                              xItem.name .. "] ", 16711680)

        else
            TriggerClientEvent("pNotify:SendNotification", _source, {
                text = Config.Noitemtext,
                type = Config.Noitemtype,
                timeout = Config.Noitemtime * 1000,
                layout = Config.Noitemlayout
            })
        end
    end)

    function ExtractIdentifiers()
        local identifiers = {
            steam = "",
            ip = "",
            discord = "",
            license = "",
            xbl = "",
            live = ""
        }

        -- Loop over all identifiers
        for i = 0, GetNumPlayerIdentifiers(source) - 1 do
            local id = GetPlayerIdentifier(source, i)

            -- Convert it to a nice table.
            if string.find(id, "steam") then
                identifiers.steam = id
            elseif string.find(id, "ip") then
                identifiers.ip = id
            elseif string.find(id, "discord") then
                identifiers.discord = id
            elseif string.find(id, "license") then
                identifiers.license = id
            elseif string.find(id, "xbl") then
                identifiers.xbl = id
            elseif string.find(id, "live") then
                identifiers.live = id
            end
        end

        return identifiers
    end

    function sendToDiscord(name, message, color)
        local identifiers = ExtractIdentifiers()
        local steam = identifiers.steam

        local connect = {
            {
                ["color"] = color,
                ["title"] = "**" .. name .. "**",
                ["description"] = message,
                ["footer"] = {["text"] = "Steam Identifier: " .. steam}
            }
        }
        PerformHttpRequest(Config.WebHook, function(err, text, headers) end, 'POST', json.encode ({
            username = 'Suphapong_devlop',
            embeds = connect,
        }), {['Content-Type'] = 'application/json'})
    end


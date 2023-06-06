local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84,
    ["="] = 83, ["BACKSPACE"] = 177, ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199,
    ["["] = 39, ["]"] = 40, ["ENTER"] = 18, ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81, ["LEFTCTRL"] = 36, ["LEFTALT"] = 19,
    ["SPACE"] = 22, ["RIGHTCTRL"] = 70, ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178, ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX = nil
local sellna = false
local Spawn = true

local timeoutna = true
local liv = nil
local ped = nil
local HOLD = false
local index = 1
local enought = false
local DEAD = nil
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(1)
    end
    PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer) PlayerData = xPlayer end)

RegisterNetEvent('esx:setjob')
AddEventHandler('esx:setjob', function(job) PlayerData.job = job end)

RegisterNetEvent('SPG_StartSell')
AddEventHandler('SPG_StartSell', function()

    local livr = math.random(1, #Config.SpawnNPC)

    if sellna then
        livr = math.random(1, #Config.SpawnNPC)
        goliv(Config.SpawnNPC, livr)

        Citizen.CreateThread(function()
            while true do
                Citizen.Wait(0)

                if not Spawn then

                    RemoveBlip(liv)
                    SetPedAsNoLongerNeeded(ped)
                    Spawn = true
                    break
                else
                    if Spawn then
                        Spawn = false
                        RequestModel(GetHashKey(Config['Npcname']))
                        while not HasModelLoaded(GetHashKey(Config['Npcname'])) do
                            Wait(1)
                        end
                        ped = CreatePed(4, Config['Npcped'],
                                        Config.SpawnNPC[livr].x,
                                        Config.SpawnNPC[livr].y,
                                        Config.SpawnNPC[livr].z,
                                        Config.SpawnNPC[livr].h, false, true)
                        FreezeEntityPosition(ped, true)
                        SetEntityInvincible(ped, true)
                        SetBlockingOfNonTemporaryEvents(ped, true)

                        SellNpc(Config.SpawnNPC[livr].x,
                                Config.SpawnNPC[livr].y, Config.SpawnNPC[livr].z)

                    end

                end
            end
        end)

    end
end)

function goliv(SpawnNPC, livr)

    liv = AddBlipForCoord(SpawnNPC[livr].x, SpawnNPC[livr].y, SpawnNPC[livr].z)
    SetBlipSprite(liv, 1)
    SetNewWaypoint(SpawnNPC[livr].x, SpawnNPC[livr].y)

end

function SellNpc(x, y, z)

    while true do

        Citizen.Wait(0)
        local playerPed = PlayerPedId()

        local coords = GetEntityCoords(playerPed)
        if sellna == false then break end
        
        if GetDistanceBetweenCoords(coords, vector3(x, y, z), true) < 2.5 and IsPedInAnyVehicle(PlayerPedId()) == false then

            local selectItem = {}
            local selectItemForSelect = {}
            local luckyPer = {}
            for k, v in pairs(Config['sellDrug']) do
                table.insert(selectItem, v.sell['name'])
                table.insert(selectItemForSelect, v.sell['nameInGame'])
                table.insert(luckyPer, v.sell['luck'])
            end

            DrawTxtmaxez(Config.ItemsellText.x, Config.ItemsellText.y,
                         Config.ItemsellText.width, Config.ItemsellText.height,
                         Config.ItemsellText.scale, Config.TextselectA ..
                             selectItemForSelect[index] .. Config.TextselectB,
                         Config.ItemsellText.r, Config.ItemsellText.g,
                         Config.ItemsellText.b, Config.ItemsellText.a)

            if IsControlJustPressed(0, Keys[Config.KeysSelect]) then

                if index == #selectItemForSelect then
                    index = 1

                else
                    index = index + 1
                end
            end

            DrawTxtmaxez(Config.PresssellText.x, Config.PresssellText.y,
                         Config.PresssellText.width,
                         Config.PresssellText.height,
                         Config.PresssellText.scale, Config.Pressselect ..
                             Config.KeysSelectGo .. Config.Pressselect2,
                         Config.PresssellText.r, Config.PresssellText.g,
                         Config.PresssellText.b, Config.PresssellText.a)
            if IsControlJustReleased(0, Keys[Config.KeysSelectGo]) then
                timeoutna = false

                Processing(selectItem[index],luckyPer[index])

                break
            end

        end
    end
end

function Processing(name,luckValue) -- todo Game start
    HOLD = false

    local playerPed = PlayerPedId()
    local PlayerCoords = GetEntityCoords(PlayerPedId())
    removeprop()
    Changeprop()

    animazionePlayer()

    local luck = math.random(0, 100)
    
    if luck <= luckValue then

        TriggerServerEvent("Suphapong_sellDrug", name)

    else
        Citizen.CreateThread(function()
            while true do
                Citizen.Wait(0)
                local PlayerCoordsna = GetEntityCoords(PlayerPedId())
                if enought then break end

                if GetDistanceBetweenCoords(PlayerCoordsna, PlayerCoords, true) >
                    10 then

                    if Config.DeadorAlive then
                        local health = GetEntityHealth(PlayerPedId())
                        if health < 105 then break end
                        AddExplosion(PlayerCoordsna[1], PlayerCoordsna[2],
                                     PlayerCoordsna[3], Config.explosionType,
                                     Config.damageScale, Config.isAudible,
                                     false, 1)
                    else
                        SetEntityCoords(PlayerPedId(), PlayerCoords[1],
                                        PlayerCoords[2], PlayerCoords[3] + 1)
                    end
                end
            end
        end)

        TriggerEvent(Config.Alert, Config.AlertType)

        if Config.AlertPhone then
            PedPosition = GetEntityCoords(playerPed)
            local PlayerCoords = {
                x = PedPosition.x,
                y = PedPosition.y,
                z = PedPosition.z
            }
            TriggerServerEvent('esx_addons_gcphone:startCall', 'police', 'drug',
                               PlayerCoords, {
                PlayerCoords = {
                    x = PedPosition.x,
                    y = PedPosition.y,
                    z = PedPosition.z
                }
            })
        end

        FreezeEntityPosition(playerPed, true)
        TriggerEvent("mythic_progbar:client:progress", {
            name = Config.Labelname,
            duration = Config.fail * 1000,
            label = Config.Labelfail,
            useWhileDead = false,
            canCancel = false,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true
            }

        }, function(status)
            if not status then
                enought = true
                ClearPedTasks(playerPed)
                FreezeEntityPosition(playerPed, false)
                ClearPedTasks(playerPed)
            end
        end)
    end
end

function removeprop()
    local ped = GetPlayerPed(-1)
    local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
    local object = GetClosestObjectOfType(position.x, position.y, position.z,5.0, GetHashKey(Config.prop), false,false, false)
    if object ~= 0 then DeleteObject(object) end
    --
    local x, y, z = table.unpack(GetEntityCoords(ped))
    local prop = CreateObject(GetHashKey(Config.prop), x, y, z + 0.2, true,
                              true, true)
    local boneIndex = GetPedBoneIndex(ped, 57005)
    AttachEntityToEntity(prop, ped, boneIndex, 0.16, 0.00, 0.00, 410.0, 20.00,
                         140.0, true, true, false, true, 1, true)
    ClearPedTasks(ped)

    DetachEntity(prop, ped, boneIndex, 0.16, 0.00, 0.00, 410.0, 20.00, 140.0,
                 true, true, false, true, 1, true)
    DeleteObject(prop)
end

function Changeprop()
    local ped = GetPlayerPed(-1)
    local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
    local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.trade), false,false, false)

    if object ~= 0 then DeleteObject(object) end

    local x, y, z = table.unpack(GetEntityCoords(ped))

    local prop = CreateObject(GetHashKey(Config.trade), x, y, z + 0.2, true,true, true)

    local boneIndex = GetPedBoneIndex(ped, 57005)
        AttachEntityToEntity(prop, ped, boneIndex, 0.16, 0.00, 0.00, 410.0, 20.00, 140.0, true, true, false, true, 1, true)
end

function animazionePlayer()

    local xplayer = PlayerPedId()

    RequestAnimDict(Config.RequestAnimDict)
    while (not HasAnimDictLoaded(Config.RequestAnimDict)) do Citizen.Wait(0) end
    Wait(100)
    TaskPlayAnim(ped, Config.RequestAnimDict, Config.TaskPlayAnim, 20.0, -20.0, -1, 0, 0, false, false, false)
    TaskPlayAnim(xplayer, Config.RequestAnimDict, Config.TaskPlayAnim, 20.0, -20.0, -1, 0, 0, false, false, false)

    Citizen.Wait(1000)

    Citizen.Wait(1000)

    ClearPedTasks(ped)
    FreezeEntityPosition(ped, false)
    ClearPedTasks(ped)
    print("check1")
    print("hello12 ",ped)
    ClearPedTasks(xplayer)
    FreezeEntityPosition(xplayer, false)
    ClearPedTasks(xplayer)
    removeprop2()
    RemoveBlip(liv)
    SetPedAsNoLongerNeeded(ped)
end

function removeprop2()
    local ped = GetPlayerPed(-1)
    local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
    local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.trade), false, false, false)
    if object ~= 0 then DeleteObject(object) end
    --
    local x, y, z = table.unpack(GetEntityCoords(ped))
    local prop = CreateObject(GetHashKey(Config.trade), x, y, z + 0.2, true , true, true)
    local boneIndex = GetPedBoneIndex(ped, 57005)

    AttachEntityToEntity(prop, ped, boneIndex, 0.16, 0.00, 0.00, 410.0, 20.00, 140.0, true, true, false, true, 1, true)
    ClearPedTasks(ped)

    DetachEntity(prop, ped, boneIndex, 0.16, 0.00, 0.00, 410.0, 20.00, 140.0,true, true, false, true, 1, true)
    DeleteObject(prop)
end

RegisterNetEvent("SPG_HOLDPROP")
AddEventHandler("SPG_HOLDPROP", function()
    TriggerEvent('esx_inventoryhud:closeHud')

    if not HOLD then 


        HOLD = true
        sellna = true
        timeoutna = true

        exports.pNotify:SendNotification({
            text = Config.text,
            type = Config.texttype,
            timeout = Config.texttime * 1000,
            layout = Config.textlaout
        })

        local ped = GetPlayerPed(-1)
        local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
        local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop), false, false, false)

        if object ~= 0 then DeleteObject(object) end

        local x, y, z = table.unpack(GetEntityCoords(ped))
        local prop = CreateObject(GetHashKey(Config.prop), x, y, z + 0.2, true, true, true)
        local boneIndex = GetPedBoneIndex(ped, 57005)
        AttachEntityToEntity(prop, ped, boneIndex, 0.16, 0.00, 0.00, 410.0, 20.00, 140.0, true, true, false, true, 1, true)

    end

    Citizen.Wait(Config.timeSell * 1000)

    if HOLD and sellna and timeoutna then
        exports.pNotify:SendNotification({
            text = Config.timeoutText,
            type = Config.timeouttype,
            timeout = Config.timeouttime * 1000,
            layout = Config.timeoutlaout
        })
        local playerPed = PlayerPedId()
        removeprop()
        Changeprop()

        ClearPedTasks(ped)
        FreezeEntityPosition(ped, false)
        ClearPedTasks(ped)

        ClearPedTasks(xplayer)
        FreezeEntityPosition(xplayer, false)
        ClearPedTasks(xplayer)
        removeprop2()
        RemoveBlip(liv)
        SetPedAsNoLongerNeeded(ped)

        sellna = false
        HOLD = false
        RemoveBlip(liv)
        local ped = GetPlayerPed(-1)
        local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
        local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop), false, false, false)

        if object ~= 0 then DeleteObject(object) end

        local x, y, z = table.unpack(GetEntityCoords(ped))
        local prop = CreateObject(GetHashKey(Config.prop), x, y, z + 0.2, true, true, true)
        local boneIndex = GetPedBoneIndex(ped, 57005)
        AttachEntityToEntity(prop, ped, boneIndex, 0.16, 0.00, 0.00, 410.0, 20.00, 140.0, true, true, false, true, 1, true)
        ClearPedTasks(ped)

        DetachEntity(prop, ped, boneIndex, 0.16, 0.00, 0.00, 410.0, 20.00, 140.0, true, true, false, true, 1, true)
        local playerPed = PlayerPedId()
        removeprop()
        Changeprop()
        DeleteObject(prop)
        ClearPedTasks(ped)
        FreezeEntityPosition(ped, false)
        ClearPedTasks(ped)

        ClearPedTasks(xplayer)
        FreezeEntityPosition(xplayer, false)
        ClearPedTasks(xplayer)
        removeprop2()
        RemoveBlip(liv)
        SetPedAsNoLongerNeeded(ped)

        TriggerEvent('SPG_StartSell')

    end
end)

RegisterFontFile(Config.Font)
fontId = RegisterFontId(Config.Font)

function DrawTxtmaxez(x, y, width, height, scale, text, r, g, b, a)
    SetTextFont(fontId)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width / 2, y - height / 2 + 0.005)
end
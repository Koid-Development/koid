--[[
    AUTHOR: Joordih - joordih.me 2023 © All rights reserved
    GITHUB: https://github.com/HarpyLMAO
    CREATED AT: 24/07/2023
    PROJECT: koid-core | player.lua
--]]

KoidCore.Player = {}


function KoidCore.Player:getCoords(vec4)
    local coordinates = GetEntityCoords(PlayerPedId())

    if (vec4) then
        local headcoords = GetEntityHeading(PlayerPedId())
        return vector4(coordinates.x, coordinates.y, coordinates.z)
    else 
        return vector3(coordinates.x, coordinates.y, coordinates.z)
    end    
end


function KoidCore.Player:playAnimation(dictionary, animation)
    Citizen.CreateThread(function ()
        RequestAnimDict(dictionary)
        while (not HasAnimDictLoaded(dictionary)) do
            Citizen.Wait(0)
        end

        local player = PlayerPedId()
        TaskPlayAnim(player, dictionary, animation, 8.0, 8.0, 3000, 48, 1, false, false, false)
    end)
end

function KoidCore.Player:stopAnimation()
    local player = PlayerPedId()
    FreezeEntityPosition(player, false)
end

function KoidCore.Player:teleport(coords)
    SetEntityCoords(PlayerPedId(), coords.x, coords.y, coords.z, false, false, false, false)
end

function KoidCore.Player:getData()
    return ESX.GetPlayerData()
end


function KoidCore.Player:notify()
    -- Soon because i'll create my own notificatin system.
end

function KoidCore.Player:getIdentity()
    local playerData = KoidCore.Player:getData()

    return {
        identifier = playerData.identifier,
        firstname = playerData.firstname,
        lastname = playerData.lastname,
        birthday = playerData.birthday,
        sex = playerData.sex,
    }
end

function privateMoneyObjectCreator()
    local playerAccounts = KoidCore.Player:getData().accounts
    local obj = {}

    for i=1, #playerAccounts do
        local current = playerAccounts[i]

        if(current.name == Config.Moneys.types.bank) then
            obj.bank = current.money
        elseif current.name == Config.Money.types.cash then
            obj.cash = current.money
        elseif current.name == Config.Moneys.types.black_cash then
            obj.black_cash = current.money
        end
    end

    return obj
end

function KoidCore.Player:getMoneyFrom(account)
    local obj = privateMoneyObjectCreator()

    return KoidCore.switch(account, {
        { Config.Money.types.cash, function () return obj.cash end },
        { Config.Money.types.bank, function () return obj.ba end },
        { Config.Money.types.black_cash, function () return obj.black_cash end },
    })
end

function KoidCore.Player:getMoneys() 
    return privateMoneyObjectCreator()
end

function KoidCore.Player:getInventory()
    local playerInventory = KoidCore.Player.getData().getInventory()
    local data = {}

    for i = 1, #playerInventory do
        local value = playerInventory[i]

        if value.count > 0 then
            table.insert(data, {
                name = value.name,
                canRemove = value.canRemove,
                label = value.label,
                rare = value.rare,
                usable = value.usable,
                count = value.count,
                weight = value.weight
            })
        end
    end

    return data
end

function KoidCore.Player:getWeapons()
    return KoidCore.Player:getData().getWeapons()
end

function KoidCore.Player:getJob()
    return KoidCore.Player:getData().getJob()
end

setmetatable(KoidCore, { __index = KoidCore.Player })



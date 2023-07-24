--[[
    AUTHOR: Joordih - joordih.me 2023 © All rights reserved
    GITHUB: https://github.com/HarpyLMAO
    CREATED AT: 24/07/2023
    PROJECT: koid-core | game.lua
--]]

KoidCore.Game = {}

function KoidCore.Game:helpNotify(msg)
    ESX.ShowHelpNotification(msg, false, false, -1)
end

function KoidCore.Game:Trigger(event, ...)
    TriggerServerEvent(event, ...)
end

function KoidCore.Game:getClosestObject()
    return ESX.Game.GetClosestObject()
end

function KoidCore.Game:getClosestPlayer(dist)
    local player, distance = ESX.Game.GetClosestPlayer()

    if(dist and distance <= dist and player ~= -1) then
        return player
    --- a change pour ~= -1
    elseif player ~= -1 then
        return player
    else
        return nil
    end
end

function KoidCore.Game:create3dText(text, coords, color, size, center)
    ESX.Game.Utils.DrawText3D(coords, text, 2.0, 1)
end

function KoidCore.Game:createMarker(id, coords, color, canJump, canRotate)
    return DrawMarker(id or 1, coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 0.0,
            0.0, 0.0, 0.5, 0.5, 0.5, color.r, color.g, color.b, color.a,
            canJump or 0, 1, 2, canRotate or 0, nil,
            nil, 0
    )
end



function KoidCore.Game:createBlip(blip)
    local new_blip = AddBlipForCoord(blip.coords.x, blip.coords.y, blip.coords.z)
    SetBlipSprite(new_blip, blip.id)
    SetBlipDisplay(new_blip, 4)
    SetBlipScale(new_blip, 1.0)
    SetBlipColour(new_blip, blip.color)
    SetBlipAsShortRange(new_blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(blip.title)
    EndTextCommandSetBlipName(new_blip)

    return new_blip
end

function KoidCore.Game:deleteBlip(blip)
    RemoveBlip(blip)
end

setmetatable(KoidCore, { __index = KoidCore.Game })
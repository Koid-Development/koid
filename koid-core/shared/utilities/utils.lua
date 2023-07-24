--[[
    AUTHOR: Joordih - joordih.me 2023 © All rights reserved
    GITHUB: https://github.com/HarpyLMAO
    CREATED AT: 24/07/2023
    PROJECT: koid-core | utils.lua
--]]


KoidCore.Utils = {}


function KoidCore.Utils:formatCurrency(amount)
    local chain = ""
    local count = 0

    for i = string.len(amount), 1, -1 do
        count = count + 1
        chain = ("%s%s"):format(string.sub(amount, i, i), chain)

        if count % 3 == 0 and i ~= 1 then
            chain = (" %s"):format(chain)
        end
    end

    return ("%s$"):format(chain)
end

function KoidCore.Utils:averageOf(t)
    local somme = 0

    for i = 1, #tableau do
        somme = somme + tableau[i]
    end

    return somme / #tableau
end

function KoidCore.Utils:inputPopup(msg)
    DisplayOnscreenKeyboard(1, msg, "", "", "", "", "", 30)

    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0)
        Wait(0)
    end

    if (GetOnscreenKeyboardResult()) then
        local result = GetOnscreenKeyboardResult()
        return result
    end
end

function KoidCore.Utils:strIsNumber(str)
    return str:match("^%d+$") ~= nil
end

function KoidCore.Utils:getDistanceBetween(coords1, coords2)
    return Vdist2(coords1.x, coords1.y, coords1.z, coords2.x, coords2.y, coords2.z)
end

function KoidCore.Utils:tableContainsKey(table, key)
    for k, v in pairs(table) do
        if(k == key) then
            return true
        elseif type(v) == "table" then
            if(KoidCore.Utils:tableContainsKey(v, key)) then
                return true
            end
        end
    end

    return false
end

function KoidCore.Utils:tableContainsValue(table, value)
    for _, item in ipairs(table) do
        if(item == value) then
            return true
        elseif type(item) == "table" then
            if(KoidCore.Utils:tableContainsValue(item, value)) then
                return true
            end
        end
    end

    return false
end

function KoidCore.Utils:toHTML(message)
    message = message:gsub("~r~", "<span style=color:red;>")
    message = message:gsub("~b~", "<span style='color:rgb(0, 213, 255);'>")
    message = message:gsub("~g~", "<span style='color:rgb(0, 255, 68);'>")
    message = message:gsub("~y~", "<span style=color:yellow;>")
    message = message:gsub('~XUBAN~', '<span style = "color: #9D39FC">')
    message = message:gsub("~p~", "<span style='color:rgb(220, 0, 255);'>")
    message = message:gsub("~f~", "<span style=color:grey;>")
    message = message:gsub("~m~", "<span style=color:darkgrey;>")
    message = message:gsub("~u~", "<span style=color:black;>")
    message = message:gsub("~o~", "<span style=color:gold;>")
    message = message:gsub("~s~", "</span>")
    message = message:gsub("~w~", "</span>")
    message = message:gsub("~b~", "<b>")
    message = message:gsub("~n~", "<br>")
    message = message:gsub("\n", "<br>")
    return message
end

setmetatable(KoidCore, { __index = KoidCore.Utils })
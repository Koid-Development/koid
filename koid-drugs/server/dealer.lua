ESX = exports["es_extended"]:getSharedObject()

RegisterServerEvent('koid-drugs:sell')
AddEventHandler('koid-drugs:sell', function (item, price, count)
    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.removeInventoryItem(item, count)
    xPlayer.addAccountMoney('black_money', tonumber(price))
    xPlayer.showNotification("Has vendido " .. count .. " de " .. item .. " por " .. price .. "$ de dinero negro!")
end)

ESX.RegisterServerCallback("koid-drugs:getPlayerInventory",
    function(source, cb)
        local xPlayer = ESX.GetPlayerFromId(source)

        print(json.encode(xPlayer.getInventory(true)))
        cb(json.encode(xPlayer.getInventory(true)))
    end
)
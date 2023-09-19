local ESX = exports["es_extended"]:getSharedObject()

RegisterServerEvent('koid-drugs:washMoney')
AddEventHandler('koid-drugs:washMoney', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local dirtyMoney = xPlayer.getAccount('black_money').money

    if dirtyMoney > 0 then
        local washedMoney = math.floor(dirtyMoney * Config.Other.MoneyWash.percent / 100)

        xPlayer.removeMoney(moneyWashed)
        xPlayer.removeAccountMoney('black_money', moneyWashed)
        xPlayer.addMoney(washedMoney)
        xPlayer.showNotification("Has lavado ~q~$" .. moneyWashed)
    else
        xPlayer.showNotification("No tienes suficiente dinero para lavar")
    end
end)

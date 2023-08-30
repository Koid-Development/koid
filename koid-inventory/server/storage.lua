ESX.RegisterServerCallback("esx_inventoryhud:getStorageInventory", function(source, cb, storage)
    local targetXPlayer = ESX.GetPlayerFromId(target)
    local weapons, items, blackMoney

    TriggerEvent("esx_datastore:getSharedDataStore", storage, function(store)
        weapons = store.get('weapons') or {}

        TriggerEvent("esx_addoninventory:getSharedInventory", storage, function(inventory)
            items = inventory.items or {}

            TriggerEvent("esx_addonaccount:getSharedAccount", storage .. "_blackMoney", function(account)
                if account ~= nil then
                    blackMoney = account.money
                else
                    blackMoney = 0
                end

                cb({inventory = items, blackMoney = blackMoney, weapons = weapons})
            end)
        end)
    end)
end)

RegisterServerEvent("esx_inventoryhud:getStorageItem")
AddEventHandler("esx_inventoryhud:getStorageItem", function(storage, type, item, count)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if type == "item_standard" then
        local sourceItem = xPlayer.getInventoryItem(item)

        TriggerEvent("esx_addoninventory:getSharedInventory", storage, function(inventory)
            local inventoryItem = inventory.getItem(item)

            if count > 0 and inventoryItem.count >= count then
                if xPlayer.canCarryItem(item, count) then
                    inventory.removeItem(item, count)
                    xPlayer.addInventoryItem(item, count)

                    TriggerClientEvent("esx:showNotification", _source, 'Has sacado ' .. count .. ' ' .. inventoryItem.label)
                else
                    TriggerClientEvent("esx:showNotification", _source, 'No tienes espacio en el inventario')
                end
            end
        end)
    elseif type == "item_account" then
        TriggerEvent("esx_addonaccount:getSharedAccount", storage .. "_blackMoney", function(account)
            local roomAccountMoney = account.money

            if roomAccountMoney >= count then
                account.removeMoney(count)
                xPlayer.addAccountMoney(item, count)
            else
                TriggerClientEvent("esx:showNotification", _source, 'Cantidad invalida')
            end
        end)
    elseif type == "item_weapon" then
        TriggerEvent('esx_datastore:getSharedDataStore', 'society_police', function(store)
            local storeWeapons = store.get('weapons') or {}
            local weaponName = nil
            local ammo = nil
            local components = {}

            for i = 1, #storeWeapons, 1 do
                if storeWeapons[i].name == item then
                    weaponName = storeWeapons[i].name
                    ammo = storeWeapons[i].ammo

                    if storeWeapons[i].components ~= nil then
                        components = storeWeapons[i].components
                    end

                    table.remove(storeWeapons, i)
                    break
                end
            end

            TriggerClientEvent("esx:showNotification", _source, 'Has guardado una ' .. weaponName .. ' con ' .. ammo .. ' balas')
            store.set("weapons", storeWeapons)
            xPlayer.addWeapon(weaponName, ammo)

            for i = 1, #components do
                xPlayer.addWeaponComponent(weaponName, components[i])
            end
        end)
    end
end)

RegisterServerEvent("esx_inventoryhud:putStorageItem")
AddEventHandler("esx_inventoryhud:putStorageItem", function(storage, type, item, count)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if type == "item_standard" then
        local playerItemCount = xPlayer.getInventoryItem(item).count

        if playerItemCount >= count and count > 0 then
            TriggerEvent(
                "esx_addoninventory:getSharedInventory",
                storage,
                function(inventory)
                    xPlayer.removeInventoryItem(item, count)
                    inventory.addItem(item, count)

                    local inventoryItem = inventory.getItem(item)

                    TriggerClientEvent("esx:showNotification", _source, 'Has depositado ' .. count .. ' ' .. inventoryItem.label)
                end
            )
        else
            xPlayer.showNotification(_U("bad_amount"))
        end
    elseif type == "item_account" then
        local playerAccountMoney = xPlayer.getAccount(item).money

        if playerAccountMoney >= count and count > 0 then
            xPlayer.removeAccountMoney(item, count)

            TriggerEvent(
                "esx_addonaccount:getSharedAccount",
                storage .. "_blackMoney",
                function(account)
                    account.addMoney(count)
                end
            )
        else
            xPlayer.showNotification(_U("bad_amount"))
        end
    elseif type == "item_weapon" then
        TriggerEvent('esx_datastore:getSharedDataStore', 'society_police', function(store)
            local weapons = store.get('weapons') or {}
            local pos, playerWeapon = xPlayer.getWeapon(item)
            
            local components = playerWeapon.components

            if components == nil then
                components = {}
            end

            TriggerClientEvent("esx:showNotification", _source, 'Has guardado una ' .. xPlayer.loadout[pos].label .. ' con ' .. count .. ' balas')
            table.insert(weapons, {name = item, ammo = count, components = components})
            store.set('weapons', weapons)
            xPlayer.removeWeapon(item)
        end)
    end
end)